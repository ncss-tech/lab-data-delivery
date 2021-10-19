
mir <- read.csv('NE_MIR.csv')
str(mir)

wv <- read.csv('Wavelength.csv')
str(wv)

# new basis
wv <- strsplit(wv$wavelength_string, split = ',', fixed = TRUE)
wv <- lapply(wv, as.numeric)


w.new <- as.numeric(
  strsplit(wv$wavelength_string[2], split = ',', fixed = TRUE)[[1]]
)


table(mir$d_wavelength_array_id)





w <- strsplit(mir$wavelength_string, split = ',', fixed = TRUE)
w <- lapply(w, as.numeric)

a <- strsplit(mir$absorbance, split = ',', fixed = TRUE)
a <- lapply(a, as.numeric)


table(sapply(w, length))

w[[1]]


a[[1]]


.interp <- function(w, a) {
  s <- splinefun(x = w, y = a, method = 'natural')
  res <- s(w.new)
  return(res)
}

z <- mapply(.interp, w = w, a = a)
matplot(z, type = 'l', lty = 1, col = 1)


a.mat <- do.call('cbind', a)
str(a.mat)

sqrt(mean((z - a.mat)^2))


rmse <- sapply(1:ncol(a.mat), FUN = function(i) {
  
  res <- sqrt(mean((z[, i] - a.mat[, i])^2))
  return(res)
  
})

hist(rmse, breaks = 30)



i <- 50

a.new <- .interp(w[[i]], a[[i]])


par(mar = c(4.5, 4, 4, 1))

plot(w[[i]], a[[i]], type = 'l', lwd = 6, col = 'grey', las = 1, xlab = 'Wavenumber (1/cm)', ylab = 'Absorbance', main = 'Original vs. Interpolated')
lines(w.new, a.new, col = 2)


idx <- 1000:800
plot(w[[i]][idx], a[[i]][idx], type = 'p', pch = 16, col = 'grey', las = 1, xlab = 'Wavenumber (1/cm)', ylab = 'Absorbance', main = 'Original vs. Interpolated')
lines(w.new[idx], a.new[idx], col = 2)




data.frame(
  wv_source = head(w[[1]], 10),
  a_source = head(a[[1]], 10),
  wv_interp = head(w.new, 10),
  a_interp = head(a.new, 10)
  
  
)


