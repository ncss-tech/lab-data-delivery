library(readr)
library(DBI)
library(RSQLite)

# helper functions for making / indexing tables
source('snapshot-functions.R')

# base path for first-cut of export, based on Jason's new SQL
base.path <- 'E:/NASIS-KSSL-LDM/LDM' 

# output SQLite DB file name
db.file <- file.path(base.path, 'LDM-compact.sqlite')


# init DB
# best to remove old version first
unlink(db.file)
db <- dbConnect(RSQLite::SQLite(), db.file)

writeTable(file.path(base.path, 'analysis_procedure.txt.gz'), table.name = 'procedure', d = '|')
writeTable(file.path(base.path, 'analyte.txt.gz'), table.name = 'analyte', d = '|')
writeTable(file.path(base.path, 'method_code.txt.gz'), table.name = 'method', d = '|')
writeTable(file.path(base.path, 'preparation.txt.gz'), table.name = 'preparation', d = '|')

writeTable(file.path(base.path, 'calculations.txt.gz'), table.name = 'calculations', d = '|')

writeTable(file.path(base.path, 'chemical_properties.txt.gz'), table.name = 'chemical', d = '|')
writeTable(file.path(base.path, 'physical_properties.txt.gz'), table.name = 'physical', d = '|')
writeTable(file.path(base.path, 'layer.txt.gz'), table.name = 'layer', d = '|')

writeTable(file.path(base.path, 'combine_nasis_ncss.txt.gz'), table.name = 'nasis_ncss', d = '|')
writeTable(file.path(base.path, 'pedon.txt.gz'), table.name = 'nasis_pedon', d = '|')
writeTable(file.path(base.path, 'site.txt.gz'), table.name = 'nasis_site', d = '|')

writeTable(file.path(base.path, 'major_and_trace_elements_and_oxides.txt.gz'), table.name = 'geochemical', d = '|')
writeTable(file.path(base.path, 'mineralogy_glass_count.txt.gz'), table.name = 'glass', d = '|')
writeTable(file.path(base.path, 'xray_thermal.txt.gz'), table.name = 'xray_thermal', d = '|')

writeTable(file.path(base.path, 'rosetta.txt.gz'), table.name = 'rosetta', d = '|')

writeTable(file.path(base.path, 'webmap.csv.gz'), table.name = 'webmap', d = ',')


## 2019-11-13: these are now part of the tables Jason is preparing
# # manually edited CSV, stored in GH repo
# writeTable(file.path('../../metadata/', 'procedures.csv'), table.name = 'procedures', d = ',')
# writeTable(file.path('../../metadata/', 'methods.csv'), table.name = 'methods', d = ',')


# check
dbListTables(db)
dbListFields(db, 'method')
dbListFields(db, 'procedure')
dbListFields(db, 'webmap')
dbListFields(db, 'layer')


## TODO: finish this

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

# metadata
indexTable('procedures', 'procedure_key')
indexTable('methods', c('procedure_key', 'proced_code'))


# cleanup
dbExecute(db, 'VACUUM;')

# ## doesn't work on windows
# # compress for distribution
# z <- paste0(file.path(base.path, db.file), '.zip')
# zip(zipfile = z, files = file.path(base.path, db.file))


## TODO: type conversion for numeric columns

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


# done



