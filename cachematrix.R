## #############################################################################################
## Matrix inversion is usually a costly computation and there may be some benefit to 
## caching the inverse of a matrix rather than compute it repeatedly. 
## 
## This R script containts a pair of functions that provide the inverse of a matrix and
## caches it for later use.
## 
## Created by: Gabriel Becerra
## Create on: June 16, 2015
## Modified on: 
## #############################################################################################

library('MASS')

# This function creates a special "matrix" object that can cache its inverse.
# This function stores and returns a list of functions.
makeCacheMatrix <- function (xMatrix = matrix()) {
  # creating the generic object that will store the inverse of the given matrix.
  inverseMatrix <- NULL
  
  # setter function
  # stores the original matrix
  set <- function(yMatrix) {
    xMatrix <<- yMatrix # setting the info
    inverseMatrix <<- NULL; # no inverse... set to null
  }
  # getter function
  # returns the original matrix
  get <- function() {
    return(xMatrix);
  }
  
  setInverse <- function(inv) { 
    inverseMatrix <<- inv; 
  }
  getInverse <- function() {
    return(inverseMatrix);
  } 
  
  # returning the list of functions accessible through the parent function
  # the child funtions are accessible by name via the "$" operatos or by index "[]"
  return(list(set = set, get = get, setInverse = setInverse, getInverse = getInverse));
}

# If the identity matrix is returned, then we know that the inverse was computed properly.
# returns the identity matrix (hopefully)
checkValidity <- function(mtx) {
  #correctness <- (inv %*% mtx) == diag(nrow = nrow(mtx), ncol = ncol(mtx));
  correctness <- round(mtx$getInverse() %*% mtx$get(), 2);
  return(correctness);
}

# This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
# If the inverse has already been calculated (and the matrix has not changed), then the 
# cachesolve should retrieve the inverse from the cache.
cacheSolve <- function(mtx, ...) {
  # get the inverse of "mtx" - if any...
  inverse <- mtx$getInverse();
  
  # if the inverse exists, then return it; otherwise, compute it and store it.
  if(!is.null(inverse)) { # inverse is in cache
    message("Getting cached data...")
    return(inverse);
  } else { # inverse hasn't been cached
    message("Not in cache. Calculating...")

    # deep copying the original matrix
    data <- mtx$get();
    
    # solving the inverse
    inverse <- ginv(data);
    
    # storing the inverse
    mtx$setInverse(inverse);
    
    #correctness <- round(mtx$get() %*% inverse, 2);
    #print(correctness);
    
    # returns the inverse of "mtx"
    return(mtx$getInverse());
  }
}


