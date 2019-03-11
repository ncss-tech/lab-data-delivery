library(R.utils)


f <- list.files(path='.', pattern = '\\.txt')

lapply(f, gzip, remove=TRUE, skip=TRUE)
