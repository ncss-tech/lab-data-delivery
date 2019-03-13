library(readr)
library(DBI)
library(RSQLite)

# helper functions for making / indexing tables
source('../snapshot-functions.R')

# base path
base.path <- 'E:/NASIS-KSSL-LDM/LDM' 

# output SQLite DB
db.file <- file.path(base.path, 'LDM-compact.sqlite')

# init DB
# best to remove old version first
unlink(db.file)
db <- dbConnect(RSQLite::SQLite(), db.file)

layer.p <- writeTable(file.path(base.path, 'EXPORT_layer_20190312.txt.gz'), table.name = 'layer')

calculations.p <- writeTable(file.path(base.path, 'EXPORT_Calculations_Including_Estimates_And_Default_Values_20190306.txt.gz'), table.name = 'calculations')

chemical.p <- writeTable(file.path(base.path, 'EXPORT_Chemical_Properties_20190306.txt.gz'), table.name = 'chemical')

ncss_site.p <- writeTable(file.path(base.path, 'EXPORT_combine_nasis_ncss_20190306.txt.gz'), table.name = 'ncss_site')

geochemical.p <- writeTable(file.path(base.path, 'EXPORT_Major_And_Trace_Elements_And_Oxides_20190306.txt.gz'), table.name = 'geochemical')

glass.p <- writeTable(file.path(base.path, 'EXPORT_Mineralogy_Glass_Count_20190306.txt.gz'), table.name = 'glass')

physical.p <- writeTable(file.path(base.path, 'EXPORT_Physical_Properties_20190306.txt.gz'), table.name = 'physical')

xray_thermal.p <- writeTable(file.path(base.path, 'EXPORT_XRay_And_Thermal_20190306.txt.gz'), table.name = 'xray_thermal')

rosetta.p <- writeTable(file.path(base.path, 'EXPORT_ROSETTA.txt.gz'), table.name = 'rosetta')


# check
dbListTables(db)
dbListFields(db, 'rosetta')


# index standard tables, excluding ncss_site and layer
# this makes several indexes / table
indexTable('calculations', c('labsampnum', 'result_source_key', 'prep_code'))
indexTable('chemical', c('labsampnum', 'result_source_key', 'prep_code'))
indexTable('geochemical', c('labsampnum', 'result_source_key', 'prep_code'))
indexTable('glass', c('labsampnum', 'result_source_key', 'prep_code'))
indexTable('physical', c('labsampnum', 'result_source_key', 'prep_code'))
indexTable('xray_thermal', c('labsampnum', 'result_source_key', 'prep_code'))

# site table is indexed differently
indexTable('ncss_site', c('pedon_key', 'upedonid', 'pedlabsampnum'))

# layer table is indexed differently
indexTable('layer', c('layer_key', 'natural_key', 'pedon_key', 'layer_type'))

# layer table is indexed differently
indexTable('rosetta', c('rosetta_key', 'layer_key'))

# cleanup
dbExecute(db, 'VACUUM;')



## TODO document linkages



# get data
dbGetQuery(db, "SELECT pedon_key, pedlabsampnum, pedoniid, upedonid, corr_name from ncss_site WHERE upedonid = 'S1999NY061001' ;")

dbGetQuery(db, "SELECT layer_key, natural_key, pedon_key, hzn_top, hzn_bot, hzn_desgn from layer WHERE pedon_key = 1 ;")

dbGetQuery(db, "SELECT result_source_key, prep_code, labsampnum, clay_total, particle_size_method from physical WHERE result_source_key = 1 ;")

dbGetQuery(db, "SELECT * from rosetta LIMIT 10;")


dbGetQuery(db, "SELECT pedon_key, pedlabsampnum, pedoniid, upedonid, corr_name from ncss_site WHERE upedonid = 'S08NV003003' ;")
dbGetQuery(db, "SELECT layer_key, natural_key, pedon_key, hzn_top, hzn_bot, hzn_desgn from layer WHERE pedon_key = 34942 ;")
dbGetQuery(db, "SELECT * from rosetta WHERE layer_key = 211388;")




# close file
dbDisconnect(db)




