library(soilDB)
library(DBI)
library(RSQLite)


## not on SDA
SDA_query("SELECT COUNT(*) from lab_mir_vw ;")
SDA_query("SELECT COUNT(*) from lab_mir ;")


# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/ncss_labdata.sqlite')

# list tables
dbListTables(db)


dbGetQuery(db, "SELECT COUNT(*) from lab_mir ;")


x <- dbGetQuery(db, "SELECT * from lab_mir_vw limit 1 ;")
str(x)


x <- dbGetQuery(db, "SELECT * from lab_mir_wavelength ;")
str(x)

## check number of local OPUS files
f <- list.files('e:/mir/MIR_Library/', recursive = TRUE, pattern = '\\.0')
length(f)



dbDisconnect(db)

