### Introduction

This second programming assignment presents an R
function that is able to cache time-consuming computation. This
Programming Assignment takes advantage of the scoping rules of
the R language and how they can be manipulated to preserve state inside
of an R object.

### Usage

It is very easy to use this small application.  

1. Instantiate a matrix object: `x <- matrix(rnorm(25), nrow = 5)`
2. Instantiate a makeCacheMatrix object by passing the original matrix 'x': `mcx <- makeCacheMatrix(x)`
3. Test by using the 'get' method: `mcx$get()`
4. Call cacheSolve() with the mcx object.  If the inverse isn't null, then you'll see the cached value; otherwise, you'll see the new inverse: `cacheSolve(mcx)`
5. call it again to see if the cached value is returned

[Note: Validity is tested before the inverse is created and cached.  Check `isValid()` for more info]

### Example: Caching the Inverse of a Matrix

Matrix inversion is usually a costly computation and there may be some
benefit to caching the inverse of a matrix rather than computing it
repeatedly.

1.  `makeCacheMatrix`: This function creates a special "matrix" object
    that can cache its inverse.
2.  `cacheSolve`: This function computes the inverse of the special
    "matrix" returned by `makeCacheMatrix` above. If the inverse has
    already been calculated (and the matrix has not changed), then
    `cacheSolve` should retrieve the inverse from the cache.

The `<<-` operator is used to
assign a value to an object in an environment that is different from the
current environment.

The first function, `makeCacheMatrix` creates a special "vector", which is
really a list containing a function to

1.  set the value of the matrix
2.  get the value of the matrix
3.  set the value of the inverse
4.  get the value of the inverse

The second function calculates the inverse of the given matrix. However, it 
first checks to see if the
inverse has already been calculated. If so, it `get`s the mean from the
cache and skips the computation. Otherwise, it calculates the inverse of
the matrix and sets the value of the inverse in the cache via the `setInverse`
function.

### Assignment: Caching the Inverse of a Matrix

Computing the inverse of a square matrix can be done with the `solve`
function in R. For example, if `X` is a square invertible matrix, then
`solve(X)` returns its inverse.

For this assignment, assume that the matrix supplied is always
invertible.

In order to complete this assignment, you must do the following:

1.  Fork the GitHub repository containing the stub R files at
    [https://github.com/rdpeng/ProgrammingAssignment2](https://github.com/rdpeng/ProgrammingAssignment2)
    to create a copy under your own account.
2.  Clone your forked GitHub repository to your computer so that you can
    edit the files locally on your own machine.
3.  Edit the R file contained in the git repository and place your
    solution in that file (please do not rename the file).
4.  Commit your completed R file into YOUR git repository and push your
    git branch to the GitHub repository under your account.
5.  Submit to Coursera the URL to your GitHub repository that contains
    the completed R code for the assignment.

### Grading

This assignment will be graded via peer assessment.
