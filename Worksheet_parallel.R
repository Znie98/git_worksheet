# Code Along----

# test my laptop and see how it can parallelize

library(tictoc)
library(future.apply)


## sequential ----
num_vec = c(1,2,3,4,5)
# start timer 
tic()

sapply(num_vec, FUN = function(digit){
  
  # speak message
  print(paste0("Your lucky number is ", digit))
  
  # wait
  Sys.sleep(digit)
  
  # return
  return(digit)
  
})

# end timer
toc()

## parallel ----

# in future.apply package to plan the way of paralleling
plan(multisession)


num_vec = c(1,2,3,4,5)
# start timer 
tic()

future_sapply(num_vec, FUN = function(digit){
  
  # speak message
  print(paste0("Your lucky number is ", digit))
  
  # wait
  Sys.sleep(digit)
  
  # return
  return(digit)
  
})

# end timer
toc()


# Worksheet ----
# Function taken from John on this stack overflow post
# https://stackoverflow.com/questions/3789968/generate-a-list-of-primes-up-to-a-certain-number
getPrimeNumbers <- function(n, dead_weight) {  
  n <- as.integer(n)
  if(n > 1e6) stop("n too large")
  primes <- rep(TRUE, n)
  primes[1] <- FALSE
  last.prime <- 2L
  for(i in last.prime:floor(sqrt(n)))
  {
    primes[seq.int(2L*last.prime, n, last.prime)] <- FALSE
    last.prime <- last.prime + min(which(primes[(last.prime+1):n]))
  }
  which(primes)
}

# load in tictoc for easy benchmarking
library(tictoc)

# start timer
tic()

# set our vector to iterate through
num_vec = 10:9001

### sequential ----

# get primes
for(i in num_vec){
  primes = getPrimeNumbers(i)
}

# stop timer
toc()

#39.077 seconds

### parallel (sapply) ----
# start timer
tic()

# set our vector to iterate through
num_vec = 10:9001

# get primes
primes = sapply(num_vec, getPrimeNumbers)

# stop timer
toc()

#33.698 sec elapsed

# Get the number of cores on this machine
parallel::detectCores()

# the max cores we should possibly use
max_safe = parallel::detectCores() - 1

### parallel(2 cores) ----
# load the package
library(future.apply)

# set our plan
plan(multisession, workers = 2)

# start timer
tic()

# set our vector to iterate through
num_vec = 10:9001

# get primes
primes = future_sapply(num_vec, getPrimeNumbers)

# stop timer
toc()
# 27.139 sec elapsed


### parallel (3 cores) ----
# start timer
tic()

# change out plan to 3 workers
plan(multisession, workers = 3)

# set our vector to iterate through
num_vec = 10:9001

# get primes
primes = future_sapply(num_vec, getPrimeNumbers)

# stop timer
toc()

# 21.427 sec elapsed


### parallel (7 cores) ----
# start timer
tic()

# change out plan to max safe workers
plan(multisession, workers = max_safe)

# set our vector to iterate through
num_vec = 10:9001

# get primes
primes = future_sapply(num_vec, getPrimeNumbers)

# stop timer
toc()
# 13.992 sec elapsed
