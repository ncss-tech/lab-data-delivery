##
##
##


# WD
setwd('MIR')

# build a set of RDS, one per spectra collection
# save to temporary folder for later use
source('pre-process-collections.R')

# evaluate errors
# eval-errors.R

# create collection/sample/integer wn-sequence table
# create wn-sequence metadata table
# flag samples with odd wn-sequence
source('collect-wavenumber-metadata.R')

# build a compact MIR library 
source('build-compact-spectral-library.R')


## TODO:
# 1. create spectra -- sample LUT
# 2. index
# 3. simplify code if possible
# 4. wrapper / helper functions

