library(DBI)
library(RSQLite)
library(soilDB)
library(data.tree)
library(stringr)

## TODO: why is there leading white space in method.requested_anal_name ?


## 

# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')

qq <- sprintf("SELECT DISTINCT procedure_key, proced_abbrev, requested_anal_name, proced_name, proced_code, proced_desc FROM method ;", is)
x <- dbGetQuery(db, qq) 

# clean whitespace
x$requested_anal_name <- str_trim(x$requested_anal_name, side = 'left')

# combine code + description
x$code_desc <- sprintf("%s (%s)", x$proced_code, x$proced_desc)

# extract method group if available (Bulk Density, ....) <- before the comma
x$method_group <- str_split_fixed(x$requested_anal_name, ",", 2)[, 1]

# build DT path: [root] -> [method group] -> [analysis name] -> [procedure name] -> [procedure code + (description)]
x$path <- sprintf("%s|%s|%s|%s|%s", 'NCSS Lab Methods', x$method_group, x$requested_anal_name, x$proced_name, x$code_desc)

# init DT from path, attaching additional columns to leaves
res <- as.Node(x, pathName = 'path', pathDelimiter = '|', 'procedure_key', 'proced_abbrev')


# save to text files for review
options(width = 250)
sink(file = 'all-methods.txt')
print(res, pruneMethod = NULL)
sink()
