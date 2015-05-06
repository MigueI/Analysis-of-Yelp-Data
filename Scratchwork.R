library(rjson)
library(plyr)
library(dplyr)
library(ggplot2)

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

# Modify data. 
yelpdata$stars <- as.numeric(as.character(yelpdata$stars))
yelpdata$review_count <- as.numeric(as.character(yelpdata$review_count))

chinese <- filter(yelpdata, categories1 == "Chinese" & categories2 == "Restaurants") 
american <- filter(yelpdata, categories1 == "American (Traditional)" | 
                     categories2 == "American (Traditional)"| 
                     categories3 == "American (Traditional)"|
                     categories4 == "American (Traditional)"|
                     categories5 == "American (Traditional)"|
                     categories6 == "American (Traditional)"|
                     categories7 == "American (Traditional)") 

# Let's look at the overall number of restaurants. Naively, we'd expect a normal distribution, 
# but the plot shows a right skew, which we would expect for a few reasons. (1) people like going to good
# restaurants, (2) people may not be rating `normal`-y, (3) better restaurants tend to stick 
# around and the bad ones tend to close.
ggplot(yelpdata, aes(as.factor(stars))) + 
  geom_histogram()

# If the third hypothesis were true, we'd expect to have a large number of restuarants with high ratings
# that have been around for awhile. However, when we do plot of the number of restaurants with a specific
# number of reviews. (We assume that ratings is proportional to reviews, here.)
ggplot(yelpdata, aes(review_count)) + 
  geom_histogram() + 
  scale_x_log10()


ggplot(yelpdata, aes(as.factor(stars), as.numeric(as.character(review_count)))) + 
  geom_boxplot() + 
  scale_y_log10()


parking <- chinese %>%
  group_by(attributes.Parking.lot) %>%
  summarise(avg_rating = mean(stars), avg_num_rev = mean(review_count))
parking

state <- chinese %>%
  group_by(state) %>%
  summarize(avg_rating = mean(stars), avg_num_rev = mean(review_count))
state

statec <- chinese %>%
  group_by(attributes.Alcohol) %>%
  summarize(avg_rating = mean(stars), avg_num_rev = mean(review_count))
statec

statea <- american %>%
  group_by(attributes.Alcohol) %>%
  summarize(avg_rating = mean(stars), avg_num_rev = mean(review_count))
statea


