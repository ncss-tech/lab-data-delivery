library(DBI)
library(RSQLite)
library(soilDB)
library(data.tree)
library(stringr)
library(soilDB)


## TODO: 
# clean leading white space in method.requested_anal_name in source data
# where does the source data come from, static | dynamic?
# make this into an interactive HTML widget with links to the SSIR 42PDF
# integrate with a more fully parsed (Andrew?) version of SSIR 42

## Notes:
# you can get this same information from SDA by querying the "lab_methods" table
# 


# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')

qq <- sprintf("SELECT DISTINCT procedure_key, proced_abbrev, requested_anal_name, proced_name, proced_code, proced_desc FROM method ;", is)
x <- dbGetQuery(db, qq) 

# done with connection
dbDisconnect(db)


# # alternatively do it with SDA
# x <- SDA_query("SELECT DISTINCT procedure_key, proced_abbrev, requested_anal_name, proced_name, proced_code, proced_desc FROM lab_method_code ;") 


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


# there is redundancy in this tree
# related to a single method within a method group
res$Sulfur

# explicit copy for testing
res2 <- Clone(res)

# z: 2nd-level node
simplifyMethodTree <- function(z) {
  
  # get child nodes and details
  z.children <- z$children
  n <- length(z.children)
  nm <- names(z.children)
  
  if(n < 2) {
    # remove all children from parent node
    orphans <- z$RemoveChild(nm)
    
    # add the child nodes to the main DT
    res2$AddChildNode(orphans)
    # remove this node 
    res2$RemoveChild(z$name)
  }
  
  # otherwise do nothing
}


# operate on 2nd level (method groups) only
res2$Do(simplifyMethodTree, filterFun = function(i) i$level == 2)

# did that work as expected?
res$Sulfur
res2$`Sulfur, Total`

res$`Bulk Density`
res2$`Bulk Density`

res$PSDA
res2$PSDA

# I think so, still need to check


# save to text files for review
options(width = 250)
sink(file = 'all-methods.txt')
print(res2, pruneMethod = NULL)
sink()
