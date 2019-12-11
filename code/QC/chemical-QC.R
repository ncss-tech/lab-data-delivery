library(DBI)
library(RSQLite)

# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')

# quick check: tables / fields
dbListTables(db)
dbListFields(db, 'chemical')

# get all layer table records
x <- dbGetQuery(db, "SELECT * from chemical;", stringsAsFactors=FALSE)

# field types and NA eval
str(x)

# close file
dbDisconnect(db)

