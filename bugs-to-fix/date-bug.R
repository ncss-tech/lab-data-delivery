library(DBI)
library(RSQLite)

## lab data + compact MIR spectra (Jason + Dylan)
# dates are mangled
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/ncss_labdata.sqlite')

## older version, built by Dylan from CSV files
# dates seem OK here
# db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')


# list tables
dbListTables(db)

dbListFields(db, 'lab_pedon')


## confirm that dates are mangled in sqlite DB
dbGetQuery(db, "SELECT * FROM lab_pedon WHERE pedlabsampnum = '01P0244' ;")
dbGetQuery(db, "SELECT * FROM lab_combine_nasis_ncss WHERE pedlabsampnum = '01P0244' ;")

dbDisconnect(db)

## confirm date is mangled in SDA version of lab_pedon table
SDA_query("SELECT pedon_key, pedlabsampnum, user_pedon_id, observation_date FROM lab_pedon WHERE pedlabsampnum = '01P0244' ;")


## confirm dates appear to be correct in lab_combine_nasis_ncss table
SDA_query("SELECT pedon_key, pedlabsampnum, upedonid, samp_classdate, corr_classdate, site_obsdate FROM lab_combine_nasis_ncss WHERE pedlabsampnum = '01P0244' ;")


