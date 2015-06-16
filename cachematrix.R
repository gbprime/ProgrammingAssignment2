## #############################################################################################
## Matrix inversion is usually a costly computation and there may be some benefit to 
## caching the inverse of a matrix rather than compute it repeatedly. 
## 
## This R script containts a pair of functions that provide the inverse of a matrix and
## caches it for later use.
##
## checkValidity() is used to test whether or not the inverse is correct.
## 
## Created by: Gabriel Becerra
## Create on: June 16, 2015
## Modified on: 
## #############################################################################################

# This function creates a special "matrix" object that can cache its inverse.
# This function stores and returns a list of functions.
makeCacheMatrix <- function (xMatrix = matrix()) {
  # creating the generic object that will store the inverse of the given matrix.
  inverseMatrix <- NULL;
  
  # setter function for the original matrix
  set <- function(yMatrix) {
    xMatrix <<- yMatrix # setting the info
    inverseMatrix <<- NULL; # no inverse... set to null
  }
  # getter function for the original matrix
  # returns the original matrix
  get <- function() {
    return(xMatrix);
  }
  
  # setter function for the inverse matrix
  setInverse <- function(inv) { 
    inverseMatrix <<- inv; 
  }
  # getter function for the inverse matrix
  getInverse <- function() {
    return(inverseMatrix);
  } 
  
  # returning the list of functions accessible through the parent function
  # the child funtions are accessible by name via the "$" operatos or by index "[]"
  return(list(set = set, get = get, setInverse = setInverse, getInverse = getInverse));
}

# If the comparison with the identity matrix returns a matrix whose elements are all TRUE,
# then the inverse is trully the inverse of the given matrix.
# (note: the identity matrix is given by the diag() function)
isValid <- function(mtxObject) {
  mtx <- mtxObject$get();
  correctness <- round(mtxObject$getInverse() %*% mtxObject$get(), 2) == 
    diag(nrow = nrow(mtx), ncol = ncol(mtx));
  
  return(all(correctness));
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
    inverse <- solve(data);
    
    # storing the inverse
    mtx$setInverse(inverse);
    
    if (isValid(mtx)) {
      #correctness <- round(mtx$get() %*% inverse, 2);
      #print(correctness);
      
      # returns the inverse of "mtx"
      return(mtx$getInverse());
    } else {
      message("Comparison with identity matrix failed.")
      return(NULL);
    }
  }
}