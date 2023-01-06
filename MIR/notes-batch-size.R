library(opusreader2)

base.path <- 'E:/MIR/MIR_Library' 

f <- list.files(path = base.path, pattern = '\\.0', full.names = TRUE, recursive = TRUE)

# 325,370 files
length(f)

# better to process in batches

# does this even work?
# will eventually run out of memory
# WD is a huge bottle-neck
system.time(
  x <- opusreader2::read_opus(f, data_only = TRUE, parallel = TRUE, progress_bar = TRUE)
)


