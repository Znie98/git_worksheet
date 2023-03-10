# Worksheet
survey = readRDS(url("https://github.com/Adv-R-Programming/Adv-R-Reader/raw/main/class_survey.rds"))

my_table<-function (..., exclude = if (useNA == "no") c(NA, NaN), useNA = c("no", 
                                                                  "ifany", "always"), dnn = list.names(...), deparse.level = 1) 
{
  list.names <- function(...) {
    l <- as.list(substitute(list(...)))[-1L]
    if (length(l) == 1L && is.list(..1) && !is.null(nm <- names(..1))) 
      return(nm)
    nm <- names(l)
    fixup <- if (is.null(nm)) 
      seq_along(l)
    else nm == ""
    dep <- vapply(l[fixup], function(x) switch(deparse.level + 
                                                 1, "", if (is.symbol(x)) as.character(x) else "", 
                                               deparse(x, nlines = 1)[1L]), "")
    if (is.null(nm)) 
      dep
    else {
      nm[fixup] <- dep
      nm
    }
  }
  miss.use <- missing(useNA)
  miss.exc <- missing(exclude)
  useNA <- if (miss.use && !miss.exc && !match(NA, exclude, 
                                               nomatch = 0L)) 
    "ifany"
  else match.arg(useNA)
  doNA <- useNA != "no"
  if (!miss.use && !miss.exc && doNA && match(NA, exclude, 
                                              nomatch = 0L)) 
    warning("'exclude' containing NA and 'useNA' != \"no\"' are a bit contradicting")
  args <- list(...)
  if (length(args) == 1L && is.list(args[[1L]])) {
    args <- args[[1L]]
    if (length(dnn) != length(args)) 
      dnn <- paste(dnn[1L], seq_along(args), sep = ".")
  }
  if (!length(args)) 
    stop("nothing to tabulate")
  bin <- 0L
  lens <- NULL
  dims <- integer()
  pd <- 1L
  dn <- NULL
  for (a in args) {
    if (is.null(lens)) 
      lens <- length(a)
    else if (length(a) != lens) 
      stop("all arguments must have the same length")
    fact.a <- is.factor(a)
    if (doNA) 
      aNA <- anyNA(a)
    if (!fact.a) {
      a0 <- a
      op <- options(warn = 2)
      a <- factor(a, exclude = exclude)
      options(op)
    }
    add.na <- doNA
    if (add.na) {
      ifany <- (useNA == "ifany")
      anNAc <- anyNA(a)
      add.na <- if (!ifany || anNAc) {
        ll <- levels(a)
        if (add.ll <- !anyNA(ll)) {
          ll <- c(ll, NA)
          TRUE
        }
        else if (!ifany && !anNAc) 
          FALSE
        else TRUE
      }
      else FALSE
    }
    if (add.na) 
      a <- factor(a, levels = ll, exclude = NULL)
    else ll <- levels(a)
    a <- as.integer(a)
    if (fact.a && !miss.exc) {
      ll <- ll[keep <- which(match(ll, exclude, nomatch = 0L) == 
                               0L)]
      a <- match(a, keep)
    }
    else if (!fact.a && add.na) {
      if (ifany && !aNA && add.ll) {
        ll <- ll[!is.na(ll)]
        is.na(a) <- match(a0, c(exclude, NA), nomatch = 0L) > 
          0L
      }
      else {
        is.na(a) <- match(a0, exclude, nomatch = 0L) > 
          0L
      }
    }
    nl <- length(ll)
    dims <- c(dims, nl)
    if (prod(dims) > .Machine$integer.max) 
      stop("attempt to make a table with >= 2^31 elements")
    dn <- c(dn, list(ll))
    bin <- bin + pd * (a - 1L)
    pd <- pd * nl
  }
  names(dn) <- dnn
  bin <- bin[!is.na(bin)]
  if (length(bin)) 
    bin <- bin + 1L
  y <- array(tabulate(bin, pd), dims, dimnames = dn)
  class(y) <- "table"
  y
}

table(survey$mint_choc)
my_table(survey$mint_choc)


#create the dataframe for the function ouput
pet_output = data.frame(
  "id" = 1:nrow(survey),
  "dog" = NA,
  "cat" = NA,
  "fish" = NA,
  "bird" = NA,
  "reptile" = NA,
  "rock" = NA,
  "none" = NA,
  "other" = NA)

grepl(pattern = "dog", x = survey$pets, ignore.case = TRUE)
pet_output$dog = grepl(pattern = "dog", x = survey$pets, ignore.case = TRUE)
pet_output$cat = grepl(pattern = "cat", x = survey$pets, ignore.case = TRUE)
pet_output$fish = grepl(pattern = "fish", x = survey$pets, ignore.case = TRUE)
pet_output$bird = grepl(pattern = "bird", x = survey$pets, ignore.case = TRUE)
pet_output$reptile = grepl(pattern = "reptile", x = survey$pets, ignore.case = TRUE)
pet_output$rock = grepl(pattern = "rock", x = survey$pets, ignore.case = TRUE)
pet_output$none = grepl(pattern = "none", x = survey$pets, ignore.case = TRUE)

pet_output

# try to find a way for "other" cases

work_pets = survey$pets
gsub(pattern = "dog", work_pets, replacement = "", ignore.case = TRUE)
work_pets = gsub(pattern = "dog", work_pets, replacement = "", ignore.case = TRUE)
work_pets = gsub(pattern = "cat", work_pets, replacement = "", ignore.case = TRUE)
work_pets = gsub(pattern = "fish", work_pets, replacement = "", ignore.case = TRUE)
work_pets = gsub(pattern = "bird", work_pets, replacement = "", ignore.case = TRUE)
work_pets = gsub(pattern = "reptile", work_pets, replacement = "", ignore.case = TRUE)
work_pets = gsub(pattern = "rock", work_pets, replacement = "", ignore.case = TRUE)
work_pets = gsub(pattern = "none", work_pets, replacement = "", ignore.case = TRUE)
work_pets = gsub(pattern = ",", work_pets, replacement = "", ignore.case = TRUE)
work_pets = trimws(work_pets)

work_pets
pet_output$other = work_pets
pet_output[pet_output$other == "", "other"] = NA

pet_output


# Make it more general
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

pet_split(pet_vector = survey$pets)


#Create a function that will intake a ROW from the survey dataframe,
#and output a number showing how many total NAs there were in there row. 
#The is.na() function will come in handy here. An example input and output should look like:

total_na<-function(row){
  #get the table of is.na of the row
  na_table = table(is.na(row))
  
  #get the total number of TRUE
  num_true = na_table[["TRUE"]]
  
  #return num_true
  return(num_true)
}
total_na(survey[1,])

