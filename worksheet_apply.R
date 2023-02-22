# Code along ----
# to test out apply skills

phrase = "tis but a flesh wound!"

# test does every character appear in this phrase
lapply(letters, FUN = function(l, int_phr){
  # test if l is in phrase 
  result = grepl(l, int_phr) 
  
  #return
  return(result)
  
}, int_phr = phrase)


# Worksheet ----

survey = readRDS(url("https://github.com/Adv-R-Programming/Adv-R-Reader/raw/main/class_survey.rds"))

comma_split = function(vector_to_split, possible_columns){
  
  # make a base dataframe with rows for each of our cases.
  output = data.frame(
    'id' = 1:length(vector_to_split)
  )
  
  # iterate through all options and create a column with NAs for it
  for(option in possible_columns){
    
    # make a new column with a character version of each possible option.
    output[, as.character(option)] = NA
    
  }
  
  # fill output df
  for(option in possible_columns){
    
    # fill dataframe iterativly.
    output[ , option] = grepl(option, vector_to_split, ignore.case = TRUE)
    
  }
  
  # clear all know options
  for(option in possible_columns){
    
    # remove all known options
    vector_to_split = gsub(pattern = option, vector_to_split, replacement = '', ignore.case = TRUE)
    
  }
  
  # clear commas and whitespace
  vector_to_split = gsub(pattern = ',', vector_to_split, replacement = '', ignore.case = TRUE)
  vector_to_split = trimws(vector_to_split)
  
  # Fill in 'other'
  output$other = vector_to_split
  # Turn blanks into NAs
  output[output$other == "" & !is.na(output$other), 'other'] = NA
  
  # return output
  return(output)
}

## Q1----
drink_dfs<-lapply(survey, 
       FUN = comma_split(survey$tea_days, possible_columns = c("monday","tuesday","wednesday","thursday","friday","saturday","sunday")))


##Q2----
# download file into project directory
download.file("https://github.com/Adv-R-Programming/Adv-R-Reader/raw/main/content/class_worksheets/09_apply_lists/09_data.zip", "./09_data.zip")

# unzip into folder
unzip("./09_data.zip", exdir = "./09_data_dir/")
econ_data_paths = list.files("./09_data_dir/", pattern = "econ_", full.names = TRUE)

all_econ_data = lapply(econ_data_paths, read.csv)

# pivot the data into wide form
library(tidyr)

all_econ_data_wide = lapply(all_econ_data,
                            FUN = pivot_wider,
                            id_cols = c("GEOID", "NAME"),
                            names_from = "variable",
                            values_from = c("estimate", "moe"))

for(i in 1:length(all_econ_data_wide)){
  
  # get the file name I want
  file_name = basename(econ_data_paths[i])
  
  # add that as a column to the matching list element
  all_econ_data_wide[[i]]$file_name = file_name
}

merged_econ = do.call(rbind, all_econ_data_wide)

# repeat previous pocess with "pop_acs5_xxxx" files
pop_data_paths = list.files("./09_data_dir/", pattern = "pop_", full.names = TRUE)

all_pop_data = lapply(pop_data_paths, read.csv)
all_pop_data_wide = lapply(all_pop_data,
                           FUN = pivot_wider,
                           id_cols = c("GEOID", "NAME"),
                           names_from = "variable",
                           values_from = c("estimate", "moe"))
for(i in 1:length(all_pop_data_wide)){
  
  # get the file name I want
  file_name = basename(pop_data_paths[i])
  
  # add that as a column to the matching list element
  all_pop_data_wide[[i]]$file_name = file_name
}

merged_pop = do.call(rbind, all_pop_data_wide)
