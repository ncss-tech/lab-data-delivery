## notes
# https://stackoverflow.com/questions/20547956/how-to-write-binary-data-into-sqlite-with-r-dbis-dbwritetable


library(DBI)
library(RSQLite)
library(opusreader2)

# functions waiting for an R package
source('../code/snapshot-preparation/snapshot-functions.R')

# base path for first-cut of export, based on Jason's new SQL
base.path <- 'E:/MIR'

# output SQLite DB file name
db.file <- file.path(base.path, 'MIR-compact.sqlite')

# init DB
# best to remove old version first
unlink(db.file)
db <- dbConnect(RSQLite::SQLite(), db.file)

## testing 1 2 3
# # a couple of examples
# f <- file.path(base.path, 'MIR_Library/C2001USCA048/26398XS01.0')
# 
# x <- read_opus(f, data_only = TRUE)
# plot(x$ab$wavenumbers, x$ab$data[1, ])
# plot((1/x$ab$wavenumbers)*1e7, x$ab$data[1, ], type = 'l', log = 'x')


## paths to full collection
p <- list.dirs(file.path(base.path, 'MIR_Library'), recursive = TRUE, full.names = TRUE)
# remove the top-level directory
p <- p[-1]


.collection <- p[1]

z <- processOpusCollection(.collection)
z <- processOpusCollection(.collection, compress = TRUE)


## iterate over collections / write intermediate pieces to files



## load into DB table

# testing
dbWriteTable(db, name = 'spec', value = z, row.names = FALSE, overwrite = TRUE)


# check
str(dbReadTable(db, 'spec'))

## index


# check
dbListTables(db)



## close file
dbDisconnect(db)

## compress final sqlite DB
R.utils::gzip(db.file, remove = FALSE, overwrite = TRUE)




