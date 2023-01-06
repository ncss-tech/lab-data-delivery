## notes
# https://stackoverflow.com/questions/20547956/how-to-write-binary-data-into-sqlite-with-r-dbis-dbwritetable


library(DBI)
library(RSQLite)
library(opusreader2)
library(furrr)
library(pbapply)



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

## create spec table
.sql <- "CREATE TABLE mir_spec (
id TEXT,
spec BLOB
);"
dbExecute(db, .sql)

## testing
# # a couple of examples
# f <- file.path(base.path, 'MIR_Library/C2001USCA048/26398XS01.0')
# 
# x <- read_opus(f, data_only = TRUE)
# plot(x$ab$wavenumbers, x$ab$data[1, ])
# plot((1/x$ab$wavenumbers)*1e7, x$ab$data[1, ], type = 'l', log = 'x')


## paths to full collection
# as of 2023-01-16 there are 1594 collections
p <- list.dirs(file.path(base.path, 'MIR_Library'), recursive = TRUE, full.names = TRUE)

# remove the top-level directory
p <- p[-1]


## establish baseline wave numbers and LUT
wn.lut <- read.csv('results/wn-LUT.csv')

# test
z <- collectSpectra(p[1])



## iterate over collections / write intermediate pieces to files
## parallel safe
td <- tempdir()

plan(multisession)

.trash <- future_map(p[1:100], .progress = TRUE, .f = function(i) {
  
  # z <- collectSpectra(.collection = i)
  z <- collectSpectra(.collection = i, compress = TRUE)
  
  .file <- sprintf("%s__MIR.rds", file.path(td, basename(i)))
  saveRDS(z, file = .file)
  
  
})

plan(sequential)


## load intermediate files into DB table
## not likely safe to do in parallel

.rds <- list.files(path = td, pattern = '__MIR', full.names = TRUE)
.trash <- pblapply(.rds, function(i) {
  z <- readRDS(i)
  .res <- dbAppendTable(db, name = 'mir_spec', z)
  rm(z)
  return(.res)
})

# check for errors


# testing
# dbWriteTable(db, name = 'spec', value = z, row.names = FALSE, overwrite = TRUE)

# table defs
# sqlCreateTable(db, 'spec', z[0, ], row.names = FALSE)


# check
str(x <- dbReadTable(db, 'mir_spec'))

.txt <- memDecompress(x$spec[[1]], type = 'gzip', asChar = TRUE)
.spec <- as.numeric(strsplit(.txt, ',', fixed = TRUE)[[1]])


## index


# check
dbListTables(db)



## close file
dbDisconnect(db)







## compress final sqlite DB
R.utils::gzip(db.file, remove = FALSE, overwrite = TRUE)

## cleanup
unlink(td, recursive = TRUE)



