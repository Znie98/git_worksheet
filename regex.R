# CLass code ----
library(stringr)

str_detect(survey$fav_art, "favorite")

#wildwords. 
#usually used in finding email address
regexplain::view_regex(email,
                       "([[:alnum:]_.-]+)@([[:alnum:].-]+)\\.([[:alpha:].]{2,6})")

#select all 4 digits
regexplain::view_regex(zelda, "\\d{4}")

#find every digit with a period
regexplain::view_regex(sherlock, "\\d+\\. ")

#grouops
#Day, Date 
regexplain::view_regex(spring,
                       "([A-Z][a-z]+, [A-Z][a-z]+ \\d{1,2})")

#detect
#give out TRUE or FALSE if the text pattern of interest really appears in the string 
#Case sensitive
test_vec = c("I like turtles",
             "I like cats",
             "I don't like raptors")

stringr::str_detect(test_vec, "like")

#Count
#give the number of times a pattern of interest appear in the string
test_vec = c("I like turtles",
             "I like cats",
             "I don't like raptors")

stringr::str_detect(test_vec, "like")


#extract
#extract the pattern of interest from the string 
test_vec3 = "Thursday, January 26
Classes begin at 8 a.m.
Wednesday, February 1
Last day to add a course online
Wednesday, February 8
Last day to drop a course online;
last day to add a Five College course"

stringr::str_extract_all(test_vec3,
                         "([A-Z][a-z]+, [A-Z][a-z]+ \\d{1,2})")

#remove unwanted URLS
parsed$clean_text = str_remove_all(parsed$clean_text,
                                   "(http:\\/\\/www\\.|https:\\/\\/www\\.|http:\\/\\/|https:\\/\\/)?[a-z0-9]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,5}(:[0-9]{1,5})?(\\/.*)?")
