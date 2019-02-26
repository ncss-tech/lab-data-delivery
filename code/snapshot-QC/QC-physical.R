library(readr)
library(digest)
library(purrr)
library(DBI)

source('QC-functions.R')

# latest synthesis from Jason
x <- read_csv('E:/NASIS-KSSL-LDM/LDM/EXPORT_Physical_Properties.txt.gz')
x <- as.data.frame(x)

# latest snapshot
db <- dbConnect(RSQLite::SQLite(), "E:/NASIS-KSSL-LDM/KSSL-data.sqlite")


tbls <- dbListTables(db)
names(tbls) <- tbls

dbListFields(db, 'PSDA_and_Rock_Fragments')
dbListFields(db, 'Bulk_Density_and_Moisture')


getData('PSDA_and_Rock_Fragments', '00P00207')

getData('Bulk_Density_and_Moisture', '00P00207')

x[which(x$labsampnum == '00P00207'), grep('cole', names(x), ignore.case = TRUE)]


analytes <- dbGetQuery(db, "SELECT * from NCSS_Analyte;")

idx <- grep('COLE', analytes$analyte_name, ignore.case = TRUE)
analytes[idx, ]

kable(prep.codes, row.names = FALSE)
