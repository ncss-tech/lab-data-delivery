
library(opusreader2)
library(furrr)


## functions waiting for an R package
source('../code/snapshot-preparation/snapshot-functions.R')

## base path for first-cut of export, based on Jason's new SQL
base.path <- 'E:/MIR'

## temporary working directory, cleaned each time
wd.path <- 'E:/temp/MIR_work'
proc.path <- file.path(wd.path, 'processed-collections')
unlink(wd.path, recursive = TRUE, force = TRUE)
dir.create(proc.path, recursive = TRUE)


## paths to full collection
# as of 2023-01-16 there are 1594 collections (including some non-public)
# as of 2024-02-14: 1387 public collections
p <- list.dirs(file.path(base.path, 'MIR_Library'), recursive = TRUE, full.names = TRUE)

# remove the top-level directory
# also remove the _INSTRUCTIONS dir
p <- p[-c(1:2)]



## pre-process OPUS files
# result is a set of RDS files, by spectra collection
# ~ 13 minutes
# WD is the bottle-neck

# test working as expected: OK
# processOpusCollection(p[1], .output = proc.path)

# missing `ab` list element: 'e:/MIR/MIR_Library/C2019USNJ085/'

plan(multisession)

# writes RDS, result is a list of collections with no usable data
system.time(
  e <- future_map(p, .progress = TRUE, .f = processOpusCollection, .output = proc.path)
)

plan(sequential)

# keep track of errors


## cleanup
rm(list = ls())
gc(reset = TRUE)



