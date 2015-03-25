# The file sources the data from NOMIS and prepares the data table for charting
# Values needed for the interface elements are also sourced from the data

# Source NOMIS data
## Define the nomis url
url.nom <- 'http://www.nomisweb.co.uk/api/v01/dataset/NM_1_1.data.csv?geography=1941962927...1941962958&date=latestMINUS372,latestMINUS360,latestMINUS348,latestMINUS336,latestMINUS324,latestMINUS312,latestMINUS300,latestMINUS288,latestMINUS276,latestMINUS264,latestMINUS252,latestMINUS240,latestMINUS228,latestMINUS216,latestMINUS204,latestMINUS192,latestMINUS180,latestMINUS168,latestMINUS156,latestMINUS144,latestMINUS132,latestMINUS120,latestMINUS108,latestMINUS96,latestMINUS84,latestMINUS72,latestMINUS60,latestMINUS48,latestMINUS36,latestMINUS24,latestMINUS12,latest&sex=7&item=1...4,9&measures=20100,20203&select=date_name,geography_name,geography_code,sex_name,item_name,measures_name,obs_value,obs_status_name'

## Read the CSV file to data frame
dta.nom <- read.csv(file = url.nom, header = TRUE, sep = ",")

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
lst.councils <- unique(dta.nom$GEOGRAPHY_NAME)