##
##
##

# TODO: convert this into a function and run on all 3 databases

# ideas: https://cran.r-project.org/web/packages/RSQLite/vignettes/RSQLite.html

library(readr)
library(plyr)
library(DBI)
library(RSQLite)

# function defs
source('../snapshot-functions.R')


## re-process all NASIS pedons
# about 5 minutes
type <- 'NASIS'
base.path <- 'e:/temp/NASIS_Pedons_20181023_CSV_files/'
makeSQLiteFromCSV(type, base.path)


## re-process KSSL snapshot
# about 1 minute
type <- 'KSSL'
base.path <- 'e:/temp/NCSS_Soil_Characterization_Database_09_14_2018_CSV_files/'
makeSQLiteFromCSV(type, base.path)



