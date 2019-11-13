


getData <- function(table_name, labsampnum) {
  q <- sprintf("SELECT * from %s where labsampnum = '%s';", table_name, labsampnum)
  
  res <- try(dbGetQuery(db, q), silent = TRUE)
  
  if(class(res) == 'try-error')
    res <- NULL
  
  return(res)
}


getPedonLabSampNum <- function(labsampnum) {
  
  q <- sprintf("SELECT pedlabsampnum FROM NCSS_Pedon_Taxonomy WHERE pedon_key IN (SELECT pedon_key from NCSS_Layer where labsampnum = '%s');", labsampnum)
  res <- dbGetQuery(db, q)
  
  return(res$pedlabsampnum)
}


# use this to convert a folder full of CSV files into a self-contained SQLite DB
# type: 'NASIS' | 'KSSL'
makeSQLiteFromCSV <- function(type, base.path) {
  # files to check
  files <- list.files(path=base.path, pattern='\\\\*.txt')
  
  # output files
  db.file <- sprintf("%s-data.sqlite", type)
  db.schema <- sprintf("%s-schema.sql", type)
  
  # init DB
  # best to remove old version first
  unlink(db.file)
  unlink(db.schema)
  db <- dbConnect(RSQLite::SQLite(), db.file)
  
  # iterate over files
  for(i in files) {
    this.file <- paste0(base.path, i)
    this.table <- gsub(pattern = '.txt', '', i)
    x <- read_delim(this.file, delim = '|', quote='', na='', comment='', trim_ws = TRUE, guess_max = 1e6)
    
    # # attempt to write schema only: OK
    # dbWriteTable(db, name = this.table, value = x[0, ], row.names=FALSE, overwrite=TRUE)
    
    # note this flushes to disk at each iteration
    # attemp to write all rows: OK
    dbWriteTable(db, name = this.table, value = x, row.names=FALSE, overwrite=TRUE)
    
    # save schema for review:
    ## TODO: switch to sqlCreateTable()
    cat(sqliteBuildTableDefinition(db, this.table, value=x[0,], row.names=FALSE), file = db.schema, append = TRUE, sep = '\n')
    
  }
  
  # dbListTables(db)
  
  dbDisconnect(db)
  
}



# finds DB handle from global environment
# f: full path to pipe-delim text file
# table.name: new table name
# d: delimeter
writeTable <- function(f, table.name, d='|') {
  
  # scaleable reading from txt
  # * typically pipe-delim
  # * ignore '#' as comment, as it occurs in some records
  # * guess data types by reading in 1 million rows
  # * follow-up type conversion will be required...
  x <- suppressWarnings(read_delim(f, delim = d, comment = '', guess_max = 1e6))
  
  # save problems for later review
  p <- as.data.frame(problems(x))
  write.csv(p, file=file.path('parse-errors', paste0(table.name, '.csv')), row.names = FALSE)
  
  # convert to DF
  x <- as.data.frame(x)
  
  # convert field names to lower case
  names(x) <- tolower(names(x))
  
  
  # write table
  dbWriteTable(db, name = table.name, value = x, row.names=FALSE, overwrite=TRUE)
  
  # write out schema for eval, sub-dir of calling code
  schema.file <- file.path('schema', paste0(table.name, '.sql'))
  cat(sqliteBuildTableDefinition(db, table.name, value=x[0,], row.names=FALSE), file = schema.file, sep = '\n')
  
}



# finds DB handle from global environment
# tbl: table name in SQLite DB
# field: field to index
# return code O -> success
indexTable <- function(tbl, field) {
  index.query <- sprintf("CREATE INDEX IF NOT EXISTS %s_%s_idx ON %s (%s);", tbl, field, tbl, field)
  sapply(index.query, dbExecute, conn=db)
}

