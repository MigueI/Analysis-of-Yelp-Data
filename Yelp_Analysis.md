# Yelp Data Analysis

## Motivation

We've all been there. It's 7:00 PM, you're in an unfamiliar part of town with some friends, and everyone's hungry but nobody can decide where to eat. Everyone pulls out their phones to see what's nearby, but being the snobs you are, you guys can't just pick any restaurant. You need something solid. At the very least 4 stars. Eventually you narrow it down to a couple of 4 star restaurants and one 4.5 star restaurant. In the end, you all go with the 4.5 star restaurant, since it's presumably the best. 

In our review-obsessed culture, we often look to the internet for decisions. When finding a place to eat, we want a single number that makes our decision easy. But at the end of the day, what is the difference between a 4 star restaurant and a 4.5 star restaurant? We'd assume that the quality of food is central to this rating, but what other factors play a role in a restaurants rating? In this analysis, my goal is to make a linear model to see how various attributes of a restaurant affect it's ratings on Yelp. Ideally, this information could be used to help restaurant owners discover what sorts of attributes will make the customer's experience better.

## Overview

We'll start our analysis by looking at the distribution of restaurant ratings. I'll make a predictive LASSO model using these attributes as inputs. We'll train the model with the first half of the data set, and test it using the second half of the data set to see how accurate the model is. Finally, we'll see how specific attributes of restaurants affect the ratings. 

## About Yelp Reviews

On Yelp, registered users give restaurants a rating between 1 and 5 stars, along with a text review consisting of a few sentences. In order to ensure ratings are trustworthy, Yelp only includes ratings that it deems "unbiased" (according to a computer model) so that any rants, reviews from single-review-accounts, and other potentially damaging or flawed reviews are not included in the overall review. (These reviews can still be accessed).







## Data Exploration - Restaurant Star Ratings
 
Let's look at the overall number of restaurants by rating. Naively we'd expect a normal distribution, but the plot shows a right skew. We can expect that (1) better restaurants tend to stick around (and the bad ones tend to close) or that (2) people may not be rating "normal"-y.

<img src="Yelp_Analysis_files/figure-html/unnamed-chunk-4-1.png" title="" alt="" style="display: block; margin: auto;" />

We can also look at a histogram of the number of reviews per restaurant. The plot below shows that most tend to have fewer than 10 reviews. The number of restaurants with a certain number of ratings begins to decay as this number of ratings increases.

<img src="Yelp_Analysis_files/figure-html/unnamed-chunk-5-1.png" title="" alt="" style="display: block; margin: auto;" />

We can also look to see how this distrubution changes if we divide the plots by star rating.

<img src="Yelp_Analysis_files/figure-html/unnamed-chunk-6-1.png" title="" alt="" style="display: block; margin: auto;" />

For the most part, the left skewed distribution seems relatively consistent for all ratings. As we go from 1 star restaurants to 4 star restaurants though, we see that the peak of the skewed distribution keeps moving to the right, indicating that there are more reviews for better rated restaurants. However, for restaurants of 4.5 and 5 stars, the peak scoots back to the left. We can get a sense of this by looking at a boxplot of the number of reviews by star rating.


<img src="Yelp_Analysis_files/figure-html/unnamed-chunk-7-1.png" title="" alt="" style="display: block; margin: auto;" />

What can we make of the low mean number of reviews for 5 star restaurants? Perhaps that most 5 star restaurants recieve that rating by chance; with a small sample size of 3 or 4 reviews, there will inevitably be a few restaurants that are rated 5 stars for each of those reviews. As the sample size (number of reviews) increases, the yelp rating will begin to approach this restaurants "true" rating, which will most likely not be 5 stars. The same probably occurs for 1 star restaurants as well, but there is an added consequence: if you are a 1 star restaurant, you probably won't be open for very long...

## Data Exploration - By City

Where is our data coming from?

<!-- GeoChart generated in R 3.1.3 by googleVis 0.5.8 package -->
<!-- Mon May 11 18:38:25 2015 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataGeoChartID1143c1ee12784 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
 "Charlotte, NC",
