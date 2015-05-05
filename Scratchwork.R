library(rjson)
library(plyr)
library(dplyr)

# Open file, read all the lines, then close the file.
con <- file("yelp_academic_dataset_business.json", "r")
input <- readLines(con, -1L)
close(con)

# Extract each json object (i.e. a single buisiness) from the read file,
# and make it a row of a data frame.
yelpdata <- input %>%
  lapply(function(x) t(unlist(fromJSON(x)))) %>% 
  ldply()
save(yelpdata, file= 'yelpdata.rdata')

chinese_
