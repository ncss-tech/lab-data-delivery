library(DBI)
library(RSQLite)
library(soilDB)
library(scales)

base.path <- 'E:/working-from-home-to-file/MIR/'
db.file <- file.path(base.path, 'ncss_labdata.sqlite')

db <- dbConnect(RSQLite::SQLite(), db.file)


dbListTables(db)
dbListFields(db, 'lab_combine_nasis_ncss')

dbListFields(db, 'lab_layer')
dbListFields(db, 'lab_chemical_properties')
dbListFields(db, 'lab_mir')
dbListFields(db, 'lab_mir_wavelength')

x <- dbGetQuery(db, "SELECT * FROM lab_mir LIMIT 10;")


x <- dbGetQuery(db, "SELECT * FROM lab_combine_nasis_ncss LIMIT 10;")


sql <- "
SELECT
nc.pedon_key, pedlabsampnum, peiid, upedonid, longitude_decimal_degrees, latitude_decimal_degrees,
CASE WHEN corr_name IS NULL THEN UPPER(samp_name) ELSE UPPER(corr_name) END AS taxonname,
hzn_top AS top, hzn_bot AS bottom, hzn_desgn AS hzname,
ll.labsampnum,
fe_dithionite_citrate_extractable AS fe_d
FROM
lab_combine_nasis_ncss AS nc
JOIN lab_layer AS ll ON nc.pedon_key = ll.pedon_key
JOIN lab_chemical_properties AS cp ON ll.labsampnum = cp.labsampnum
WHERE taxonname = 'CECIL'
;"

x <- dbGetQuery(db, sql)

nrow(x)
str(x)

IS <- format_SQL_in_statement(unique(x$labsampnum))
sql <- sprintf("SELECT * FROM lab_mir WHERE labsampnum IN %s ;", IS)

m <- dbGetQuery(db, sql)

nrow(m)
str(m)

table(m$d_wavelength_array_id)


## get wave number array, currently packed into a text field
sql <- "SELECT * FROM lab_mir_wavelength WHERE d_wavelength_array_id = 1;"
wv <- dbGetQuery(db, sql)

# split wave number text -> vector of wave numbers
wv <- strsplit(wv$wavelength_string, split = ',', fixed = TRUE)
wv <- lapply(wv, as.numeric)
wv <- unlist(wv)

# ok
str(wv)


# get some example MIR spectra, only measured values, no wave numbers
sql <- "SELECT * FROM lab_mir WHERE d_wavelength_array_id = 1 LIMIT 500;"
mir <- dbGetQuery(db, sql)

# split absorbance text -> list of absorbance vectors
a <- strsplit(mir$absorbance, split = ',', fixed = TRUE)
a <- lapply(a, as.numeric)

# ok
str(a)

# graphical check
par(mar = c(4.5, 4, 4, 1))

plot(wv, a[[1]], type = 'n', las = 1, xlab = 'Wavenumber (1/cm)', ylab = 'Absorbance', main = 'Some Example MIR Spectra', ylim = c(0, 2.5))

for(i in seq_along(a)) {
  lines(wv, a[[i]], type = 'l', col = alpha('royalblue', 0.125))
}


## TODO: make some helper functions to do this work

## TODO: add spectra -> soil color functions here




dbDisconnect(db)

