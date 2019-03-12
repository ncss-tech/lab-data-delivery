library(readr)
library(DBI)
library(RSQLite)


# note, finds DB handle from global environment
writeTable <- function(f, table.name) {
  
  # seems to work well
  x <- read_delim(f, delim = '|')
  
  # save problems for later review
  p <- as.data.frame(problems(x))
  
  # convert to DF
  x <- as.data.frame(x)
  
  # write table
  dbWriteTable(db, name = table.name, value = x, row.names=FALSE, overwrite=TRUE)
  
  # write out schema for eval
  schema.file <- sprintf("%s-schema.sql", table.name)
  cat(sqliteBuildTableDefinition(db, table.name, value=x[0,], row.names=FALSE), file = schema.file, sep = '\n')
  
  return(p)
}



# note, finds DB handle from global environment
indexTable <- function(tbl, field = c('labsampnum', 'result_source_key', 'prep_code')) {
  index.query <- sprintf("CREATE INDEX IF NOT EXISTS %s_%s_idx ON %s (%s);", tbl, field, tbl, field)
  sapply(index.query, dbExecute, conn=db)
}


# output file
db.file <- 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite'

# init DB
# best to remove old version first
unlink(db.file)
db <- dbConnect(RSQLite::SQLite(), db.file)

calculations.p <- writeTable('EXPORT_Calculations_Including_Estimates_And_Default_Values_20190306.txt.gz', table.name = 'calculations')

chemical.p <- writeTable('EXPORT_Chemical_Properties_20190306.txt.gz', table.name = 'chemical')

ncss_site.p <- writeTable('EXPORT_combine_nasis_ncss_20190306.txt.gz', table.name = 'ncss_site')

geochemical.p <- writeTable('EXPORT_Major_And_Trace_Elements_And_Oxides_20190306.txt.gz', table.name = 'geochemical')

glass.p <- writeTable('EXPORT_Mineralogy_Glass_Count_20190306.txt.gz', table.name = 'glass')

physical.p <- writeTable('EXPORT_Physical_Properties_20190306.txt.gz', table.name = 'physical')

xray_thermal.p <- writeTable('EXPORT_XRay_And_Thermal_20190306.txt.gz', table.name = 'xray_thermal')

# check
dbListTables(db)

# index all but pedon/site table
# this makes 2 indexes / table
indexTable('calculations')
indexTable('chemical')
indexTable('geochemical')
indexTable('glass')
indexTable('physical')
indexTable('xray_thermal')

# site table is indexed differently
indexTable('ncss_site', 'pedon_key')
indexTable('ncss_site', 'upedonid')
indexTable('ncss_site', 'pedlabsampnum')


## recall linkages: 
# NCSS site/pedon -> lab: pedon_key -> result_source_key
# NASIS -> lab: pedlabsampnum + labsampnum 


# get data
dbGetQuery(db, "SELECT pedon_key, pedlabsampnum, pedoniid, upedonid, corr_name from ncss_site WHERE upedonid = 'S1999NY061001' ;")
dbGetQuery(db, "SELECT result_source_key, prep_code, labsampnum, clay_total, particle_size_method from physical WHERE result_source_key = 1 ;")
dbGetQuery(db, "SELECT result_source_key, prep_code, labsampnum, ca_nh4_ph_7, ca_nh4_ph_7_method from chemical WHERE result_source_key = 1 ;")

# cleanup
dbExecute(db, 'VACUUM;')

# close file
dbDisconnect(db)




