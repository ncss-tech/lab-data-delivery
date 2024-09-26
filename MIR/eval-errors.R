library(opusreader2)
library(purrr)

# all collections
x <- readRDS('errors.rds')

# find just the collections with errors
idx <- which(! sapply(x, is.null))
x <- x[idx]


## 2024-02-14 errors:
## C2019USNJ085

z <- read_opus('E:/MIR/MIR_Library/C2019USNJ085/291505XS01.0', data_only = TRUE)
