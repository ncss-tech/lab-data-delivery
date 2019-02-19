##
##
##

# TODO: convert this into a function and run on all 3 databases

# ideas: https://cran.r-project.org/web/packages/RSQLite/vignettes/RSQLite.html

library(readr)
library(plyr)
library(DBI)
library(RSQLite)

makeSQLiteFromCSV <- function(type, base.path) {
  # files to check
  files <- list.files(path=base.path, pattern='\\\\*.txt')
  
  # output files
  db.file <- sprintf("%s-data.sqlite", type)
  db.schema <- sprintf("%s-schema.sql", type)
  
  # init DB
  # best to remove old version first
  unlink(db.file)
  unlink(db.schema)
  db <- dbConnect(RSQLite::SQLite(), db.file)
  
  # iterate over files
  for(i in files) {
    this.file <- paste0(base.path, i)
    this.table <- gsub(pattern = '.txt', '', i)
    x <- read_delim(this.file, delim = '|', quote='', na='', comment='', trim_ws = TRUE, guess_max = 1e6)
    
    # # attempt to write schema only: OK
    # dbWriteTable(db, name = this.table, value = x[0, ], row.names=FALSE, overwrite=TRUE)
    
    # note this flushes to disk at each iteration
    # attemp to write all rows: OK
    dbWriteTable(db, name = this.table, value = x, row.names=FALSE, overwrite=TRUE)
    
    # save schema for review:
    ## TODO: switch to sqlCreateTable()
    cat(sqliteBuildTableDefinition(db, this.table, value=x[0,], row.names=FALSE), file = db.schema, append = TRUE, sep = '\n')
    
  }
  
  # dbListTables(db)
  
  dbDisconnect(db)
  
}


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



