##
##
##

# ideas: https://cran.r-project.org/web/packages/RSQLite/vignettes/RSQLite.html

library(readr)
library(plyr)
library(DBI)
library(RSQLite)

# files to check
base.path <- 'C:/Users/Dylan.Beaudette/Desktop/NASIS-LIMS-dump/NASIS_Pedons/CSV_files/'
files <- list.files(path=base.path, pattern='\\\\*.csv')


# init DB
db <- dbConnect(RSQLite::SQLite(), "NASIS-pedons.sqlite")
unlink('NASIS-pedons-schema.sql')


# iterate over files
for(i in files) {
  this.file <- paste0(base.path, i)
  this.table <- gsub(pattern = '.csv', '', i)
  x <- read_delim(this.file, delim = '|', quote='', na='', comment='', trim_ws = TRUE, guess_max = 1e6)
  
  # # attempt to write schema only: OK
  # dbWriteTable(db, name = this.table, value = x[0, ], row.names=FALSE, overwrite=TRUE)
  
  # attemp to write all rows: OK
  dbWriteTable(db, name = this.table, value = x, row.names=FALSE, overwrite=TRUE)
  
  # save schema for review:
  cat(sqliteBuildTableDefinition(db, this.table, value=x[0,], row.names=FALSE), file = 'schema.sql', append = TRUE, sep = '\n')
  
}

dbListTables(db)

dbDisconnect(db)
