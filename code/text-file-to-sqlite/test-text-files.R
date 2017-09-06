##
##
##

library(readr)
library(plyr)

# files to check
base.path <- 'C:/Users/Dylan.Beaudette/Desktop/NASIS-LIMS-dump/NASIS_Pedons/CSV_files/'
files <- list.files(path=base.path, pattern='\\\\*.csv')

# init list to store parsing problems
l <- list()

# iterate over files
for(i in files) {
  this.file <- paste0(base.path, i)
  x <- read_delim(this.file, delim = '|', quote='', na='', comment='', trim_ws = TRUE, guess_max = 1e6)
  l[[i]] <- problems(x)
}

# flatten
d <- ldply(l)

# summarize: not so bad
table(d$.id)