3.43,
2119 
],
[
 "Edinburgh, UK",
3.81,
1137 
],
[
 "Karlsruhe, Germany",
3.71,
469 
],
[
 "Las Vegas, NV",
3.42,
4960 
],
[
 "Madison, WI",
3.45,
981 
],
[
 "Montreal, Canada",
3.61,
2353 
],
[
 "Phoenix, AZ",
3.43,
7985 
],
[
 "Pittsburg, PA",
3.55,
1361 
],
[
 "Urbana-Champaign, IL",
3.38,
264 
],
[
 "Waterloo, Canada",
3.55,
244 
] 
];
data.addColumn('string','loc');
data.addColumn('number','Avg_Rating');
data.addColumn('number','Restaurants');
data.addRows(datajson);
return(data);
}


// jsData 
function gvisDataGeoChartID1143c4fe95af2 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
 "Charlotte, NC",
3.43,
2119 
],
[
 "Edinburgh, UK",
3.81,
1137 
],
[
 "Karlsruhe, Germany",
3.71,
469 
],
[
 "Las Vegas, NV",
3.42,
4960 
],
[
 "Madison, WI",
3.45,
981 
],
[
 "Montreal, Canada",
3.61,
2353 
],
[
 "Phoenix, AZ",
3.43,
7985 
],
[
 "Pittsburg, PA",
3.55,
1361 
],
[
 "Urbana-Champaign, IL",
3.38,
264 
],
[
 "Waterloo, Canada",
3.55,
244 
] 
];
data.addColumn('string','loc');
data.addColumn('number','Avg_Rating');
data.addColumn('number','Restaurants');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartGeoChartID1143c1ee12784() {
var data = gvisDataGeoChartID1143c1ee12784();
var options = {};
options["width"] =    556;
options["height"] =    347;
options["region"] = "US";
options["displayMode"] = "markers";
options["colorAxis"] = {colors:['white', '#c41200']};

    var chart = new google.visualization.GeoChart(
    document.getElementById('GeoChartID1143c1ee12784')
    );
    chart.draw(data,options);
    

}
  


// jsDrawChart
function drawChartGeoChartID1143c4fe95af2() {
var data = gvisDataGeoChartID1143c4fe95af2();
var options = {};
options["width"] =    556;
options["height"] =    347;
options["region"] = "150";
options["displayMode"] = "markers";
options["colorAxis"] = {colors:['white', '#c41200']};

    var chart = new google.visualization.GeoChart(
    document.getElementById('GeoChartID1143c4fe95af2')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "geochart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartGeoChartID1143c1ee12784);
})();
function displayChartGeoChartID1143c1ee12784() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}


// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "geochart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartGeoChartID1143c4fe95af2);
})();
function displayChartGeoChartID1143c4fe95af2() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartGeoChartID1143c1ee12784"></script>


<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartGeoChartID1143c4fe95af2"></script>
 
<table border="0">
<tr>
<td>

<!-- divChart -->
  
<div id="GeoChartID1143c1ee12784" 
  style="width: 556; height: 347;">
</div>

</td>
<td>

<!-- divChart -->
  
<div id="GeoChartID1143c4fe95af2" 
  style="width: 556; height: 347;">
</div>

</td>
</tr>
</table>

Finally, let's get a sense of how the reviews vary by city.


         City            Restaurants    Average Star Rating of Restaurants    Average Number of Ratings per Restaurant 
----------------------  -------------  ------------------------------------  ------------------------------------------
          NA                 19                        4.00                                     5.58                   
    Edinburgh, UK           1137                       3.81                                    14.47                   
  Karlsruhe, Germany         469                       3.71                                    11.88                   
   Montreal, Canada         2353                       3.61                                    16.16                   
    Pittsburg, PA           1361                       3.55                                    37.38                   
   Waterloo, Canada          244                       3.55                                    10.03                   
     Madison, WI             981                       3.45                                    34.10                   
    Charlotte, NC           2119                       3.43                                    33.74                   
     Phoenix, AZ            7985                       3.43                                    51.23                   
    Las Vegas, NV           4960                       3.42                                    90.13                   
 Urbana-Champaign, IL        264                       3.38                                    34.28                   

<img src="Yelp_Analysis_files/figure-html/unnamed-chunk-9-1.png" title="" alt="" style="display: block; margin: auto;" />

For the 10 cities given in this model, it would appear that the the average star rating will be larger if the average number of reviews by restaurant is lower. 

## LASSO Model

Now we want to create a model that uses various business attributes to predict the star rating of a restaurant. 

