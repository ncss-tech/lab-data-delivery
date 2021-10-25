# remotes::install_github("pierreroudier/opusreader")

library(opusreader)

wtf <- function(f) {
  x <- opus_read(f, type = 'spec', simplify = TRUE, progress = FALSE)
  x1 <- opus_read(f, type = 'sc_sample', simplify = TRUE, progress = FALSE)
  x2 <- opus_read(f, type = 'sc_ref', simplify = TRUE, progress = FALSE)
  
  plot(0, 0, type = 'l', las = 1, xlim = c(0, 4000), ylim = c(0, 2), xlab = '', ylab = '')
  lines(as.vector(x$spec), col = 1)
  lines(as.vector(x1$sc_sample), col = 2)
  lines(as.vector(x2$sc_ref), col = 3)
  
  legend('topleft', legend = c('Spectra (AB)', 'Sample Measurement', 'Reference'), lty = 1, col = 1:3, bty = 'n', cex = 0.8, horiz = TRUE)
  
  title(basename(f))
}


par(mar = c(3, 3, 3, 1), mfrow = c(2, 1))
wtf('E:/working-from-home-to-file/MIR/example/C2001USCA048/26398XS01.0')

wtf('E:/working-from-home-to-file/MIR/example/C2001USCA048/26456XS03.0')




x <- opus_read('E:/working-from-home-to-file/MIR/example/C2001USCA048/26398XS01.0')

plot(x$wavenumbers, x$spec, type = 'l')

plot((1/x$wavenumbers)*1e7, x$spec, type = 'l', log = 'x')

summary((1/x$wavenumbers)*1e7)


# an entire collection
f <- list.files(path = 'E:/working-from-home-to-file/MIR/example/C2001USCA048', pattern = '\\.0', full.names = TRUE)


# 
# [1] "E:/working-from-home-to-file/MIR/example/C2001USCA048/26456XS03.0"
# [1] "E:/working-from-home-to-file/MIR/example/C2001USCA048/26478XS01.0"
# [1] "E:/working-from-home-to-file/MIR/example/C2001USCA048/26478XS02.0"
# [1] "E:/working-from-home-to-file/MIR/example/C2001USCA048/26478XS03.0"

# some bad ones in there
for(i in f) {
  
  res <- tryCatch(
    opus_read(i, simplify = TRUE, wns_digits = 3, progress = FALSE), 
    error = function(e) e, 
    warning = function(w) w
  )
  
  if(length(res) == 2) {
    print(i)
  }
}



x <- opus_read(f, simplify = TRUE, wns_digits = 3)

s <- t(x$spectra)
matplot(x$wavenumbers, s, lty = 1, type ='l', col = rgb(0, 0, 0, alpha = 0.125), las = 1, xlab = 'Wavenumber', ylab = 'Absorbance')

        
