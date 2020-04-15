library(DBI)
library(RSQLite)
library(knitr)

source('../snapshot-preparation/snapshot-functions.R')

# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')

# quick check: tables / fields
dbListTables(db)
dbListFields(db, 'physical')

# get all layer table records
x <- dbGetQuery(db, "SELECT * from physical;", stringsAsFactors=FALSE)

# field types and NA eval
str(x)

## multiple prep code issues
# apparent duplicate labsampnums
table(x$prep_code, useNA = 'always')

z <- x[is.na(x$prep_code), ]

## tabulate prep code frequency per record
tab <- table(x$labsampnum)
tab <- sort(tab, decreasing = TRUE)
table(tab)


z <- x[which(x$labsampnum == '05N02179'), c('labsampnum', 'prep_code', 'clay_total', 'cole_whole_soil', 'cec7_clay_ratio', 'effective_cec_to_clay_ratio')]

kable(z, row.names = FALSE)


## check a couple of records
getData('physical', '00P00207')

analytes <- dbGetQuery(db, "SELECT * from analyte;")

idx <- grep('cole', analytes$proced_name, ignore.case = TRUE)
analytes[idx, ]




# close file
dbDisconnect(db)


# non-method code cols
nm <- names(x)
nm <- nm[grep('method', nm, invert = TRUE)]

# eval
prop.0 <- sapply(x[, nm], propZero)

# check just those > 35% non-null == 0
dotchart(sort(prop.0[prop.0 > 0.35]), cex=0.75, pt.cex=1, pch=16, xlab='Percent Non-NULL Records == 0')

# dump for Jason
cat(names(sort(prop.0[prop.0 > 0.35])), sep = '\n')



## COLE working?
x[which(x$labsampnum == '00P00207'), grep('cole', names(x), ignore.case = TRUE)]
x[which(x$labsampnum == '05N02179'), grep('cole', names(x), ignore.case = TRUE)]

# seems to be working.. but there are 3 rows / hz with different prep codes
x[which(x$labsampnum == '05N02179'), c('labsampnum', 'prep_code', 'cole_whole_soil')]

hist(x$cole_whole_soil[x$cole_whole_soil > 0 & x$cole_whole_soil < 1], breaks = 50)



