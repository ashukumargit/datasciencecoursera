## This function creates a special matrix object that can cache its inverse.
## The function returns a list containing functions to set the matrix, 
## get the matrix, set the inverse and get the inverse.
## the  list is used as the input to cacheSolve()
makeCacheMatrix <- function(x = matrix()) {
  inv = NULL
  set = function(y) {
    ## Assigning a value to an object in an environment 
    ## different from the current environment. 
    x <<- y
    inv <<- NULL
  }
  get = function() x
  setinv = function(inverse) inv <<- inverse 
  getinv = function() inv
  list(set=set, get=get, setinv=setinv, getinv=getinv)
}
## this function returns inverse of the original matrix input to makeCacheMatrix()

cacheSolve <- function(x, ...) {
  inv = x$getinv()
      if (!is.null(inv)){
    ## if the inverse has already been calculated
    ## get it from the cache and skips the computation. 
    ## otherwise, calculates the inverse 
    message("Pulling cached data")
    return(inv)
  }
   mat.data = x$get()
   inv = solve(mat.data, ...)
   ## sets the value of the inverse in the cache via the setinv function.
  x$setinv(inv)
  
  return(inv) 
  }
