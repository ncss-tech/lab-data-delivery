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
library(pbapply)



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


## TODO: add toggle for compress = TRUE (TYPE BLOB)

## create empty spec table
.sql <- "CREATE TABLE mir_spec (
sample TEXT,
spec BLOB
);"
dbExecute(db, .sql)


## iterate over pre-processed RDS
f <- list.files(wd.path, full.names = TRUE)

# 2023-01-07: 1594 collections
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
# plain text: 6 minutes
# gz compression: 6 minutes

plan(multisession)

system.time(
  .trash <- future_map(f, .progress = TRUE, .f = function(i) {
    
    # single collection
    z <- collectSpectra(.collection = i, template = wnTemplate, compress = TRUE)
    
    .file <- sprintf("%s__MIR.rds", file.path(staging.dir, basename(i)))
    saveRDS(z, file = .file)
    
  })
)

plan(sequential)


## load intermediate files into DB table
## not likely safe to do in parallel
# plain text: ~2 minutes
# gz compressed: ~30 seconds

.rds <- list.files(path = staging.dir, full.names = TRUE)
.trash <- pblapply(.rds, function(i) {
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
# ~ 5 minutes
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

# uncompressed / gz(txt): 4.5GB
# gzipped / gz(txt):      4.4GB


# Dec 2022 MIR Library snapshot
# 650,714 Files
# * raw folders/files:   105GB
# * single zip archive:   88Gb 


## compress final sqlite DB
# ~ 10 minutes
system.time(
  R.utils::gzip(db.file, remove = FALSE, overwrite = TRUE)
)


## cleanup
unlink(staging.dir, recursive = TRUE)





##################


# testing
# dbWriteTable(db, name = 'spec', value = z, row.names = FALSE, overwrite = TRUE)

# table defs
# sqlCreateTable(db, 'spec', z[0, ], row.names = FALSE)