The LASSO flavor of linear regession (Least Absolute Shrinkage and Selection Operator) involves finding an ideal parameter in order to reduce possibility of overfitting. When fitting a linear regression, we are looking for the values $b_j$ that correspond to inputs $x_j$ and $\hat{y}$:

$$ \hat{y}~=~b_0~+~b_1x_1~+~...~+~b_kx_k . $$

Normally in linear regression, we seek to find the coefficients that minimize the value of $\sum{(y-\hat{y})^2}$, but with LASSO regression we impose an additional constraint: 

$$\sum{| b_j |} \leq s,$$

so the sum of the magnitude of all of the coefficients cannot exceed the value of $s$, a tunable parameter. If we make $s$ small (but still greater than zero), then the coefficients of unimportant parameters go to zero, and are thus not really included in the model. As a result, only the variables with a significant impact will appear in the model.

How do we find this value of $s$? It's a trade-off between the smallest error and the fewest number of variables. 

As predictors, we'll most of the relevant variables included for restaurants in the dataset. This includes categories (i.e. Chinese, American, Breakfast), the geographic location (city, neighborhood), and various attributes (parking, wifi, classy). 

We'll examine the accuracy of this model by splitting the data set in half. The first half will be used to train the model that will be tested on the second half. 

<img src="Yelp_Analysis_files/figure-html/unnamed-chunk-10-1.png" title="" alt="" style="display: block; margin: auto;" />

The plot above shows how the values of coefficients change for an increasing lasso parameter $s$ (x-axis).
The key variables are the ones that "jump out" early on. 

Below we see the change in Mean-Squared Error ($\frac{1}{k}\sum{(y-\hat{y})^2}$) as a function of a changing $s$ (which is proportional to the $log(\lambda)$ at the bottom of the x-axis). The top of the x-axis shows the number of variables included in the model. We find the ideal $s$ value at the dip, where the mean-square value is the lowest.

<img src="Yelp_Analysis_files/figure-html/unnamed-chunk-11-1.png" title="" alt="" style="display: block; margin: auto;" /><img src="Yelp_Analysis_files/figure-html/unnamed-chunk-11-2.png" title="" alt="" style="display: block; margin: auto;" />

The plot above compares the actual and the predicted results. The red line shows where a perfect predictions would fall, and the black points represent individual predictions. Our model does a good job of capturing the overall trend of the star ratings, but fails to predict any outliers. Most predictions are between 4.5 and 2.5 stars, but fails to predict any outliers of 1, 2, or even 5 stars. But this sort of makes sense because most restaurants have ratings of 3.5 or 4 stars, as we saw at the very beginning. 

<img src="Yelp_Analysis_files/figure-html/unnamed-chunk-12-1.png" title="" alt="" style="display: block; margin: auto;" />

Compared to the first histogram showing the distribution of all of the ratings, the histogram made from our predicted model has a much sharper peak.

The largest coefficients are shown in the table below:

