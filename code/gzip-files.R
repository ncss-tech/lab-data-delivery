library(R.utils)


f <- list.files(path='E:/NASIS-KSSL-LDM/LDM/', pattern = '\\.txt|\\.csv', full.names = TRUE)

for(i in f) {
  print(i)
  gzip(i, remove=TRUE, skip=TRUE)
}

# # or, unzip
# for(i in f) {
#   print(i)
#   gunzip(i, remove=TRUE, skip=TRUE)
# }
