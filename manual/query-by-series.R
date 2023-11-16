library(soilDB)
library(DBI)
library(RSQLite)


# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/NCSSLabDataMartSQLite.sqlite3')

# list tables
dbListTables(db)



queryBySeries <- function(i) {
  
  i <- tolower(i)
  
  .sql <- sprintf("SELECT pedon_key, pedlabsampnum, samp_name, corr_name,
CASE WHEN corr_name IS NOT NULL THEN LOWER(corr_name) ELSE LOWER(samp_name) END AS taxonname
FROM lab_combine_nasis_ncss 
WHERE CASE WHEN corr_name IS NOT NULL THEN LOWER(corr_name) ELSE LOWER(samp_name) END = '%s' ; ", i)
  
  .res <- dbGetQuery(db, .sql)
  return(.res)
}

queryBySeries('miami')

x <- c('amador', 'gillender', 'pentz', 'pierre')

s <- lapply(x, queryBySeries)

dbDisconnect(db)