<!--html_preserve--><div id="htmlwidget-5469" style="width:100%;height:auto;" class="datatables"></div>
<script type="application/json" data-for="htmlwidget-5469">{
  "x": {
    "data": [
      ["cityAhwatukee", "cityAllegheny", "cityAllentown", "cityAnjou", "cityAnthem", "cityApache Junction", "cityArcadia", "cityArlington", "cityAspinwall", "cityAvondale", "cityBaden-Baden", "cityBaie-D'urfe", "cityBalerno", "cityBanksville", "cityBapchule", "cityBeaconsfield", "cityBellevue", "cityBellvue", "cityBelmont", "cityBethel Park", "cityBietigheim", "cityBlack Canyon City", "cityBlainville", "cityBloomfield", "cityBocholt", "cityBoisbriand", "cityBonnyrigg", "cityBonnyrigg and Lasswade", "cityBoucherville", "cityBoulder City", "cityBraddock", "cityBrentwood", "cityBridgeville", "cityBrookline", "cityBrossard", "cityBruchsal", "cityBuckeye", "cityC Las Vegas", "cityCambridge", "cityCarefree", "cityCarnegie", "cityCasa Grande", "cityCastle Shannon", "cityCave Creek", "cityCentennial Hills", "cityCentral City Village", "cityCentral Henderson", "cityCentropolis Laval", "cityChampaign", "citychandler", "cityChandler", "cityChandler-Gilbert", "cityCharlotte", "cityCharlotte ", "cityCharlotte (University)", "cityChateau", "cityChomedey", "cityCity of Edinburgh", "cityClark County", "cityClover", "cityColumbus", "cityCommunauté-Urbaine-de-Montréal", "cityConcord", "cityConcord Mills", "cityConestogo", "cityCoolidge", "cityCote-des-Neiges-Notre-Dame-de-Grace", "cityCote-Saint-Luc", "cityCottage Grove", "cityCrafton", "cityCramond", "cityCramond Bridge", "cityCultural District", "cityDalgety Bay", "cityDalkeith", "cityDane", "cityDe Forest", "cityDeforest", "cityDeForest", "cityDelmont", "cityDesert Ridge", "cityDeux-Montagnes", "cityDeux-Montagnes Regional County Municipality", "cityDollard-Des Ormeaux", "cityDollard-des-Ormeaux", "cityDollard-Des-Ormeaux", "cityDormont", "cityDorval", "cityDowntown", "cityDravosburg", "cityDurmersheim", "cityEagan", "cityEdgewood", "cityEdinburgh", "cityEdinburgh City of", "cityEggenstein-Leopoldshafen", "cityEl Mirage", "cityEnterprise", "cityEtna", "cityEttlingen", "cityFabreville", "cityFirth of Forth", "cityFitchburg", "cityFlorence", "cityForchheim", "cityFort Kinnaird", "cityFort Mcdowell", "cityFort McDowell", "cityFort mill", "cityFort Mill", "cityFountain Hills", "cityFountain Hls", "cityFt. Mill", "cityGila Bend", "cityGilbert", "cityGlendale", "cityGlendale Az", "cityGold Canyon", "cityGoldfield", "cityGoodyear", "cityGreen Tree", "cityGreen Valley", "cityGreenfield Park", "cityGuadalupe", "cityHagenbach", "cityHarrisburg", "cityHeidelberg", "cityHenderson", "cityHenderson ", "cityHenderson (Green  Valley)", "cityHenderson (Stephanie)", "cityHenderson and Las vegas", "cityHenderson, NV 89074", "cityHenderston", "cityHigley", "cityHomestead", "cityHuntersville", "cityÎle des Soeurs", "cityIndian Land", "cityIndian Trail", "cityIngram", "cityInverkeithing", "cityJockgrim", "cityJuniper Green", "cityKarlsbad", "cityKarlsruhe", "cityKirkland", "cityKitchener", "cityL'Île-Bizard", "cityL'Île-des-Soeurs", "cityLa Prairie", "cityLachine", "cityLake Las Vegas", "cityLake Wylie", "cityLas Vegas", "cityLAS VEGAS", "cityLas Vegas ", "cityLas Vegas East", "cityLasalle", "cityLaSalle", "cityLasswade", "cityLast Vegas", "cityLaval", "cityLaveen", "cityLawrenceville", "cityLe Sud-Ouest", "cityLe Vieux-Port", "cityLeith", "cityLitchfield Park", "cityLitchfield Park ", "cityLoanhead", "cityLondon", "cityLongueuil", "cityLos Angeles", "cityLower Lawrenceville", "cityLuke AFB", "cityMadison", "cityMaricopa", "cityMaricopa County", "cityMascouche", "cityMattews", "cityMatthews", "cityMc Farland", "cityMc Kees Rocks", "cityMcfarland", "cityMcFarland", "cityMckees Rocks", "cityMcKees Rocks", "cityMcKeesport", "cityMesa", "cityMesa ", "cityMetro Phoenix", "cityMiddleton", "cityMidlothian", "cityMillvale", "cityMint Hill", "cityMirabel", "cityMonona", "cityMonroe", "cityMont-Royal", "cityMontéal", "cityMontreal", "cityMontréal", "cityMontreal-Est", "cityMontreal-Nord", "cityMontréal-Nord", "cityMontreal-Ouest", "cityMontréal-Ouest", "cityMontreal-West", "cityMorristown", "cityMount Holly", "cityMount Lebanon", "cityMount Royal", "cityMount Washington", "cityMt Lebanon", "cityMt. Oliver Boro", "cityMunhall", "cityMusselburgh", "cityN E Las Vegas", "cityN Las Vegas", "cityN W Las Vegas", "cityN. Las Vegas", "cityNboulder City", "cityNellis Afb", "cityNellis AFB", "cityNELLIS AFB", "cityNellis Air Force Base", "cityNeuburg", "cityNew Dundee", "cityNew River", "cityNew Town", "cityNewberry Springs", "cityNewbridge", "cityNewington", "cityNorth Las Vegas", "cityNorth Las Vegas ", "cityNorth Queensferry", "cityNorth Scottsdale", "cityOakland", "cityOld Montreal", "cityOld Town", "cityOutremont", "cityParadise", "cityParadise Valley", "cityPenicuik", "cityPeoria", "cityPfinztal", "cityPheonix", "cityPhoenix", "cityPHOENIX", "cityPhoenix Sky Harbor Center", "cityPhoenix-Ahwatukee", "cityPierrefonds", "cityPineville", "cityPittsburg", "cityPittsburgh", "cityPittsburgh/S. Hills Galleria", "cityPittsburgh/Waterfront", "cityPittsburrgh", "cityPointe Claire", "cityPointe-Aux-Trembles", "cityPointe-Claire", "cityPortobello", "cityQuebec", "cityQueen Creek", "cityQueensferry", "cityRankin", "cityRatho", "cityRegent Square", "cityRheinstetten", "cityRio Verde", "cityRobinson Township", "cityRock Hill", "cityRoosevelt", "cityRosemere", "cityRosemère", "cityRoslin", "cityRoxboro", "citySaguaro Lake", "citySaint Jacobs", "citySaint Laurent", "citySaint-Eustache", "citySaint-Hubert", "citySaint-Lambert", "citySaint-laurent", "citySaint-Laurent", "citySaint-Leonard", "citySainte-Ann-De-Bellevue", "citySainte-Anne-de-Bellevue", "citySainte-Anne-De-Bellevue", "citySainte-Genevieve", "citySainte-Therese", "citySainte-Thérèse", "citySan Diego", "citySan Tan Valley", "citySavoy", "cityScotland", "cityScottdale", "cityScottsdale", "cityScottsdale Country Acres", "cityScottsdale, Phoenix, Chandler, Gilbert", "citySeattle", "citySedona", "cityShadyside", "citySharpsburg", "citySouth Gyle", "citySouth Hills", "citySouth Las Vegas", "citySouth Queensferry", "citySouthside Flats", "citySpring Valley", "citySquirrel Hill", "citySt Clements", "citySt Jacobs", "citySt-Laurent", "citySt. Jacobs", "cityStallings", "cityStanfield", "citySte-Rose", "cityStockbridge", "cityStoughton", "cityStowe", "cityStowe Township", "cityStraiton", "cityStutensee", "cityStutensee neuthard", "citySummerlin", "citySummerlin South", "citySun City", "citySun City Anthem", "citySun City West", "citySun Lakes", "citySun Prairie", "citySunrise", "citySurprise", "citySurprise Crossing", "citySwissvale", "cityTega Cay", "cityTempe", "cityTerrebonne", "cityTolleson", "cityTonopah", "cityTonto Basin", "cityTortilla Flat", "cityTucson", "cityUniversity", "cityUpper Saint Clair", "cityUrbana", "cityVerdun", "cityVerona", "cityVictoria Park", "cityVimont", "cityW Henderson", "cityW Spring Valley", "cityW Summerlin", "cityWaddell", "cityWaldbronn", "cityWater of Leith", "cityWaterloo", "cityWaunakee", "cityWaxhaw", "cityWeddington", "cityWeingarten", "cityWeingarten (Baden)", "cityWesley Chapel", "cityWest Homestead", "cityWest Mifflin", "cityWestmount", "cityWhitehall", "cityWhitney", "cityWickenburg", "cityWilkinsburg", "cityWindsor", "cityWittmann", "cityWoolwich", "cityWörth am Rhein", "cityYoungtown", "citydnr", "price2", "price3", "price4", "pricednr", "alcoholfull_bar", "alcoholnone", "alcoholdnr", "noiselevelloud", "noiselevelquiet", "noiselevelvery_loud", "noiseleveldnr", "classyTRUE", "classydnr", "valetTRUE", "valetdnr", "cashTRUE", "cashdnr", "nhoodAllied Dunn's Marsh", "nhoodAnthem", "nhoodArboretum", "nhoodAspinwall", "nhoodAvalon", "nhoodBallantyne", "nhoodBanksville", "nhoodBay Creek", "nhoodBeechview", "nhoodBellevue", "nhoodBerkley Oaks", "nhoodBiddleville", "nhoodBloomfield", "nhoodBluff Acres", "nhoodBon Air", "nhoodBram's Addition", "nhoodBrighton Heights", "nhoodBrookline", "nhoodBruntsfield", "nhoodBurke Heights", "nhoodBurr Oaks", "nhoodCannonmills", "nhoodCapitol", "nhoodCapitol View Heights", "nhoodCarnegie", "nhoodCarpenter-Ridgeway", "nhoodCarrick", "nhoodCentennial", "nhoodChinatown", "nhoodCotswold", "nhoodCrafton Heights", "nhoodDerita", "nhoodDilworth", "nhoodDormont", "nhoodDowntown", "nhoodDudgeon-Monroe", "nhoodDuquesne Heights", "nhoodEast Carnegie", "nhoodEast Liberty", "nhoodEastland", "nhoodEastmorland", "nhoodEastside", "nhoodEken Park", "nhoodElizabeth", "nhoodElvehjem", "nhoodEmerson East", "nhoodEtna", "nhoodFaircrest", "nhoodFairywood", "nhoodFirst Ward", "nhoodFourth Ward", "nhoodFriendship", "nhoodGarfield", "nhoodGlacier Ridge", "nhoodGlen Oak Hills", "nhoodGlendale", "nhoodGreenbush", "nhoodGreenfield", "nhoodGreentree", "nhoodHawk's Landing", "nhoodHawthorne", "nhoodHaymarket", "nhoodHays", "nhoodHazelwood", "nhoodHeistand", "nhoodHigh Crossing", "nhoodHighland Creek", "nhoodHighland Park", "nhoodHomestead", "nhoodHomewood", "nhoodJunction Ridge", "nhoodKnoxville", "nhoodLake Edge", "nhoodLake View Hill", "nhoodLarimer", "nhoodLawrenceville", "nhoodLeith", "nhoodLeopold", "nhoodLincoln", "nhoodMaple - Prairie", "nhoodMaple Wood", "nhoodMarbella", "nhoodMarchmont", "nhoodMayfair Park", "nhoodMcClellan Park", "nhoodMeadowood", "nhoodMidvale Heights Community", "nhoodMillvale", "nhoodMoorland - Rimrock", "nhoodMorningside", "nhoodMt. Oliver", "nhoodMt. Washington", "nhoodMyers Park", "nhoodNew Town", "nhoodNewington", "nhoodNobel Park", "nhoodNoDa", "nhoodNorman Acres", "nhoodNorth Charlotte", "nhoodNorth Side", "nhoodNorthwest", "nhoodOakbridge Community", "nhoodOakland", "nhoodObservatory Hill", "nhoodOld Middleton Greenway", "nhoodOld Town", "nhoodOrchard Ridge Community", "nhoodOverbrook", "nhoodPaw Creek", "nhoodPlaza Midwood", "nhoodPoint Breeze", "nhoodPolish Hill", "nhoodQuail Hollow", "nhoodRegent", "nhoodRegent Square", "nhoodRidgewood", "nhoodRolling Meadows", "nhoodSauk Creek", "nhoodSchenk - Atwood", "nhoodSedgefield", "nhoodShadyside", "nhoodSharpsburg", "nhoodSheraden", "nhoodSherman", "nhoodSherwood Forest", "nhoodSouth Campus", "nhoodSouth End", "nhoodSouth Park", "nhoodSouth Side", "nhoodSouth Side Slopes", "nhoodSouth Summerlin", "nhoodSoutheast", "nhoodSouthwest", "nhoodSpring Harbor", "nhoodSpring Valley", "nhoodSquirrel Hill", "nhoodStanton Heights", "nhoodStarkweather - Yahar", "nhoodStarmount", "nhoodSteele Creek", "nhoodStockbridge", "nhoodStone Meadows", "nhoodStrip District", "nhoodSummerlin", "nhoodSummit Woods", "nhoodSunrise", "nhoodSunset Village", "nhoodTenney - Lapham", "nhoodThe Hill District", "nhoodThe Lakes", "nhoodThe Meadows", "nhoodThe Strip", "nhoodThird Ward", "nhoodTollcross", "nhoodTroy Hill", "nhoodUniversity", "nhoodUniversity City", "nhoodUptown", "nhoodVilas", "nhoodWalnut Grove", "nhoodWaunona", "nhoodWest End", "nhoodWest View", "nhoodWestchester Gardens", "nhoodWesthaven Trails", "nhoodWestmorland", "nhoodWestside", "nhoodWexford", "nhoodWilliamson - Marquette", "nhoodWindgap", "nhoodWorthington Park", "nhooddnr", "drivethruTRUE", "drivethrudnr", "parkinglotTRUE", "parkinglotdnr", "casualTRUE", "casualdnr", "danceTRUE", "dancednr", "deliveryTRUE", "deliverydnr", "ccheckTRUE", "ccheckdnr", "takeoutTRUE", "takeoutdnr", "resTRUE", "resdnr", "serviceTRUE", "servicednr", "streetTRUE", "streetdnr", "garageTRUE", "garagednr", "lateTRUE", "latednr", "desertTRUE", "desertdnr", "catersTRUE", "catersdnr", "wifino", "wifipaid", "wifidnr", "goodforkidsTRUE", "goodforkidsdnr", "tvTRUE", "tvdnr", "romanticTRUE", "romanticdnr", "trendyTRUE", "trendydnr", "upscaleTRUE", "upscalednr", "diveyTRUE", "diveydnr", "wheelchairTRUE", "wheelchairdnr", "bkgmusicTRUE", "bkgmusicdnr", "livemusicTRUE", "livemusicdnr", "byobTRUE", "byobdnr", "dogsallowedTRUE", "dogsalloweddnr", "open24hrsTRUE", "open24hrsdnr", "amexTRUE", "amexdnr", "orderatcounterTRUE", "orderatcounterdnr", "visaTRUE", "visadnr", "FastFood1", "Pizza1", "Mexican1", "`American(Traditional)`1", "Nightlife1", "Sandwiches1", "Bars1", "Food1", "Italian1", "Chinese1", "`American(New)`1", "Burgers1", "`Breakfast&amp;Brunch`1", "Cafes1", "Japanese1", "SushiBars1", "Delis1", "Steakhouses1", "Seafood1", "ChickenWings1", "SportsBars1", "`Coffee&amp;Tea`1", "Mediterranean1", "Barbeque1", "Thai1", "AsianFusion1", "French1", "Buffets1", "Indian1", "Pubs1", "Greek1", "Diners1", "Bakeries1", "Vietnamese1", "`Tex-Mex`1", "Vegetarian1", "Salad1", "HotDogs1", "MiddleEastern1", "`EventPlanning&amp;Services`1", "SpecialtyFood1", "Lounges1", "Korean1", "`Canadian(New)`1", "`Arts&amp;Entertainment`1", "WineBars1", "`Gluten-Free`1", "LatinAmerican1", "British1", "Gastropubs1", "`IceCream&amp;FrozenYogurt`1", "Southern1", "Vegan1", "Desserts1", "Hawaiian1", "German1", "Bagels1", "Caterers1", "`JuiceBars&amp;Smoothies`1", "`Fish&amp;Chips`1", "EthnicFood1", "TapasBars1", "Soup1", "Halal1"],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.066, 0, 0, 0, 0, 0, 0, 0, -0.005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.22, 0.385, 0, 0, 0.342, 0, 0, 0.268, 0, 0, 0, 0, 0, -0.005, 0, 0, 0, 0, 0, 0.338, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.161, 0, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.214, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.025, 0.109, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.025, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.208, 0, 0, 0, 0, 0, 0, 0, 0.028, 0, 0, 0, 0, 0, 0, 0.049, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.373, 0.23, 0, 0, -0.156, 0, 0, 0, 0, 0, -0.063, 0, 0, 0, -0.046, 0, -0.026, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.077, 0, 0, 0, 0.069, 0, 0, -0.049, 0.038, 0.151, -0.014, -0.058, 0, 0, -0.136, 0.02, -0.269, 0, 0.097, -0.015, 0, -0.008, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.032, 0, 0, 0, 0, 0, 0.105, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.021, 0, 0, 0.225, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.025, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.09, 0, 0, 0.022, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.029, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.131, 0, 0, 0, -0.038, 0, 0, 0, 0, 0, 0, 0, 0.215, 0, 0, 0.248, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.252, 0, 0.076, -0, 0.05, -0, 0, 0, -0.044, 0, 0, 0, 0, 0, 0.043, 0, 0, 0, 0.109, 0, -0.02, -0.002, -0.013, -0.015, 0.004, -0.06, 0.091, 0, 0, -0.188, -0.014, 0.001, 0, 0, -0.043, 0.058, 0, 0.066, 0, 0.006, -0.078, 0.043, 0, 0, 0.001, 0, 0, 0, 0, 0, -0.005, 0, -0.066, 0, 0, 0, 0, 0, 0, 0, 0, -0.201, -0.039, 0, -0.083, 0, 0, 0, 0.19, 0, -0.115, 0, -0.148, 0, 0.135, 0, 0, 0.061, 0, 0, -0.247, -0.1, 0, 0.108, 0, 0.049, 0, 0.204, -0.386, 0, 0, 0.046, 0, 0, 0, -0.024, 0.051, 0, 0.06, 0.041, 0, 0.158, 0, 0, 0.023, 0, 0.09, 0.011, 0.202, 0, 0, 0, 0, 0.175, 0, 0, 0.148, -0.126, 0, 0, 0, 0, 0, 0, 0.173]
    ],
    "container": "<table class=\"display\">\n  <thead>\n    <tr>\n      <th> </th>\n      <th>Coefficient</th>\n    </tr>\n  </thead>\n</table>",
    "options": {
      "columnDefs": [
        {
          "orderable": false,
          "targets": 0
        },
        {
          "className": "dt-right",
          "targets": 1
        }
      ],
      "order": [],
      "autoWidth": false
    },
    "callback": "function(table) {\nreturn table;\n}",
    "filter": "none"
  },
  "evals": ["callback"]
}</script><!--/html_preserve-->

