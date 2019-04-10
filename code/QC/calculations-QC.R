library(DBI)
library(RSQLite)

# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')

# quick check: tables / fields
dbListTables(db)
dbListFields(db, 'calculations')

# 
x <- dbGetQuery(db, "SELECT * FROM calculations;", stringsAsFactors=FALSE)

# none in here
x[x$labsampnum == 'UCD03064', ]

grep('UCD', x$labsampnum)


x <- dbGetQuery(db, "SELECT * FROM layer WHERE pedon_key = 53109;")

x <- dbGetQuery(db, "SELECT * FROM layer WHERE layer_field_label_1 = 'UCD1400';")

x <- dbGetQuery(db, "SELECT * FROM layer WHERE pedon_key = 53224;")  
