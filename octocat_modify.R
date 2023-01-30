# to add a caption to octocat

octocat = readLines("./octocat.txt")

octocat = c(octocat, "ASCII Art of the Octocat Mascot for Github")

writeChar(octocat, "./octocat.txt")
