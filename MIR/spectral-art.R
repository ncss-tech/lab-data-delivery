## install
# remotes::install_github("spectral-cockpit/opusreader2")

library(aqp)
library(scales)
library(viridisLite)

library(opusreader2)

#  an entire collection
# f <- list.files(path = 'E:/MIR/MIR_Library/R2014USNY055', pattern = '\\.0', full.names = TRUE)
f <- list.files(path = 'C:/Users/Dylan.Beaudette/OneDrive - USDA/Desktop/carbonates/spec', pattern = '\\.0', full.names = TRUE)


# try loading all at once: OK
x <- read_opus(f, data_only = TRUE)

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
# rows contain absorbance at a single WN, all files
s <- sapply(s, '[')

# check that all files are accounted for
ncol(s) == length(f)

# mir2vis(s[, 1], .wn = wn)

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

# white
# cols <- rgb(1, 1, 1, alpha = 0.125)


par(mar = c(1, 1, 0, 0), bg = 'black', fg = 'white')
matplot((1/wn)*1e7, s, lty = 1, type ='l', col = cols, las = 1, xlab = '', ylab = '', axes = FALSE)
lines((1/wn)*1e7, m, lwd = 1, col = 'white')
# mtext(expression(A), side = 2, line = -1, col = 'white', font = 2, cex = 1.5)
# mtext(expression(lambda), side = 1, line = -1, col = 'white', font = 2, cex = 1.5)
abline(h = min(s), v = min((1/wn)*1e7), col = grey(0.8))



# axis(side = 1, cex.axis = 0.66, col.axis = 'white', line = -4, at = pretty((1/wn)*1e7, n = 8))
# mtext('Absorbance', side = 2, line = -1, col = 'white')
# mtext('Wavelength', side = 1, line = -1, col = 'white')



ragg::agg_png(filename = 'pretty-spectra-dist-from-median.png', width = 2400, height = 1200, res = 150, scaling = 1.5)

par(mar = c(0, 0, 0, 0), bg = 'black', fg = 'white')
matplot(wn, s, lty = 1, type ='l', col = cols, las = 1, xlab = '', ylab = '', axes = FALSE, xlim = rev(range(wn)))
lines(wn, m, lwd = 0.5, col = 'white')

dev.off()


# 6k spectra -> 30 seconds
viscols <- apply(s, 2, mir2vis, .wn = wn, convert = FALSE)
viscols <- rgb(t(viscols), alpha = 0.05)

ragg::agg_png(filename = 'mir2vis-example.png', width = 2400, height = 1200, res = 150, scaling = 1.5)

par(mar = c(0, 0, 0, 0), bg = 'black', fg = 'white')
matplot(wn, s, lty = 1, type ='l', col = viscols, las = 1, xlab = '', ylab = '', axes = FALSE, xlim = c(range(wn)))

dev.off()
