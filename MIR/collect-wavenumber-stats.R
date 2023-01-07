
library(furrr)

## functions waiting for an R package
source('../code/snapshot-preparation/snapshot-functions.R')

## base path for processed OPUS spectra + raw wave numbers
base.path <- 'E:/temp/MIR_work/processed-collections'

## paths to full collection
# as of 2023-01-16 there are 1594 collections
p <- list.files(base.path, full.names = TRUE)

# 2023-01-07: 1594 collections
length(p)

## testing
# good
# wavenumberStats(p[1])

## establish baseline wave numbers and LUT
# ~ 2 minutes
plan(multisession)

system.time(
  z <- future_map(p, .progress = TRUE, .f = wavenumberStats)
)

plan(sequential)

# flatten
z <- do.call('rbind', z)
z <- unique(z)
nrow(z)


## what causes the differences in wn sequences?
# alpha model
# vertex model
# !!??: wn starting from 7498

w <- strsplit(z$wn, split = ',', fixed = TRUE)
str(w, 1)

# List of 3
# $ : chr [1:1765] "4002" "4000" "3998" "3996" ...
# $ : chr [1:1765] "4002" "4000" "3998" "3996" ...
# $ : chr [1:3578] "7498" "7496" "7494" "7492" ...

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


## save LUT for later

# add ID and move columns
z$id <- 1:nrow(z)
z <- z[, c('id', 'wn')]

write.csv(z, file = 'results/wn-LUT.csv', row.names = FALSE)


## TODO: figure out third wn possibility



