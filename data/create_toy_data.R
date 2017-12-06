# Gary Koplik
# Fall, 2017
# create_toy_data.R

# confirm can run from scratch by clearing old work
rm(list = ls())

# load libraries
library(ggplot2)
library(ggthemes)

# set seed for replicability
set.seed(27705)

#### ''nice'' example for k-means ####

# randomly generate 2 known clusters of data with minimal interference
x1 <- rnorm(n = 400, mean = 4, sd = 0.5)
y1 <- rnorm(n = 400, mean = 4, sd = 0.5)

x2 <- rnorm(n = 400, mean = 2, sd = 0.5)
y2 <- rnorm(n = 400, mean = 2, sd = 0.5)

x <- c(x1, x2)
y <- c(y1, y2)

temp <- data.frame(x, y)
# rename
kmeans_nice <- temp

save(kmeans_nice, file ="./kmeans_nice.Rdata")


ggplot(kmeans_nice) +
  geom_point(aes(y = y, x = x), alpha = 0.5, size = 0.25) +
  xlim(0, 6) +
  ylim(0, 6) +
  coord_equal(ratio = 1) +
  theme_bw() +
  theme(
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank())


#### bad example for k-means ####

# generate 2 parabolas of data

num_points <- 400

x1 <- runif(n = num_points, min = 2, max = 4)
# make y fit along parabola plus some noise
y1 <- -1.5*(x1 - 3)^2 + 4 + runif(n = num_points, -0.2, 0.2)
# add horizontal noise
x1 <- x1 + runif(n = num_points, -0.1, 0.1)

x2 <- runif(n = num_points, min = 3, max = 5)
# make y fit along parabola plus some noise
y2 <- 1.5*(x2 - 4)^2 + 1.5 + runif(n = num_points, -0.2, 0.2)
# add horizontal noise
x2 <- x2 + runif(n = num_points, -0.1, 0.1)

x <- c(x1, x2)
y <- c(y1, y2)

temp <- data.frame(x, y)
kmeans_mean_half_moons <- temp

save(kmeans_mean_half_moons, file ="./kmeans_mean_half_moons.Rdata")


ggplot(temp) +
  geom_point(aes(y = y, x = x), alpha = 0.5, size = 0.25) +
  xlim(1, 6) +
  ylim(0, 5) +
  coord_equal(ratio = 1) +
  theme_bw() +
  theme(
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank())

# generate circles one contained in the other

num_data <- 500

theta1 <- runif(n = num_data, min = 0, max = 2*pi)
theta2 <- runif(n = num_data, min = 0, max = 2*pi)

x1 <- cos(theta1) + runif(n = num_data, min = -0.2, max = 0.2) + 3
x2 <- 2*cos(theta2) + runif(n = num_data, min = -0.2, max = 0.2) + 3

y1 <- sin(theta1) + runif(n = num_data, min = -0.2, max = 0.2) + 3
y2 <- 2*sin(theta2) + runif(n = num_data, min = -0.2, max = 0.2) + 3

x <- c(x1, x2)
y <- c(y1, y2)

kmeans_mean_circles <- data.frame(x, y)

save(kmeans_mean_circles, file = "./kmeans_mean_circles.Rdata")

ggplot(kmeans_mean_circles) +
  geom_point(aes(y = y, x = x), alpha = 0.5, size = 0.25) +
  xlim(0, 6) +
  ylim(0, 6) +
  coord_equal(ratio = 1) +
  theme_bw() +
  theme(
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank())



