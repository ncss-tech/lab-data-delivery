library(DBI)
library(RSQLite)

# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')

# list tables
dbListTables(db)

# list fields
dbListFields(db, 'nasis_ncss')
dbListFields(db, 'physical')


# get data
dbGetQuery(db, "SELECT site_key, user_site_id from nasis_site WHERE user_site_id = 'S1999NY061001' ;")
dbGetQuery(db, "SELECT result_source_key, prep_code, labsampnum, clay_total, particle_size_method from physical WHERE result_source_key = 1 ;")
dbGetQuery(db, "SELECT result_source_key, prep_code, labsampnum, ca_nh4_ph_7, ca_nh4_ph_7_method from chemical WHERE result_source_key = 1 ;")
dbGetQuery(db, "SELECT * from calculations WHERE result_source_key = 1 ;")
dbGetQuery(db, "SELECT layer_key, natural_key, pedon_key, hzn_top, hzn_bot, hzn_desgn from layer WHERE pedon_key = 1 ;")


dbGetQuery(db, "SELECT layer_key, labsampnum, pedon_key, hzn_top, hzn_bot, hzn_desgn from layer WHERE pedon_key = 52931 ;")

dbGetQuery(db, "SELECT * from layer WHERE labsampnum = 'UCD03792' ;")

dbGetQuery(db, "SELECT * from layer WHERE labsampnum = 'UCD03792' ;")


x <- dbGetQuery(db, "SELECT * from physical WHERE labsampnum = '78P00891' ;")


x <- dbGetQuery(db, "SELECT pedobjupdate FROM nasis_ncss; ")

nrow(x)
head(x)




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



x.p[, c('labsampnum', 'prep_code', names(x.p)[grep('density', names(x.p))])]




## priority columns
x <- dbGetQuery(db, "SELECT * from nasis_ncss;")

table(x$priority, x$priority2)

table(x$labdatadescflag, x$priority2)
table(x$labdatadescflag, x$priority)



x <- dbGetQuery(db, "SELECT * FROM layer LIMIT 10 ;")


str(x)

# close file
dbDisconnect(db)

