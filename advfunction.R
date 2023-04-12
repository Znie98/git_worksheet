# code along ----
# to test making our own method

# make an example vector
test_vec = c(TRUE, FALSE, TRUE, TRUE, FALSE)

# assign this example vector a class
class(test_vec) = "Apple"

# make a print method "apple" class
print.Apple = function(x){
  
  cat("B) You've got this! \n")
  cat(x)
  
}
print(test_vec)


# worksheet ----
field = plant("carrot", "apple", "strawberry")

# create harvest generic function
harvest.apple =
  function(x){
    
  }

