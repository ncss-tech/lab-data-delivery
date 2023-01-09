
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
# as of 2023-01-16 there are 1594 collections
p <- list.dirs(file.path(base.path, 'MIR_Library'), recursive = TRUE, full.names = TRUE)

# remove the top-level directory
p <- p[-1]


## pre-process OPUS files
# result is a set of RDS files, by spectra collection
# ~ 15 minutes
# WD is the bottle-neck
# files cannot be open in OPUS software

# test working as expected: OK
# processOpusCollection(p[1], .output = proc.path)


plan(multisession)

# writes RDS, no output here
system.time(
  .trash <- future_map(p, .progress = TRUE, .f = processOpusCollection, .output = proc.path)
)

plan(sequential)

# done



