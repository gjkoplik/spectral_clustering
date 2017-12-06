# Gary Koplik
# Fall, 2017
# swissroll_plot.R

# this code loads in the swiss roll data set
#   is currently coded to implement spectral clustering using my algorithm
#   forces a stop in the code so you can compile some saved screenshots
#     into a GIF using imageMagick (see make_gif.txt for more)
#   and then reads in that gif from the same directory to clean up to make continuous
#     then resaves the final gif

# clear old code
rm(list = ls())

library(rgl)
library(KODAMA)
library(plotly)
library(webshot)
library(RSelenium)
library(magick)

source("./algorithms/spectral_clustering_algorithm.R")

num <- 4

# load in swiss roll data (named dat)
#   data generated using KODAMA's swissroll() function
load("./data/swiss_roll_data.Rdata")

dat$color_sc <- factor(spectral_clustering(dat,
                                    sigma = 3,
                                    k = num))

ax <- list(
  title = "",
  zeroline = FALSE,
  showline = FALSE,
  showticklabels = FALSE,
  showgrid = FALSE
)

p <- plot_ly(dat, x = ~x, y = ~y, z = ~z,
        type = "scatter3d",
        mode = "markers",
        color = ~color_sc,
        marker = list(size = 3)) %>%
  layout(scene = list(xaxis = ax, yaxis = ax, zaxis = ax))

p

# open up this thing at different angles and save screeenshots
#   to string together as a gif later
# help from:
# https://community.plot.ly/t/animation-of-3d-charts-specifically-rotation/2012
for(i in seq(0.0, 6.3, by = 0.1)){
  cam.zoom = 2.3
  ver.angle = 0
  graph <- plot_ly(dat, x = ~x, y = ~y, z = ~z,
                   type = "scatter3d",
                   mode = "markers",
                   color = ~color_sc,
                   marker = list(size = 3)) %>%
    layout(scene=list(camera = list(eye = list(x = cos(i)*cam.zoom,
                                               y = sin(i)*cam.zoom,
                                               z=0.2),
                                    center = list(x = 0,
                                                  y = 0,
                                                  z = 0
                                    )
                      ), xaxis = ax, yaxis = ax, zaxis = ax
    ), showlegend = FALSE
    )
  # open up webpage to take screenshot at angle
  rD <- rsDriver(verbose = F, port = 4444L)
  remDr <- rD$client
  if(10*i < 10){
    export(graph, file = paste("sc_",0, 10*i + 1,
                               ".png", sep = ""),
           selenium = rD)
  }
  if (10*i >= 10){
    export(graph, file = paste("sc_", 10*i + 1,
                               ".png", sep = ""),
           selenium = rD)    
  }
  # pause for a second so save has time to go through
  #   befor closing window
  Sys.sleep(2)
  # close server so can reopen for next one
  remDr$close()
  # stop selenium server
  # Sys.sleep(1)
  # rD$server$stop()
  rm(rD)
  gc()
}

print("These files save to Downloads by default")
print("I didn't figure out how to change the directory path")
print("So here I assume you stop the code (which I forced)")
print("and then you use magick to save the images as a gif")
print("command line code saved in make_gif.txt")
print("this assumes you then move that gif into this directory")
print("and call that gif 'animation.gif'")
stop()

frames <- image_read("./animation_sc.gif")

animation <- image_animate(frames[3:63], fps = 10)
image_write(animation, "./swiss_roll_sc_animate.gif")
