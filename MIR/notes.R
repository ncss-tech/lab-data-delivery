library(opusreader2)

# testing
# a couple of examples
f <- file.path(base.path, 'MIR_Library/C2001USCA048/26398XS01.0')

x <- read_opus(f, data_only = TRUE)
plot(x$ab$wavenumbers, x$ab$data[1, ])
plot((1/x$ab$wavenumbers)*1e7, x$ab$data[1, ], type = 'l', log = 'x')
