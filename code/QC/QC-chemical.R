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
dotchart(sort(prop.0[prop.0 > 0.35]), cex=0.75, pt.cex=1, pch=16, xlab='Percent Non-NULL Records == 0', main='Chemical Table\n>35% Threshold')

# dump for Jason
cat(names(sort(prop.0[prop.0 > 0.35], decreasing = TRUE)), sep = '\n')



## compare values with last Access snapshot
db.old <- dbConnect(RSQLite::SQLite(), "E:/NASIS-KSSL-LDM/KSSL-data.sqlite")

x.old <- dbGetQuery(db.old, "SELECT Mn_dith FROM Carbon_and_Extractions;")
Hmisc::describe(x.old$mn_dith)
table(x.old$mn_dith[x.old$mn_dith < 2])

dotchart(sort(table(x.old$mn_dith[x.old$mn_dith > 0 & x.old$mn_dith < 2])), main='Chemical Table\n>35% Threshold')


x.old <- dbGetQuery(db.old, "SELECT COLEws FROM Bulk_Density_and_Moisture;")
Hmisc::describe(x.old$COLEws)





