
library(DBI)
library(RSQLite)
library(soilDB)
library(data.tree)


## why are some column names abbreviated?
# not SQLite limitation
# --> abbreviation was intentional, makes finding "method" columns a little more challenging

# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')


# identify method columns and those that are truncated
# print old -> new mapping, to be completed by hand

methodColumnFixUp <- function(tbl) {
  
  cat(sprintf("------- %s -------\n", tbl))
  
  nm <- dbListFields(db, tbl)
  method.regex <- '(_m[^mm]?[e]?[t]?[h]?[o]?[d]?)$'
  
  x <- nm[grep(method.regex, nm)]
  x.sub <- x[grep('_method', x, invert = TRUE)]
  
  d <- data.frame(old = x.sub, new = x.sub, stringsAsFactors = FALSE)
  
  write.csv(d, quote = FALSE, row.names = FALSE)
  
  cat(sprintf("-----------------\n", tbl))
}

sink('method-column-truncation-fixes.txt')

for(i in dbListTables(db)) {
  methodColumnFixUp(i)
}

sink()


## try SDA: same results
s <- SDA_query("SELECT TOP 10 * FROM lab_physical_properties ;")
nm <- names(s)

method.regex <- '(_m[^mm]?[e]?[t]?[h]?[o]?[d]?)$'
x <- nm[grep(method.regex, nm)]
x.sub <- x[grep('_method', x, invert = TRUE)]

d <- data.frame(old = x.sub, new = x.sub, stringsAsFactors = FALSE)

