library(readr)
library(DBI)
library(RSQLite)


## upload LDM-compact.sqlite.gz to
# https://new.cloudvault.usda.gov/index.php/s/eSoPYbWDBQNX2HP


# helper functions for making / indexing tables
source('../code/snapshot-preparation/snapshot-functions.R')

# base path for first-cut of export, based on Jason's new SQL
base.path <- 'E:/working-from-home-to-file/MIR' 

# output SQLite DB file name
db.file <- file.path(base.path, 'MIR-compact.sqlite')

# init DB
# best to remove old version first
unlink(db.file)
db <- dbConnect(RSQLite::SQLite(), db.file)


LIMS.tables <- list.files(file.path(base.path, 'LIMS_snapshot'))

for(i in LIMS.tables) {
  
  # create table name
  tn <- gsub(pattern = '.txt.gz', replacement = '', fixed = TRUE, x = i)
  
  # write data to new table
  writeTable(file.path(base.path, 'LIMS_snapshot', i), table.name = tn, d = ',', dd = FALSE, schema = TRUE, errors = TRUE)
}








# check
dbListTables(db)
dbListFields(db, 'analyte')
dbListFields(db, 'mir_scan_mas_data')

dbGetQuery(db, "SELECT * FROM mir_scan_det_data LIMIT 10;")


## TODO: finish with indexing


# 
# 
# ## index tables
# # this makes several indexes / table
# # [1] "analyte"      "calculations" "chemical"     "geochemical"  "glass"        "layer"        "method"       "nasis_ncss"  
# # [9] "nasis_pedon"  "nasis_site"   "physical"     "preparation"  "procedure"    "rosetta"      "webmap"       "xray_thermal"
# 
# 
# ## consider building-in foreign keys
# ## must be added at table creation time
# # https://stackoverflow.com/questions/1884818/how-do-i-add-a-foreign-key-to-an-existing-sqlite-table
# # https://stackoverflow.com/questions/50852820/correct-usage-of-the-foreign-key-function
# 
# indexTable('analyte', c('analyte_key'))
# 
# indexTable('calculations', c('labsampnum', 'result_source_key', 'prep_code'))
# 
# indexTable('chemical', c('labsampnum', 'result_source_key', 'prep_code'))
# 
# indexTable('geochemical', c('labsampnum', 'result_source_key', 'prep_code'))
# 
# indexTable('glass', c('labsampnum', 'result_source_key', 'prep_code'))
# 
# indexTable('layer', c('layer_key', 'labsampnum', 'pedon_key', 'layer_type'))
# 
# indexTable('method', c('procedure_key', 'proced_code'))
# 
# indexTable('nasis_ncss', c('pedon_key', 'pedlabsampnum', 'pedoniid'))
# 
# indexTable('nasis_pedon', c('pedon_key', 'pedlabsampnum', 'site_key'))
# 
# indexTable('nasis_site', c('site_key'))
# 
# indexTable('physical', c('labsampnum', 'result_source_key', 'prep_code'))
# 
# indexTable('preparation', c('prep_key', 'prep_code'))
# 
# indexTable('procedure', c('procedure_key'))
# 
# indexTable('rosetta', c('result_source_key', 'layer_key'))
# 
# indexTable('webmap', c('pedon_key'))
# 
# indexTable('xray_thermal', c('labsampnum', 'result_source_key', 'prep_code'))
# 
# 
# 
# ## cleanup
# dbExecute(db, 'VACUUM;')
# 
# 
# ## TODO: data availability table
# # see geochemical-database.R
# 
# 
# # get data
# dbGetQuery(db, "SELECT * from nasis_site WHERE user_site_id = 'S08NV003003' ;")
# 
# dbGetQuery(db, "SELECT layer_key, labsampnum, pedon_key, hzn_top, hzn_bot, hzn_desgn from layer WHERE pedon_key = 1 ;")
# 
# dbGetQuery(db, "SELECT result_source_key, prep_code, labsampnum, clay_total, particle_size_method from physical WHERE result_source_key = 1 ;")
# 
# dbGetQuery(db, "SELECT * from rosetta LIMIT 10;")
# 
# dbGetQuery(db, "SELECT layer_key, labsampnum, pedon_key, hzn_top, hzn_bot, hzn_desgn from layer WHERE pedon_key = 34942 ;")
# dbGetQuery(db, "SELECT * from rosetta WHERE layer_key = 211388;")
# 
# # check on CBD-Mn
# zz <- dbGetQuery(db, "SELECT manganese_dithionite_citrate FROM chemical;")


# close file
dbDisconnect(db)



## compress
R.utils::gzip(db.file, remove=FALSE, overwrite=TRUE)





