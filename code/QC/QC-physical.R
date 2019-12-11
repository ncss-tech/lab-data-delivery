library(DBI)
library(RSQLite)

source('../snapshot-preparation/snapshot-functions.R')

# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')

# quick check: tables / fields
dbListTables(db)
dbListFields(db, 'chemical')

# get all layer table records
x <- dbGetQuery(db, "SELECT * from chemical;", stringsAsFactors=FALSE)

# field types and NA eval
str(x)

# close file
dbDisconnect(db)

# potential problems with values 0-1 truncated at 0.
vars <- c('caco3_lt_2_mm', 'aluminum_na_pyro_phosphate', 'iron_sodium_pyro_phosphate', 'carbon_sodium_pyro_phospate', 'manganese_ammonium_oxalate', 'fe_ammoniumoxalate_extractable', 'ammoniumoxalate_opticaldensity', 'manganese_dithionite_citrate', 'total_nitrogen_ncs', 'manganese_kcl_extractable', 'aluminum_kcl_extractable', 'k_nh4_ph_7', 'na_nh4_ph_7', 'mg_nh4_ph_7', 'ca_nh4_ph_7')

#
Hmisc::describe(x[, vars])


# check proportion == 0
sapply(x[, vars], propZero)


# non-method code cols
nm <- names(x)
nm <- nm[grep('method', nm, invert = TRUE)]

# eval
prop.0 <- sapply(x[, nm], propZero)

# check just those > 35% non-null == 0
dotchart(sort(prop.0[prop.0 > 0.35]), cex=0.75, pt.cex=1, pch=16, xlab='Percent Non-NULL Records == 0')

# dump for Jason
cat(names(sort(prop.0[prop.0 > 0.35])), sep = '\n')






getData('PSDA_and_Rock_Fragments', '00P00207')

getData('Bulk_Density_and_Moisture', '00P00207')

x[which(x$labsampnum == '00P00207'), grep('cole', names(x), ignore.case = TRUE)]


analytes <- dbGetQuery(db, "SELECT * from NCSS_Analyte;")

idx <- grep('COLE', analytes$analyte_name, ignore.case = TRUE)
analytes[idx, ]

kable(prep.codes, row.names = FALSE)
