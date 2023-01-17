library(aqp)
library(scales)

# 380--730nm, 10nm resolution
data("munsell.spectra.wide")

# # frequency: 
# # density of measurements are packed at red end of the spectrum
# # consider histogram normalizaion
# 
# # wavenumbers have even distribution
# hist(f, breaks = 80, las = 1)

## TODO:
# colors are really boring using WN directly

# .spec <- s[, 1]



mir2vis <- function(.spec, .wn, resolution = 5, ...) {
  
  # flip wave number ordering
  .spec <- rev(.spec)
  .wn <- rev(.wn)
  
  ## colors are yellow / tan
  # convert to reflectance
  z <- 1 - .spec
  
  ## colors are blue/purple
  # retain absorbance
  # z <- .spec
  
  # rescale absorbance
  # adjust max to control lightness
  r <- rescale(z, to = c(0.1, 0.6))
  
  # shift / rescale wavenumbers -> frequency (nm) to visible range
  f <- rescale(.wn, to = c(380, 730))
  
  # generate aggregating labels
  # width / target resolution
  .labs <- ((730 - 380) / resolution) + 1
  .labs <- 1:.labs
  
  # replicate labels enough times to fill original sequence + some extra
  .al <- rep(.labs, each = ceiling(length(r) / length(.labs)))
  # truncate at original length
  .al <- .al[1:length(r)]
  
  # group-wise median
  rprime <- tapply(r, .al, median)
  
  # # check
  # plot(f, r, las = 1, type = 'l', lwd = 2)
  # lines(seq(380, 730, by = 5), rprime, col = 2, type = 'b')
  
  .res <- spec2Munsell(rprime, res = 5, ...)
  return(.res)
}


mir2vis(s[, 1], wn = wn, convert = TRUE)
mir2vis(s[, 1], wn = wn, convert = FALSE)


# length(rprime)
# length(munsell.spectra.wide$wavelength)
# points(munsell.spectra.wide$wavelength, rprime, col = 4, pch = 16, cex = 1)

# 
# plot(f, r, las = 1, type = 'l', lwd = 2)
# lines(munsell.spectra.wide$wavelength, rprime, col = 4, pch = 16, cex = 1, type = 'b')
# rug(munsell.spectra.wide$wavelength)
# 
# spec2Munsell(rprime)
# 
# cols <- spec2Munsell(rprime, convert = FALSE)
# 
