#code-along for day 3 regarding lists and attr

example_vec = c("chuck", "chris", "karen")

class(example_vec)
typeof(example_vec)

named_vec = c("football bro" = "chuck",
              "actor" = "chris",
              "unpleasant" = "karen")


# assign name to example_vec/making an attribute to example_vec 
names(example_vec) = c(1,2,3) 
attr(example_vec, "names") = c("lol", "raft","lmao")
attr(example_vec, "gibberish") = c("lol", "raft", "lmao") #assign another attribute


# list
test_list = list("letters" = letters,
                 "numbers " =  1:26)
attr(test_list, "class") = "data.frame"
attr(test_list, "row.names") = 1:16


