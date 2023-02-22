#Q.1

# example 1
c(TRUE, 8) # will show 1, 8

# example 2
c("TRUE", FALSE) # will show "TRUE", "FALSE"

# example 3
c(F, F, F, T) #actually show FALSE FALSE TRUE TRUE

# example 4
c(TRUE, TRUE, TRUE, 1) # will show 1 1 1 1 

as.numeric(c("1", "8", "10"))
class(as.numeric(c("1", "8", "10")))


#Q.2

as.numeric(c("Will", "I", "work?"))
# show NA NA NA with warning mesage NAs introduced by coercion
test_vec = c(1, 3, 3, 7)
class(test_vec) = "character"


# Attributes

# make a named vector (weather forecast in degrees F)
named_vec = c("Mon" = 39, "Tues" = 36, "Wed" = 44, "Thur" = 36, "Fri" = 44, "Sat" = 45, "Sun" = 37)
named_vec

named_vec * 2


#We can see how these names are stored using the str() or “structure” function. 
#You may have used this to preview dataframes before. 
#In this case, we can see the vector, and beneath it is shows all the attributes attached to it.
str(named_vec)

# Attribute my custom attribute to named_vec
attr(named_vec, "clothes") = c("sweater", "hoodie", "sweater", "shirts", "Tshirt", "sweater", "jacket")


#List

# get the built in mtcars data
cars = mtcars

# subset suing $
mtcars$mpg
# subset using []
mtcars[, "mpg"]

# make an example list to work with
example_list = list("numbers" = c(1, 2, 5, 7, 3, 5),
                    "letters" = c("y", "u", "n", "r", "t", "b"),
                    "df" = mtcars)
# get element 1
example_list[1]
# get contents of element 1
example_list[[1]]
# using $
example_list$numbers
# using name
example_list[["numbers"]]
# using position
example_list[[1]]

#practice

# the number 7 from the number vector
example_list[[1]][4]
# the letters "y" and "t" from the letters vector
example_list[["letters"]][c(1,5)]
# the entire mtcars dataframe
example_list[["df"]]

