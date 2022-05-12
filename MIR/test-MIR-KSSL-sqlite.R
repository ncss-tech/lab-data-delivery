library(DBI)
library(RSQLite)
library(soilDB)

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





dbDisconnect(db)

