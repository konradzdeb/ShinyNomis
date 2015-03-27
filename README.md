# ShinyNomis
The following simple shiny app was developed for the purposes of sourcing the live data from NOMIS into R. The app makes use of the [NOMIS API](https://www.nomisweb.co.uk/).

### Running the App
The most convenient way of running this application would include going to the [Shiny App Website](https://konrad.shinyapps.io/ShinyNomis/). As I'm running my app from the free account, the app may not work if too many users is accessing it in the same time. The alternative is to run the app from GitHub using the code below:
```r
shiny::runGitHub('ShinyNomis', 'konradedgar')
```

## global.R
The file contains the code sourcing the data from the NOMIS website. The key part of the code corresponds to the query that is passed to the nomis website:

```r
## Define the nomis url
url.nom <- 'http://www.nomisweb.co.uk/api/v01/dataset/NM_1_1.data.csv?geography=1941962927...1941962958&date=latestMINUS372,latestMINUS360,latestMINUS348,latestMINUS336,latestMINUS324,latestMINUS312,latestMINUS300,latestMINUS288,latestMINUS276,latestMINUS264,latestMINUS252,latestMINUS240,latestMINUS228,latestMINUS216,latestMINUS204,latestMINUS192,latestMINUS180,latestMINUS168,latestMINUS156,latestMINUS144,latestMINUS132,latestMINUS120,latestMINUS108,latestMINUS96,latestMINUS84,latestMINUS72,latestMINUS60,latestMINUS48,latestMINUS36,latestMINUS24,latestMINUS12,latest&sex=7&item=1...4,9&measures=20100,20203&select=date_name,geography_name,geography_code,sex_name,item_name,measures_name,obs_value,obs_status_name'

## Read the CSV file to data frame
dta.nom <- read.csv(file = url.nom, header = TRUE, sep = ",")
```
The query is fairly straightforward and can be easily generated from the NOMIS api. The queries can be conveniently defined via the [NOMIS](https://www.nomisweb.co.uk/) website. Rest of the code in the `global.R` simply cleans and transforms the data to make it usable for the chart.

```r
## Remove NAs
dta.nom <- dta.nom[complete.cases(dta.nom),]

# Create values for the interface

## Create list of unique variables
### Convert to character
dta.nom$MEASURES_NAME = as.character(dta.nom$MEASURES_NAME)
### Create unique list
lst.measures <- unique(dta.nom$MEASURES_NAME)

## Create list of unique measures
### Converst to string
dta.nom$ITEM_NAME <- as.character(dta.nom$ITEM_NAME)
### Create unique list
lst.vars <- unique(dta.nom$ITEM_NAME)

# Get dates for the slider
## Delete pointless month
dta.nom$DATE_NAME <- sub("February ", replacement = "", x = dta.nom$DATE_NAME)
## Convert to number and get min/max
dta.nom$DATE_NAME <- as.numeric(x = dta.nom$DATE_NAME)
yr.min <- min(dta.nom$DATE_NAME)
yr.max <- max(dta.nom$DATE_NAME)

# Create list of geographies
## Convert to character
dta.nom$GEOGRAPHY_NAME <- as.character(dta.nom$GEOGRAPHY_NAME)
## Create list of unique values
lst.councils <- unique(dta.nom$GEOGRAPHY_NAME)
```

## ui.R and server.R
`server.R` and `ui.R` contain very standard structure with the set of interface elements and the `ggplot` syntax to derive the chart from the filtered data. Data is filtered in a straightforward manner using the `subset` command matching the selections from user-interface. 