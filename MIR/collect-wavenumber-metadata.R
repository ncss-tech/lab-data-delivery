
library(furrr)
library(purrr)

## functions waiting for an R package
source('../code/snapshot-preparation/snapshot-functions.R')

## base path for processed OPUS spectra + raw wave numbers
base.path <- 'E:/temp/MIR_work/processed-collections'

## paths to full collection
# as of 2023-01-16 there are 1594 collections (including some non-public)
# as of 2024-02-14: 1387 public collections
f <- list.files(base.path, full.names = TRUE)

## testing: ok
# z <- wavenumberMetadata(f[1])
# str(z)

## TODO: not robust to NULL list elements

## collection metadata by collection/sample/integer wn-sequence
# ~ 2 minutes
plan(multisession)

system.time(
  z <- future_map(f, .progress = TRUE, .f = safely(wavenumberMetadata))
)

plan(sequential)

# test for error conditions
e <- sapply(z, '[', 'error')
which(!sapply(e, is.null))

# extract results
z <- sapply(z, '[', 'result') 

# flatten
z <- do.call('rbind', z)
row.names(z) <- NULL

## 2023-01-09: 325369 rows
## 2024-02-14: 186893 rows
nrow(z)
str(z)

# double check that there are three distinct WN sequences
stopifnot(length(unique(z$wn)) == 3)

# id for simpler description
z$wnID <- factor(z$wn, labels = 1:3)

## frequency
# 1      2      3 
# 2472  55052 129369 
table(z$wnID)



## save metadata

# unique wn sequences
lut <- unique(z[, c('wnID', 'wn')])
write.csv(lut, file = 'results/wn-LUT.csv', row.names = FALSE)

# collection/sample/wnID
write.csv(z[, c('collection', 'sample', 'wnID')], file = gzfile('results/collection-metadata.csv.gz'), row.names = FALSE)


## should we just use an integer sequence of 1 or 2 wn?
wnTemplate <- as.numeric(strsplit(lut$wn[1], split = ',', fixed = TRUE)[[1]])
# note that most intervals are 2, a few are 1
table(diff(wnTemplate))


## what causes the differences in the 2 most frequent wn sequences?
# alpha model
# vertex model

w <- strsplit(lut$wn, split = ',', fixed = TRUE)
str(w, 1)

# List of 3
# $ : chr [1:1765] "4002" "4000" "3998" "3996" ...
# $ : chr [1:1765] "4002" "4000" "3998" "3996" ...
# $ : chr [1:1765] "4001" "4000" "3998" "3996" ...

# ~ 19 elements in the integer wn sequence are off by 1
idx <- which(w[[1]] != w[[2]])

cbind(
  w[[1]][idx],
  w[[2]][idx]
)

# [,1]   [,2]  
# [1,] "3979" "3978"
# [2,] "3952" "3951"
# [3,] "3925" "3924"
# [4,] "3898" "3897"
# [5,] "3871" "3870"
# [6,] "3844" "3843"
# [7,] "3817" "3816"
# [8,] "2199" "2198"
# [9,] "2172" "2171"
# [10,] "2145" "2144"
# [11,] "2118" "2117"
# [12,] "2091" "2090"
# [13,] "2064" "2063"
# [14,] "2037" "2036"
# [15,] "2010" "2009"
# [16,] "1983" "1982"
# [17,] "1956" "1955"
# [18,] "1929" "1928"
# [19,] "1902" "1901"



## 2024-02-14: no longer a problem in public data
## what is going on with the strange sequence 600-7498?
# 28 samples
# nrow(x <- z[z$wnID == 3, ])
# knitr::kable(x[, 1:2], row.names = FALSE)

range(as.numeric(strsplit(x$wn[1], split = ',', fixed = TRUE)[[1]]))

## cleanup
rm(list = ls())
gc(reset = TRUE)






