

library(DBI)
library(RSQLite)
library(soilDB)
library(data.tree)
library(stringr)

## TODO: why is there leading white space in method.requested_anal_name ?


## programaticlly generate metadata by iterating over each 'method' column in relevant tables

## might be simpler from a data.frame generated via SQL joins (denormalized form)

## units of measure are in analyte.uom_abbrev 

## why are some column names abbreviated?
# not SQLite limitation
# --> abbreviation was intentional, makes finding "method" columns a little more challenging

# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')

# # list tables
dbListTables(db)

# 
# dbListFields(db, 'physical')
dbListFields(db, 'analyte')
# dbListFields(db, 'method')
# dbListFields(db, 'procedure')
# 
# dbGetQuery(db, "SELECT particle_size_method from physical limit 10 ;")
# 
dbGetQuery(db, "SELECT * from method where proced_code = '3A1a1a' ;")
dbGetQuery(db, "SELECT * from procedure where procedure_key = 53 ;")

## TODO: there is currently no way to use the analyte table
## we need to figure out a way to link to this
dbGetQuery(db, "SELECT * from analyte LIMIT 10 ;")
# 
dbGetQuery(db, "SELECT * from preparation limit 10;")
dbGetQuery(db, "SELECT * from procedure limit 10;")




# main interface
MD <- function(tbl) {
  # REGEX for finding "method" columns
  method.regex <- '(_m[^mm]?[e]?[t]?[h]?[o]?[d]?)$'
  
  # find method columns
  nm <- dbListFields(db, tbl)
  nm <- nm[grep(method.regex, nm)]
  
  # create DT object for each method column
  md <- lapply(nm, getMetaData, tbl = tbl)
  names(md) <- nm
  
  # remove NULL (no matching method codes)
  idx <- which(! sapply(md, is.null))
  md <- md[idx]
  
  # init new parent Node
  n <- Node$new(tbl)
  
  # add each DT object by method column
  for(i in 1:length(md)) {
    n$AddChildNode(md[[i]])
  }
  
  return(n)
}

# create DT representation of a single table / method column
getMetaData <- function(this.method, tbl) {
  
  # unique method codes for a given "method column" 
  qq <- sprintf("SELECT DISTINCT %s FROM %s WHERE %s IS NOT NULL;", this.method, tbl, this.method)
  x <- dbGetQuery(db, qq) 
  
  ## TODO: why?
  # there could be no associated methods
  if(nrow(x) < 1)
    return(NULL)
  
  # unique procedure keys for this set of method codes
  is <- format_SQL_in_statement(x[[this.method]])
  qq <- sprintf("SELECT DISTINCT procedure_key, proced_abbrev, requested_anal_name, proced_name, proced_code, proced_desc FROM method WHERE proced_code IN %s ;", is)
  x <- dbGetQuery(db, qq) 
  
  # clean whitespace
  x$requested_anal_name <- str_trim(x$requested_anal_name, side = 'left')
  
  ## TODO: why?
  # there could be no associated methods
  if(nrow(x) < 1)
    return(NULL)
  
  
  # ## TODO: this won't work because analyte is missing the procedure_key column
  # ## ---> do we need this link?
  # # unique analyte details
  # is <- format_SQL_in_statement(x$procedure_key)
  # qq <- sprintf("SELECT * FROM analyte WHERE procedure_key IN %s ;", is)
  # x <- dbGetQuery(db, qq)
  
  # combine code + description
  x$code_desc <- sprintf("%s (%s)", x$proced_code, x$proced_desc)

  ## TODO: link back to column names to which the method column refers
  # build DT path: [current method] -> [analysis name] -> [procedure name] -> [procedure code + (description)]
  x$path <- sprintf("%s|%s|%s|%s", this.method, x$requested_anal_name, x$proced_name, x$code_desc)
  
  # init DT from path, attaching additional columns to leaves
  res <- as.Node(x, pathName = 'path', pathDelimiter = '|', 'procedure_key', 'proced_abbrev')
  
  
  return(res)
}


# collect metadata as DT objects, by table
md.physical <- MD('physical')
md.chemical <- MD('chemical')


# check: ok
print(md.physical$particle_size_method)

# include the description / citation
print(md.physical$particle_size_method, 'proced_abbrev')



# save to text files for review
options(width = 250)
sink(file = 'physical-metadata.txt')
print(md.physical, pruneMethod = NULL)
sink()

sink(file = 'chemical-metadata.txt')
print(md.chemical, pruneMethod = NULL)
sink()

