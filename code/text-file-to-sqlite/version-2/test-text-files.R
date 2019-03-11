##
##
##

library(readr)
# library(plyr)

# files to check
base.path <- '.'
files <- list.files(path=base.path, pattern='\\\\*.gz')


this.file <- 'EXPORT_Chemical_Properties_20190306.txt.gz'
x <- read_delim(this.file, delim = '|')
p <- problems(x)
x <- as.data.frame(x)

# init list to store parsing problems
l <- list()

# iterate over files
for(i in files) {
  this.file <- paste0(base.path, i)
  x <- read_csv(this.file, trim_ws = TRUE, guess_max = 1e6)
  l[[i]] <- problems(x)
}

# flatten
d <- ldply(l)

# summarize: not so bad
table(d$.id)

