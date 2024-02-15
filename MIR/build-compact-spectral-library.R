## notes
# https://stackoverflow.com/questions/20547956/how-to-write-binary-data-into-sqlite-with-r-dbis-dbwritetable


## from Rich Ferguson:
# The KSSL collects IR spectra from 7500 - 600.  
# Only the MIR region from 4000 - 600 is validated and shared with customers.  
# The NIR region from 7500 to 4000 is not currently validated and not shared.

library(DBI)
library(RSQLite)
library(opusreader2)
library(furrr)
library(purrr)


## flag for embedding compressed spectra
# useful for stand-alone SQLite versions, not for SDA
# requires a little more work when reading data out of the SQLite DB
compressSpec <- TRUE

# functions waiting for an R package
source('../code/snapshot-preparation/snapshot-functions.R')

# base path for first-cut of export, based on Jason's new SQL
base.path <- 'E:/MIR'

# pre-processed collection RDS dir
wd.path <- 'E:/temp/MIR_work/processed-collections'

# staging dir for appending to DB
staging.dir <- 'E:/temp/MIR_work/staging'
unlink(staging.dir, recursive = TRUE, force = TRUE)
dir.create(staging.dir, recursive = TRUE)


# output SQLite DB file name
db.file <- file.path(base.path, 'MIR-compact.sqlite')

# init DB
# best to remove old version first
unlink(db.file)
db <- dbConnect(RSQLite::SQLite(), db.file)


## create MIR metadata table
collection.metadata <- read.csv('results/collection-metadata.csv.gz')
dbWriteTable(db, 'mir_metadata', collection.metadata)

## create MIR wavenumber sequence table
wn.lut <- read.csv('results/wn-LUT.csv')
dbWriteTable(db, 'mir_wn_sequence', wn.lut)


## create empty spec table
if(compressSpec) {
  .sql <- "CREATE TABLE mir_spec (
sample TEXT,
spec BLOB
);"
} else {
  .sql <- "CREATE TABLE mir_spec (
sample TEXT,
spec TEXT
);"
}

dbExecute(db, .sql)


## iterate over pre-processed RDS
f <- list.files(wd.path, full.names = TRUE)

# 2023-01-07: 1594 collections
# 2024-02-14: 1386 collections
length(f)

## select a wavenumber template
wnTemplate <- as.numeric(strsplit(wn.lut$wn[1], split = ',', fixed = TRUE)[[1]])
range(wnTemplate)

# for now, use integer template [4000, 600] by 2
wnTemplate <- seq(from = 4000, to = 600, by = -2)

## TODO: add wnTemplate to the DB



## test: ok
# z <- collectSpectra(.collection = f[1], template = wnTemplate, compress = FALSE)
# z <- collectSpectra(.collection = f[1], template = wnTemplate, compress = TRUE)


## iterate over collections / write intermediate pieces to files
## parallel safe
# plain text: 2 minutes
# gz compression: 2 minutes

plan(multisession)

system.time(
  future_walk(f, .progress = TRUE, .f = function(i) {
    
    # single collection
    z <- collectSpectra(.collection = i, template = wnTemplate, compress = compressSpec)
    
    .file <- sprintf("%s__MIR.rds", file.path(staging.dir, basename(i)))
    saveRDS(z, file = .file)
  })
)

plan(sequential)


## load intermediate files into DB table
## not likely safe to do in parallel
# plain text: ~2 minutes
# gz compressed: ~10 seconds

.rds <- list.files(path = staging.dir, full.names = TRUE)

walk(.rds, .progress = TRUE, .f = function(i) {
  z <- readRDS(i)
  .res <- dbAppendTable(db, name = 'mir_spec', z)
  rm(z)
  return(.res)
})



## check
dbListTables(db)


## index
# note: using 'db' connection from global env
indexTable('mir_metadata', c('collection', 'sample'))
indexTable('mir_spec', 'sample')

## cleanup
# ~ 2 minutes
dbExecute(db, 'VACUUM;')
dbExecute(db, 'VACUUM;')


## close DB connection / file lock
dbDisconnect(db)


## check results
db <- dbConnect(RSQLite::SQLite(), db.file)



# plaintext: OK
str(x <- dbGetQuery(db, "SELECT * from mir_metadata WHERE collection = 'C2001USAK206';"))
str(x <- dbGetQuery(db, "SELECT * from mir_spec WHERE sample = '32987XS04';"))

# compressed data: OK
.txt <- memDecompress(x$spec[[1]], type = 'gzip', asChar = TRUE)
.spec <- as.numeric(strsplit(.txt, ',', fixed = TRUE)[[1]])

plot(1e7/wnTemplate, .spec, type = 'l', xlab = 'Wavelength (nm)', ylab = 'Absorbance', las = 1)
plot(wnTemplate, .spec, type = 'l', xlab = 'Wavenumber (1/cm)', ylab = 'Absorbance', las = 1)

# done
dbDisconnect(db)



## SQLite file stats
# uncompressed / txt:     9.5GB
# gzipped / txt:          4.2GB

# uncompressed / gz(txt): 2.6GB
# gzipped / gz(txt):      GB


# Dec 2022 MIR Library snapshot
# 650,714 Files
# * raw folders/files:   105GB
# * single zip archive:   88Gb 

# Feb 2024 Public MIR Library
# 373,818 Files
# * raw folders/files:    61GB

## compress final sqlite DB
# ~ 10 minutes
system.time(
  R.utils::gzip(db.file, remove = FALSE, overwrite = TRUE)
)


## cleanup
unlink(staging.dir, recursive = TRUE)


## cleanup
rm(list = ls())
gc(reset = TRUE)




##################


# testing
# dbWriteTable(db, name = 'spec', value = z, row.names = FALSE, overwrite = TRUE)

# table defs
# sqlCreateTable(db, 'spec', z[0, ], row.names = FALSE)

