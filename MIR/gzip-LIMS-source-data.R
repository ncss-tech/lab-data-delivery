library(R.utils)


f <- list.files(path='E:/working-from-home-to-file/MIR/LIMS_snapshot/', pattern = '\\.txt$|\\.csv$', full.names = TRUE)

for(i in f) {
  print(i)
  gzip(i, remove=TRUE, skip=TRUE)
}
