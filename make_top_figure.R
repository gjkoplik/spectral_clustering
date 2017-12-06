# Gary Koplik
# Fall, 2017
# make_top_figure.R

# makes the top figure on the Github pages html document (index.html)

# clear environment for replicability
rm(list = ls())

# load libraries
library(ggplot2)
library(ggthemes)
library(gridExtra)
# library(ggpubr)
library(cowplot)

# load in data
load("./data/kmeans_mean_half_moons.Rdata")
load("./data/kmeans_mean_circles.Rdata")

# run k-means on each example
kmeans_mean_half_moons$color <- kmeans(kmeans_mean_half_moons, centers = 2)$cluster
kmeans_mean_circles$color <- kmeans(kmeans_mean_circles, centers = 2)$cluster

half_moons <-
  ggplot(kmeans_mean_half_moons) +
  geom_point(aes(y = y, x = x, color = factor(color)), alpha = 0.8, size = 0.4) +
  xlim(1, 6) +
  ylim(0, 5) +
  coord_equal(ratio = 1) +
  labs(x = NULL, y = NULL) +
  theme_bw() +
  theme(legend.position = "none") +
  theme(
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank())

circles <-
  ggplot(kmeans_mean_circles) +
  geom_point(aes(y = y, x = x, color = factor(color)), alpha = 0.8, size = 0.4) +
  xlim(0, 6) +
  ylim(0, 6) +
  coord_equal(ratio = 1) +
  labs(x = NULL, y = NULL) +
  theme_bw() +
  theme(legend.position = "none") +
  theme(
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank())

# read in spectral clustering algorithm
source("./algorithms/spectral_clustering_algorithm.R")

# regrab the data sets (so the k-means color column is gone)
load("./data/kmeans_mean_half_moons.Rdata")
load("./data/kmeans_mean_circles.Rdata")

# run spectral clustering on half moons and circles
kmeans_mean_half_moons$color_sc <- spectral_clustering(kmeans_mean_half_moons,
                                                       sigma = 5,
                                                       k = 2)
kmeans_mean_circles$color_sc <- spectral_clustering(kmeans_mean_circles,
                                                    sigma = 5,
                                                    k = 2)

half_moons_sc <-
  ggplot(kmeans_mean_half_moons) +
  geom_point(aes(y = y, x = x, color = factor(color_sc)), alpha = 0.8, size = 0.4) +
  xlim(1, 6) +
  ylim(0, 5) +
  coord_equal(ratio = 1) +
  labs(x = NULL, y = NULL) +
  theme_bw() +
  theme(legend.position = "none") +
  theme(
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank())

circles_sc <-
  ggplot(kmeans_mean_circles) +
  geom_point(aes(y = y, x = x, color = factor(color_sc)), alpha = 0.8, size = 0.4) +
  xlim(0, 6) +
  ylim(0, 6) +
  coord_equal(ratio = 1) +
  labs(x = NULL, y = NULL) +
  theme_bw() +
  theme(legend.position = "none") +
  theme(
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank())


png("./top_figure.png")
ggdraw() +
  draw_plot(half_moons, x = 0, y = 0.5, width = 0.5, height = 0.5) +
  draw_plot(half_moons_sc, x = 0.5, y = 0.5, width = 0.5, height = 0.5) +
  draw_plot(circles, x = 0, y = 0, width = 0.5, height = 0.5) +
  draw_plot(circles_sc, x = 0.5, y = 0, width = 0.5, height = 0.5)
dev.off()
