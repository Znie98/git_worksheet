# Class practice ----

phrase = "tis just a flesh wound"
results = c()
for (letter in letters){
  results[letter] = grepl(letter, phrase)
  }



# Worksheet ----

survey = readRDS(url("https://github.com/Adv-R-Programming/Adv-R-Reader/raw/main/class_survey.rds"))
pet_split = function(pet_vector) {
  
  # make new dataframe for output
  pet_output = data.frame(
    "id" = 1:length(pet_vector),
    "dog" = NA,
    "cat" = NA,
    "fish" = NA,
    "bird" = NA,
    "reptile" = NA,
    "rock" = NA,
    "none" = NA,
    "other" = NA)
  
  # get a binary for each known pet type
  pet_output$dog = grepl(pattern = "dog", x = pet_vector, ignore.case = TRUE)
  pet_output$cat = grepl(pattern = "cat", x = pet_vector, ignore.case = TRUE)
  pet_output$fish = grepl(pattern = "fish", x = pet_vector, ignore.case = TRUE)
  pet_output$bird = grepl(pattern = "bird", x = pet_vector, ignore.case = TRUE)
  pet_output$reptile = grepl(pattern = "reptile", x = pet_vector, ignore.case = TRUE)
  pet_output$rock = grepl(pattern = "rock", x = pet_vector, ignore.case = TRUE)
  pet_output$none = grepl(pattern = "none", x = pet_vector, ignore.case = TRUE)
  
  # remove all known pets and clean remaining text
  pet_vector = gsub(pattern = "dog", pet_vector, replacement = "", ignore.case = TRUE)
  pet_vector = gsub(pattern = "cat", pet_vector, replacement = "", ignore.case = TRUE)
  pet_vector = gsub(pattern = "fish", pet_vector, replacement = "", ignore.case = TRUE)
  pet_vector = gsub(pattern = "bird", pet_vector, replacement = "", ignore.case = TRUE)
  pet_vector = gsub(pattern = "reptile", pet_vector, replacement = "", ignore.case = TRUE)
  pet_vector = gsub(pattern = "rock", pet_vector, replacement = "", ignore.case = TRUE)
  pet_vector = gsub(pattern = "none", pet_vector, replacement = "", ignore.case = TRUE)
  pet_vector = gsub(pattern = ",", pet_vector, replacement = "", ignore.case = TRUE)
  pet_vector = trimws(pet_vector)
  
  # Fill in "other"
  pet_output$other = pet_vector
  # Turn blanks into NAs
  pet_output[pet_output$other == "", "other"] = NA
  
  # return
  return(pet_output)
}

# set up a psudo argument
pet_vector = survey$pets

# make new dataframe for output
pet_output = data.frame(
  "id" = 1:length(pet_vector),
  "dog" = NA,
  "cat" = NA,
  "fish" = NA,
  "bird" = NA,
  "reptile" = NA,
  "rock" = NA,
  "none" = NA,
  "other" = NA)

# get a binary for each known pet type
pet_output$dog = grepl(pattern = "dog", x = pet_vector, ignore.case = TRUE)
pet_output$cat = grepl(pattern = "cat", x = pet_vector, ignore.case = TRUE)
pet_output$fish = grepl(pattern = "fish", x = pet_vector, ignore.case = TRUE)
pet_output$bird = grepl(pattern = "bird", x = pet_vector, ignore.case = TRUE)
pet_output$reptile = grepl(pattern = "reptile", x = pet_vector, ignore.case = TRUE)
pet_output$rock = grepl(pattern = "rock", x = pet_vector, ignore.case = TRUE)
pet_output$none = grepl(pattern = "none", x = pet_vector, ignore.case = TRUE)

