library(readr)
library(DBI)
library(RSQLite)
library(Hmisc)

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

writeTable(file.path(base.path, 'calculations.txt.gz'), table.name = 'calculations', d = '|', dd=TRUE)

writeTable(file.path(base.path, 'chemical.txt.gz'), table.name = 'chemical', d = '|', dd=TRUE)
writeTable(file.path(base.path, 'physical_properties.txt.gz'), table.name = 'physical', d = '|', dd=TRUE)
writeTable(file.path(base.path, 'layer.txt.gz'), table.name = 'layer', d = '|', dd=TRUE)

writeTable(file.path(base.path, 'combine_nasis_ncss.txt.gz'), table.name = 'nasis_ncss', d = '|', dd=TRUE)
writeTable(file.path(base.path, 'pedon.txt.gz'), table.name = 'nasis_pedon', d = '|', dd=TRUE)
writeTable(file.path(base.path, 'site.txt.gz'), table.name = 'nasis_site', d = '|', dd=TRUE)

writeTable(file.path(base.path, 'major_and_trace_elements_and_oxides.txt.gz'), table.name = 'geochemical', d = '|', dd=TRUE)
writeTable(file.path(base.path, 'mineralogy_glass_count.txt.gz'), table.name = 'glass', d = '|', dd=TRUE)
writeTable(file.path(base.path, 'xray_thermal.txt.gz'), table.name = 'xray_thermal', d = '|', dd=TRUE)

writeTable(file.path(base.path, 'rosetta.txt.gz'), table.name = 'rosetta', d = '|', dd=TRUE)

writeTable(file.path(base.path, 'webmap.csv.gz'), table.name = 'webmap', d = ',', dd=TRUE)


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
dbListFields(db, 'procedure')


## index tables
# this makes several indexes / table
# [1] "analyte"      "calculations" "chemical"     "geochemical"  "glass"        "layer"        "method"       "nasis_ncss"  
# [9] "nasis_pedon"  "nasis_site"   "physical"     "preparation"  "procedure"    "rosetta"      "webmap"       "xray_thermal"

indexTable('analyte', c('procedure_key'))

indexTable('calculations', c('labsampnum', 'result_source_key', 'prep_code'))

indexTable('chemical', c('labsampnum', 'result_source_key', 'prep_code'))

indexTable('geochemical', c('labsampnum', 'result_source_key', 'prep_code'))

indexTable('glass', c('labsampnum', 'result_source_key', 'prep_code'))

indexTable('layer', c('layer_key', 'labsampnum', 'pedon_key', 'layer_type'))

indexTable('method', c('procedure_key', 'proced_code'))

indexTable('nasis_ncss', c('pedon_key', 'pedlabsampnum', 'pedoniid'))

indexTable('nasis_pedon', c('pedon_key', 'pedlabsampnum', 'site_key'))

indexTable('nasis_site', c('site_key'))

indexTable('physical', c('labsampnum', 'result_source_key', 'prep_code'))

indexTable('preparation', c('prep_key', 'prep_code'))

indexTable('procedure', c('procedure_key'))

indexTable('rosetta', c('result_source_key', 'layer_key'))

indexTable('webmap', c('pedon_key'))

indexTable('xray_thermal', c('labsampnum', 'result_source_key', 'prep_code'))



## cleanup
dbExecute(db, 'VACUUM;')



## TODO: type conversion for numeric columns
## TODO: does SQLite differentiate between integers and REAL?


## TODO document linkages via igraph



# get data
dbGetQuery(db, "SELECT * from nasis_site WHERE user_site_id = 'S08NV003003' ;")

dbGetQuery(db, "SELECT layer_key, labsampnum, pedon_key, hzn_top, hzn_bot, hzn_desgn from layer WHERE pedon_key = 1 ;")

dbGetQuery(db, "SELECT result_source_key, prep_code, labsampnum, clay_total, particle_size_method from physical WHERE result_source_key = 1 ;")

dbGetQuery(db, "SELECT * from rosetta LIMIT 10;")

dbGetQuery(db, "SELECT layer_key, labsampnum, pedon_key, hzn_top, hzn_bot, hzn_desgn from layer WHERE pedon_key = 34942 ;")
dbGetQuery(db, "SELECT * from rosetta WHERE layer_key = 211388;")

# check on CBD-Mn
zz <- dbGetQuery(db, "SELECT manganese_dithionite_citrate FROM chemical;")


# close file
dbDisconnect(db)



## compress
R.utils::gzip(db.file, remove=FALSE, overwrite=TRUE)





