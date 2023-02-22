#code along for functions

num_vec = c(12,7,9,27,3,21,3)

mode(num_vec)

get_mode <- function(...){
  
  #unlist all inputs to find mode 
  flat = unlist(...)
  
  #find the most common input
  mode_table = table(flat)
  
  #get the name of the most common element
  our_mode = names(which.max(mode_table))
  
  #return output
  return(our_mode)
  
}

get_mode(num_vec)

vec_2 = c(11,34,22,55,74,34,56,56,56)
get_mode(num_vec, vec_2)

# testing out which.max()
  #test = table(num_vec)
  #max(test)
  #names(test) #subset the value by names 
  #test["7"]
  #test[which.max(test)]

# Worksheet
survey = readRDS(url("https://github.com/Adv-R-Programming/Adv-R-Reader/raw/main/class_survey.rds"))





