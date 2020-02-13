library(DBI)
library(RSQLite)
library(daff)


## created by Dylan from text output from SQL Server (Jason)
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')

## created by Adolfo via ESRI tools
db.ad <- dbConnect(RSQLite::SQLite(), 'E:/temp/NCSS_Characterization_Database_newSchema_20200114.sqlite')


dbListTables(db)
dbListTables(db.ad)


# indexes
# https://stackoverflow.com/questions/13426006/how-do-i-get-a-list-of-indexed-columns-for-a-given-table
dbGetQuery(db, "SELECT DISTINCT m.name || '.' || ii.name AS 'indexed-columns'
  FROM sqlite_master AS m,
           pragma_index_list(m.name) AS il,
           pragma_index_info(il.name) AS ii
           WHERE m.type = 'table'
           ORDER BY 1;")

dbGetQuery(db.ad, "SELECT DISTINCT m.name || '.' || ii.name AS 'indexed-columns'
  FROM sqlite_master AS m,
           pragma_index_list(m.name) AS il,
           pragma_index_info(il.name) AS ii
           WHERE m.type = 'table'
           ORDER BY 1;")


# quick check: tables / fields
f <- dbListFields(db, 'nasis_pedon')
f.ad <- dbListFields(db.ad, 'pedon')

setdiff(f, f.ad)
setdiff(f.ad, f)

nchar(f)
nchar(f.ad)

nchar(f) == nchar(f.ad[-1])


# get all layer table records
x <- dbGetQuery(db, "SELECT * from nasis_pedon;", stringsAsFactors=FALSE)
x.ad <- dbGetQuery(db.ad, "SELECT * from pedon;", stringsAsFactors=FALSE)

# number of records
nrow(x)
nrow(x.ad)

ncol(x)
ncol(x.ad)

# field types
table(sapply(x, class))
table(sapply(x.ad[, -1], class))

# some are different
idx <- which(sapply(x, class) != sapply(x.ad[, -1], class))

str(x[, idx])
str(x.ad[, idx])





dbDisconnect(db)
dbDisconnect(db.ad)
