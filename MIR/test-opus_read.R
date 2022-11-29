## Test automated extraction of spectra + metadata from OPUS files
## using opusreader2 package
## 2022-10-21
## D.E Beaudette

## install
# remotes::install_github("spectral-cockpit/opusreader2")

library(opusreader2)

# a couple of examples
f <- 'E:/working-from-home-to-file/MIR/example/C2001USCA048/26398XS01.0'
f <- 'E:/working-from-home-to-file/MIR/example/C2001USCA048/26456XS03.0'
f <- "E:/working-from-home-to-file/MIR/example/C2001USCA048/26456XS03.0"

x <- read_opus(f, data_only = TRUE)
plot(x$ab$wavenumbers, x$ab$data[1, ])
plot((1/x$ab$wavenumbers)*1e7, x$ab$data[1, ], type = 'l', log = 'x')

# works fine




## try an entire collection
f <- list.files(path = 'E:/working-from-home-to-file/MIR/example/C2001USCA048', pattern = '\\.0', full.names = TRUE)

# try loading sequentially: OK
for(i in f) {
  
  res <- tryCatch(
    read_opus(i, data_only = TRUE, progress = FALSE), 
    error = function(e) e, 
    warning = function(w) w
  )
  
  if(length(res) == 2) {
    print(i)
  }
}


## try loading all at once: OK
x <- read_opus(f, data_only = TRUE)

# is there a "flattening" method?

# extract spectra from each object
s <- lapply(x, function(i) {i$ab$data[1, ]})

# just to be sure, all WN should be the same
wn <- t(sapply(x, function(i) {i$ab$wavenumbers}))

# yes, all the same
str(wn)
str(unique(wn))


# wavenumbers are shared, extract the first one
wn <- x[[1]]$ab$wavenumbers

# convert spectra list -> matrix
# rows contrain absorbance at a single WN, all file
s <- sapply(s, '[')

# check that all files are accounted for
ncol(s) == length(f)

par(mar = c(1, 1, 0, 0), bg = 'black', fg = 'white')
matplot((1/wn)*1e7, s, lty = 1, type ='l', col = rgb(1, 1, 1, alpha = 0.125), las = 1, xlab = 'Wavenumber', ylab = '', axes = FALSE)
mtext('Absorbance', side = 2, line = -1, col = 'white')
mtext('1/Wavenumber', side = 1, line = -1, col = 'white')
abline(h = 0, v = min((1/wn)*1e7), col = 'white')



# 
# ##
# ## previous testing of original opusreader package
# ##
# 
# ## files previously mis-read:
# # 
# # [1] "E:/working-from-home-to-file/MIR/example/C2001USCA048/26456XS03.0"
# # [1] "E:/working-from-home-to-file/MIR/example/C2001USCA048/26478XS01.0"
# # [1] "E:/working-from-home-to-file/MIR/example/C2001USCA048/26478XS02.0"
# # [1] "E:/working-from-home-to-file/MIR/example/C2001USCA048/26478XS03.0"
# 
# 
# 
# 
# wtf <- function(f) {
#   x <- read_opus(f, type = 'spec', simplify = TRUE, progress = FALSE)
#   x1 <- read_opus(f, type = 'sc_sample', simplify = TRUE, progress = FALSE)
#   x2 <- read_opus(f, type = 'sc_ref', simplify = TRUE, progress = FALSE)
#   
#   plot(0, 0, type = 'l', las = 1, xlim = c(0, 4000), ylim = c(0, 2), xlab = '', ylab = '')
#   lines(as.vector(x$spec), col = 1)
#   lines(as.vector(x1$sc_sample), col = 2)
#   lines(as.vector(x2$sc_ref), col = 3)
#   
#   legend('topleft', legend = c('Spectra (AB)', 'Sample Measurement', 'Reference'), lty = 1, col = 1:3, bty = 'n', cex = 0.8, horiz = TRUE)
#   
#   title(basename(f))
# }
# 
# 
# par(mar = c(3, 3, 3, 1), mfrow = c(2, 1))
# wtf('E:/working-from-home-to-file/MIR/example/C2001USCA048/26398XS01.0')
# 
# wtf('E:/working-from-home-to-file/MIR/example/C2001USCA048/26456XS03.0')