Overall, we see that the top ten positive variables have to do with the location in the city, so I guess there is something to be said about the location. This could mean a wealthier neighborhood thus better quality food, or also that the population rates easier, or even that good restaurants tend to group together. Besides the location, categories like 'Latin American' 'French' 'Food'(?) and 'Vegan' tended to be better rated. Things that negatively impacted the rating were, again, categories like 'Buffets' 'Chicken Wings' 'Fast Food' or 'Burgers', but also things like a 'very loud' or a 'loud' noise levels, and (everyones least favorite) paid wifi.

Also, it's worth noting that lack of responses tended to hurt a restaurants rating. When establishments failed to provide information (listed as 'dnr' = 'did not respond'), it means that consumers won't be making informed decisions, which could lead to a bad time and negative reviews. These were things like failing to answer whether or not a restaurant was 'upscale', whether dogs were allowed, or whether or not they served desert. Filling in these responses resulted in better ratings in every single category except 'drive-thru: TRUE', 'wifi: paid', 'delivery: TRUE', 'garage: TRUE', and 'open-late:TRUE'. 

## Conclusions

Our analysis isn't perfect, but then again, it wasn't meant to be perfect. We're trying to get a sense of the kinds of trends we see on the large scale, without looking at the food quality. Of course there will be some shabby restaurants with excellent food, and other restaurants that have all the "attribute" boxes ticked but lack good food. Without the information on the food, we have focus on other attributes. What does the analysis on these attributes tell us?

We'll if you're a restaurant owner, consider filling out all of your yelp attributes, since many restaurants were penalized for lack of responses. Next, is it possible to make your establishment quieter? Loud and very loud restaurants recieved lower ratings. If you're going to offer wifi, make if free or don't bother. Finally, if you are thinking about opening a restaurant, take great care in where you choose to set up shop. Location (i.e. neighborhood) can play a major role in a restaurants ratings.


It's important to keep in mind that correlation isn't causation, and that just because we see differences between attributes doesn't necessarily mean that fixing certain problems will immediatly yield better ratings. On the other hand, making some of the improvements outlined above certainly won't make ratings worse!

## Acknowledgments 

I'd like to thank Albert for helping me with this project, and for teaching me R and introducing me to statistics. I'd also like to thank Yelp for publishing the data set. 
