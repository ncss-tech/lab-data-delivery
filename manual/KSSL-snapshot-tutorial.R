library(DBI)
library(RSQLite)

# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')

# list tables
dbListTables(db)

# list fields
dbListFields(db, 'ncss_site')
dbListFields(db, 'physical')


# get data
dbGetQuery(db, "SELECT pedon_key, pedlabsampnum, pedoniid, upedonid, corr_name from ncss_site WHERE upedonid = 'S1999NY061001' ;")
dbGetQuery(db, "SELECT result_source_key, prep_code, labsampnum, clay_total, particle_size_method from physical WHERE result_source_key = 1 ;")
dbGetQuery(db, "SELECT result_source_key, prep_code, labsampnum, ca_nh4_ph_7, ca_nh4_ph_7_method from chemical WHERE result_source_key = 1 ;")
dbGetQuery(db, "SELECT * from calculations WHERE result_source_key = 1 ;")
dbGetQuery(db, "SELECT layer_key, natural_key, pedon_key, hzn_top, hzn_bot, hzn_desgn from layer WHERE pedon_key = 1 ;")


dbGetQuery(db, "SELECT layer_key, natural_key, pedon_key, hzn_top, hzn_bot, hzn_desgn from layer WHERE pedon_key = 52931 ;")


# none in here...
dbGetQuery(db, "SELECT * from calculations WHERE labsampnum = 'UCD03792' ;")

x.c <- dbGetQuery(db, "SELECT * from chemical WHERE labsampnum = 'UCD03792' ;")
x.p <- dbGetQuery(db, "SELECT * from physical WHERE labsampnum = 'UCD03792' ;")

f <- function(i) {
  ! all(is.na(i))
} 

idx <- which(sapply(x.c, f))
x.c[, idx]

idx <- which(sapply(x.p, f))
x.p[, idx]



# close file
dbDisconnect(db)
