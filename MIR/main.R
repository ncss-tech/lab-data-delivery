##
##
##


# WD
setwd('MIR')

# build a set of RDS, one per spectra collection
# save to temporary folder for later use
source('pre-process-collections.R')

# create collection/sample/integer wn-sequence table
# create wn-sequence metadata table
# flag samples with odd wn-sequence
source('collect-wavenumber-metadata.R')

# build a compact MIR library 
source('build-compact-spectral-library.R')


