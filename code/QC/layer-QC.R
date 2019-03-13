library(DBI)
library(RSQLite)

# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')

# quick check: tables / fields
dbListTables(db)
dbListFields(db, 'layer')

# get all layer table records
x <- dbGetQuery(db, "SELECT layer_key, natural_key, pedon_key, hzn_top, hzn_bot, hzn_desgn from layer;", stringsAsFactors=FALSE)

# field types and NA eval
str(x)

# hz top: 2395 NA
table(is.na(x$hzn_top))
# 2396 after conversion to numeric
table(is.na(as.numeric(x$hzn_top)))

# parse error in record 354939 -> hzn designation placed into hzn_top
idx <- which(is.na(as.numeric(x$hzn_top)) & ! is.na(x$hzn_top))
x[idx, ]

# hz bottom
table(is.na(x$hzn_bot))

# top/bottom
table(is.na(x$hzn_top) & is.na(x$hzn_bot))


# close file
dbDisconnect(db)

