# Yelp Star Predictions Using Restaurant Attributes

Yelp ratings help guide the decisions of millions of hungry people, but exactly what do these ratings measure? Well, first of all,
food quality. But also other things. Things that might not be so obvious at first, things like whether a restaurant charges for wi-fi or gives it away for free. From a massive dataset of 21,000 restaurants provided by 
[Yelp](http://www.yelp.com/dataset_challenge), I made a model using the LASSO method of linear regression to find out exactly what 
restaurant attributes helped, hurt, or had no effect on, a restaurant's rating. 

![ScreenShot](https://raw.githubusercontent.com/MigueI/Analysis-of-Yelp-Data/master/Yelp_Analysis_files/figure-html/unnamed-chunk-4-1.png)

The distribution of ratings of the restaurants included in the data set.

![ScreenShot](https://raw.githubusercontent.com/MigueI/Analysis-of-Yelp-Data/master/Yelp_Analysis_files/figure-html/unnamed-chunk-11-2.png)

The predictions of the trained model on a test data set. Since we have no indication of the quality of the food, we don't expect the ratings to be perfect. Instead we're interested in matching the trend of most of the restaurants, which we see above. 
