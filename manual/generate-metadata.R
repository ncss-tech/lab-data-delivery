library(DBI)
library(RSQLite)
library(soilDB)
library(data.tree)

## programaticlly generate metadata by iterating over each 'method' column in relevant tables

## might be simpler from a data.frame generated via SQL joins (denormalized form)

## units of measure are in analyte.uom_abbrev 

## why are some column names abbreviated?
# not SQLite limitation


# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')

# list tables
dbListTables(db)

dbListFields(db, 'physical')
dbListFields(db, 'analyte')
dbListFields(db, 'method')
dbListFields(db, 'procedure')

dbGetQuery(db, "SELECT particle_size_method from physical limit 10 ;")

dbGetQuery(db, "SELECT * from method where proced_code = '3A1a1a' ;")

## !!!
## this isn't right
dbGetQuery(db, "SELECT * from analyte WHERE analyte_key = '53' ;")

dbGetQuery(db, "SELECT * from preparation limit 10;")


# main interface
MD <- function(tbl) {
  nm <- dbListFields(db, tbl)
  nm <- nm[grep('method', nm)]
  
  md <- lapply(nm, getMetaData, tbl=tbl)
  names(md) <- nm
  
  return(md)
}

# iteration over a single table
getMetaData <- function(this.method, tbl) {
  
  qq <- sprintf("SELECT DISTINCT %s FROM %s ;", this.method, tbl)
  x <- dbGetQuery(db, qq) 
  
  is <- format_SQL_in_statement(x[[this.method]])
  qq <- sprintf("SELECT DISTINCT procedure_key FROM method WHERE proced_code IN %s ;", is)
  x <- dbGetQuery(db, qq) 
  
  is <- format_SQL_in_statement(x$procedure_key)
  qq <- sprintf("SELECT * FROM analyte WHERE procedure_key IN %s ;", is)
  x <- dbGetQuery(db, qq)
  
  ## TODO: almost right
  desc <- lapply(x$proced_desc, as.list)
  names(desc) <- x$proced_name
  
  res <- list('methods' = desc)
  return(res)
}

md.physical <- MD('physical')
md.chemical <- MD('chemical')

x <- FromListSimple(
  list(
    physical = md.physical,
    chemical = md.chemical
  ))

print(x, pruneMethod = NULL)