# remove all known pets and clean remaining text
pet_vector = gsub(pattern = "dog", pet_vector, replacement = "", ignore.case = TRUE)
pet_vector = gsub(pattern = "cat", pet_vector, replacement = "", ignore.case = TRUE)
pet_vector = gsub(pattern = "fish", pet_vector, replacement = "", ignore.case = TRUE)
pet_vector = gsub(pattern = "bird", pet_vector, replacement = "", ignore.case = TRUE)
pet_vector = gsub(pattern = "reptile", pet_vector, replacement = "", ignore.case = TRUE)
pet_vector = gsub(pattern = "rock", pet_vector, replacement = "", ignore.case = TRUE)
pet_vector = gsub(pattern = "none", pet_vector, replacement = "", ignore.case = TRUE)
pet_vector = gsub(pattern = ",", pet_vector, replacement = "", ignore.case = TRUE)
pet_vector = trimws(pet_vector)

# Fill in "other"
pet_output$other = pet_vector
# Turn blanks into NAs
pet_output[pet_output$other == "", "other"] = NA


pet_split(pet_vector = survey$pets)

possible_columns = c("dog", "cat", "fish", "bird", "reptile", "rock", "none")
# make a base dataframe with rows for each of our cases.
pet_output = data.frame(
  "id" = 1:length(pet_vector)
)

# iterate through all options and create a column with NAs for it
for(option in possible_columns){
  
  # make a new column with a character version of each possible option.
  pet_output[, as.character(option)] = NA
  
}


## Q.1 ----
#Using the same principle as above, iterate over each option in possible_columns and use grepl() to test if the pet appeared in that case. Fill the respective columns.

# iterate through all options and create a column with NAs for it
for(option in possible_columns){
  
  # make a new column with a character version of each possible option.
  pet_output[, as.character(option)] = NA
  
}
## Q2 ----
#remove the known options to find other

# fill output df
for(option in possible_columns){
  
  # fill dataframe iterativly.
  pet_output[ , option] = grepl(option, pet_vector, ignore.case = TRUE)
  
}


## Whole codes (important) ----

# make dummy argument
pet_vector = survey$pets

# set all known options
possible_columns = c("dog", "cat", "fish", "bird", "reptile", "rock", "none")

# make a base dataframe with rows for each of our cases.
pet_output = data.frame(
  "id" = 1:length(pet_vector)
)

# iterate through all options and create a column with NAs for it
for(option in possible_columns){
  
  # make a new column with a character version of each possible option.
  pet_output[, as.character(option)] = NA
  
}

# fill output df
for(option in possible_columns){
  
  # fill dataframe iterativly.
  pet_output[ , option] = grepl(option, pet_vector, ignore.case = TRUE)
  
}

# clear all know options
for(option in possible_columns){
  
  # remove all known options
  pet_vector = gsub(pattern = option, pet_vector, replacement = '', ignore.case = TRUE)
  
}

# clear commas and whitespace
pet_vector = gsub(pattern = ',', pet_vector, replacement = '', ignore.case = TRUE)
pet_vector = trimws(pet_vector)

# Fill in 'other'
pet_output$other = pet_vector
# Turn blanks into NAs
pet_output[pet_output$other == '' & !is.na(pet_output$other), 'other'] = NA

## Turn whole cods into function
comma_splits <- function(vector_to_split, possible_columns){
  for(option in possible_columns){
    
    # make a new column with a character version of each possible option.
    output[, as.character(option)] = NA
    
  }
  
  # fill output df
  for(option in possible_columns){
    
    # fill dataframe iterativly.
    ouput[ , option] = grepl(option, vector_to_split, ignore.case = TRUE)
    
  }
  
  # clear all know options
  for(option in possible_columns){
    
    # remove all known options
    pet_vector = gsub(pattern = option, vector_to_split, replacement = '', ignore.case = TRUE)
    
  }
  
  # clear commas and whitespace
  vector_to_split = gsub(pattern = ',', vector_to_split, replacement = '', ignore.case = TRUE)
  vector_to_split = trimws(pet_vector)
  
  # Fill in 'other'
  output$other = pet_vector
  # Turn blanks into NAs
  output[pet_output$other == '' & !is.na(pet_output$other), 'other'] = NA
  
  return(output)
  
}
