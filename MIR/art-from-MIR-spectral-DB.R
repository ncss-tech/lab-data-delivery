library(DBI)
library(RSQLite)

library(aqp)
library(scales)
library(viridisLite)
library(stringi)

library(MetBrewer)

## move to function library / soilDB
## TODO: slow for n > 1000

parseSpectra <- function(.txt, compressed = TRUE) {
  
  if(compressed) {
    # compressed spectra text
    # use list-column of raw values
    .txt <- sapply(.txt, memDecompress, type = 'gzip', asChar = TRUE)
  }
  
  # extract numeric vectors from text
  # result is a matrix of character data
  # rows -> full spectra (samples)
  # columns -> absorbance by wn
  .s <- stringi::stri_split_fixed(.txt, pattern = ',', simplify = TRUE)
  
  # text -> numeric
  # converts to numeric matrix
  .res <- apply(.s, 1, as.numeric)
  
  
  ## TODO: think about "right" form of matrix
  
  # return matrix 
  return(.res)
}



base.path <- 'E:/MIR'

# compressed spectra
db.file <- file.path(base.path, 'MIR-compact-compressed.sqlite')

# plain-text spectra
# db.file <- file.path(base.path, 'MIR-compact-text.sqlite')

# full
# db.file <- file.path(base.path, 'MIR-compact.sqlite')


db <- dbConnect(RSQLite::SQLite(), db.file)

dbListTables(db)
dbListFields(db, 'mir_spec')
dbListFields(db, 'mir_metadata')
dbListFields(db, 'mir_wn_sequence')


dbGetQuery(db, "SELECT * from mir_wn_sequence;")

## TODO: this should be defined in the DB
# define / get from DB
wn <- seq(from = 4000, to = 600, by = -2)

# single record
str(x <- dbGetQuery(db, "SELECT * from mir_metadata WHERE collection = 'C2001USAK206';"))
str(x <- dbGetQuery(db, "SELECT * from mir_spec WHERE sample = '32987XS04';"))

# compressed data: OK
.txt <- memDecompress(x$spec[[1]], type = 'gzip', asChar = TRUE)
.spec <- as.numeric(strsplit(.txt, ',', fixed = TRUE)[[1]])

plot(wn, .spec, type = 'l', xlab = 'Wavenumber (1/cm)', ylab = 'Absorbance', las = 1)


# 8000 random spectra
x <- dbGetQuery(db, "SELECT * from mir_spec LIMIT 2000;")

# convenience function for converting 
s <- parseSpectra(x$spec, compressed = TRUE)
# s <- parseSpectra(x$spec, compressed = FALSE)


# matplot(wn, s, type = 'l', col = 1, lty = 1)



# color based on distance from median spectra
m <- apply(s, 1, FUN = median, na.rm = TRUE)
d <- sweep(s, MARGIN = 1, STATS = m, FUN = '-')^2
d <- sqrt(colSums(d))

# base color palette
cp <- mako(n = 100, direction = 1)

# color interpolator function
cpf <- colorRamp(cp, space = 'Lab', interpolate = 'spline')

# values -> color translation function
cn <- col_numeric(palette = cpf, domain = range(d), alpha = FALSE)

# convert values -> colors and apply transparency
cols <- alpha(cn(d), alpha = 0.125)


ragg::agg_png(filename = 'pretty-spectra-dist-from-median-02.png', width = 2400, height = 1200, res = 150, scaling = 1.5)

par(mar = c(0, 0, 0, 0), bg = 'black', fg = 'white')
matplot(wn, s, lty = 1, type ='l', col = cols, las = 1, xlab = '', ylab = '', axes = FALSE, xlim = rev(range(wn)))
lines(wn, m, lwd = 0.5, col = 'white')

dev.off()


cp <- rev(met.brewer('Hiroshige', n = 100))
# color interpolator function
cpf <- colorRamp(cp, space = 'Lab', interpolate = 'spline')

# values -> color translation function
cn <- col_numeric(palette = cpf, domain = range(d), alpha = FALSE)

# convert values -> colors and apply transparency
cols <- alpha(cn(d), alpha = 0.125)


pdf(file = 'art-01.pdf', width = 24, height = 12)

par(mar = c(0, 0, 0, 0))
matplot(wn, s, lty = 1, type ='l', col = cols, las = 1, xlab = '', ylab = '', axes = FALSE, xlim = rev(range(wn)))
lines(wn, m, lwd = 0.5, col = 'black')

dev.off()


dbDisconnect(db)


