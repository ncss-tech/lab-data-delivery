## Get PSDA (total sand, silt, clay) associated with potential fragic properties / fragipan
## using pattern matching on horizon designation, roughly "Bx" horizons
## using local copy of the SQLite snapshot and SDA interface to the same data
## display on a texture triangle
##
## D.E. Beaudette, P. Drohan, J. Nemecek
## 2020-07-22
##

## load packages
library(aqp)
library(soilDB)
library(soiltexture)
library(scales)
library(DBI)
library(RSQLite)



##
## local SQLite snapshot, you will have to download / edit path to file
##

# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')

# list tables
dbListTables(db)

# list fields in physical table
dbListFields(db, 'physical')

qq <- "
SELECT
hzn_top, hzn_bot, hzn_desgn, sand_total AS sand, silt_total AS silt, clay_total AS clay
FROM layer
JOIN physical ON layer.labsampnum = physical.labsampnum
WHERE hzn_desgn LIKE 'B%x%' 
;"

# run query
bx <- dbGetQuery(db, qq)

# close connection
dbDisconnect(db)


library(soilDB)

# SDA Interface, this requires a network connection but otherwise it just WORKS!
qq <- "SELECT
hzn_top, hzn_bot, hzn_desgn, sand_total AS sand, silt_total AS silt, clay_total AS clay
FROM lab_layer
JOIN lab_physical_properties ON lab_layer.labsampnum = lab_physical_properties.labsampnum
WHERE hzn_desgn LIKE 'B%x%' ;"

# run query
bx <- SDA_query(qq)

# ... continued at:
# https://github.com/ncss-tech/lab-data-delivery/blob/master/manual/Bx-example.R

##
## summarize sand, silt, clay for Bx horizons  
##

# number of records
nrow(bx)

# preview data
head(bx)


# extract components of texture, removing rows with missing data
ssc <- bx[, c('sand', 'silt', 'clay')]
ssc <- na.omit(ssc)

# adjust names for plotting with TT.plot()
# names must be SAND, SILT, CLAY
names(ssc) <- toupper(names(ssc))

# test of bogus data
ssc$sum <- rowSums(ssc[, c('SAND', 'SILT', 'CLAY')])
# > 5% deviation from 100%
idx <- which(abs(ssc$sum - 100) > 5)

# check errors: just one
ssc[idx, ]


# plot data
# note that there are many arguments used to ajust style
TT.plot(
  class.sys= "USDA-NCSS.TT",    # use "our" texture triangle
  tri.data=ssc,                 # data.frame with sand, silt, clay values
  main= "Bx Horizons",          # title
  tri.sum.tst=FALSE,            # do not test for exact sum(sand, silt, clay) == 100
  cex.lab=0.75,                 # scaling of label text
  cex.axis=0.75,                # scaling of axis
  cex=0.5,                      # scaling of point symbols
  col=alpha('royalblue', 0.125),  # color of point symbols, with transparency
  frame.bg.col='white',         # background color
  class.lab.col='black',        # color for texture class labels
  lwd.axis=1.5,                    # line thickness for axis
  arrows.show=TRUE
)
