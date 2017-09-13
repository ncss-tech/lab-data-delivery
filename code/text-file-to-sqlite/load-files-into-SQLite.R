##
##
##

# ideas: https://cran.r-project.org/web/packages/RSQLite/vignettes/RSQLite.html

library(readr)
library(plyr)
library(DBI)
library(RSQLite)

# files to check
base.path <- 'C:/Users/Dylan.Beaudette/Desktop/NASIS-LIMS-dump/NCSS_Characterization_Database/CSV_files/'
files <- list.files(path=base.path, pattern='\\\\*.txt')


# init DB
# best to remove old version first
unlink("KSSL-data.sqlite")
unlink("KSSL-schema.sql")
db <- dbConnect(RSQLite::SQLite(), "KSSL-data.sqlite")


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
  cat(sqliteBuildTableDefinition(db, this.table, value=x[0,], row.names=FALSE), file = 'KSSL-schema.sql', append = TRUE, sep = '\n')
  
}

dbListTables(db)

dbDisconnect(db)
