# Gary Koplik
# Fall, 2017
# spectral_clustering_algorithm.R

# load libraries
library(fields)

# spectral clustering function
# inputs:
#   data - data matrix where each row is a data point
#   sigma - dictates the exponential die-down of weights between points
#   k - number of clusters
# output:
#   numeric vector of values 1, 2, ... , k
#     which assign each point to a cluster
spectral_clustering <- function(data, sigma, k){
  # create euclidean distance matrix for data
  edm <- rdist(data)
  
  # create the weight matrix
  #   with weights Gaussian similarity function
  #   as described in von Luxburg (2007)
  weight_matrix <- exp(-edm / 2*sigma^2)
  
  # create the degree matrix
  #   which is diagonal
  #   with the ii^th term = sum of the weights connected to the i^th vertex
  degree_matrix <- diag(rowSums(weight_matrix))
  
  # laplacian matrix is degree matrix - weight matrix
  laplacian_matrix <- degree_matrix - weight_matrix
  
  # find eigenspace of the laplacian
  #   (taking advantage of symmetric matrix to speed up computation time)
  eigenspace <- eigen(laplacian_matrix, symmetric = T)
  
  # grab the k smallest eigenvectors
  #   note these are stored as the last columns of the matrix
  relevant_eigenvectors <- data.frame(eigenspace$vectors[ , (nrow(data) - k + 1): nrow(data)])
  
  # cluster the k-dimensional points (rows of the matrix of eigenvectors we just stored)
  #   using k-means with the same number (k) clusters
  relevant_eigenvectors$color <- kmeans(relevant_eigenvectors, centers = k)$cluster
}


