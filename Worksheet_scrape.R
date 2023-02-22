library("rvest")

#Download the SDS page
sds_page = read_html("https://www.smith.edu/academics/statistics")

#Get the name of all SDS facult
html_text2(html_elements(sds_page, ".fac-inset h3"))

#website owners can change website. If they do it, you might have to rewrite codes/

#Make a dataframe
sds_df = data.frame(
  "name" = html_text2(html_elements(sds_page, ".fac-inset h3")),
  "title" = html_text2(html_elements(sds_page, ".fac-inset p")),
  "rel_link" = html_attr(html_elements(sds_page, ".linkopacity"), name = "href")
)

#Iteratoin
#As website might have access frequency limit, remember using Sys.sleep() before read_html() command

#Worksheet ----
sds_home<-