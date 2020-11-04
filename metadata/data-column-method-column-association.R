library(DBI)
library(RSQLite)
library(data.tree)

draftAssociation <- function(nm) {
  
  # REGEX for finding "method" columns until abbreviations are fixed
  method.regex <- '(_m[^mm]?[e]?[t]?[h]?[o]?[d]?)$'
  
  # index to method columns
  idx <- grep(method.regex, nm)
  
  # results go here
  l <- list()
  
  # iteration over method column index
  # iteration works with range (method column [i] <-----> method column [i+1]])
  for(i in seq_along(idx)) {
    
    # last set of methods requires special handling
    last <- i == length(idx)
    
    if(!last) {
      # index sequence defining data columns, inclusive of method columns before / after
      s <- idx[i]:idx[i+1]
      # remove method coulumn index before / after
      s <- s[-1]
      s <- s[-length(s)]
      
    } else {
      # index eveything after the last method column
      # there may be spurious association between last method column and end of table
      s <- idx[i]:length(nm)
      
      # remove method coulumn index before
      s <- s[-1]
    }
    
    
    # create assocation if possible
    if(length(s) > 0) {
      
      # graph structure linking current method column -> data columns
      d <- data.frame(
        method = nm[idx[i]],
        columns = nm[s],
        stringsAsFactors = FALSE
      )
      
      l[[i]] <- d
    }
    
  }
  
  res <- do.call('rbind', l)
  
  # some columns are missing: find them
  # filtering out method columns
  m <- setdiff(nm[-idx], res$columns)
  
  return(list(
    association = res,
    missing = m
  ))
}


# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')



## physical table
physical.nm <- dbListFields(db, 'physical')
physical.nm <- physical.nm[-c(1:3)]


## chemical table
chemical.nm <- dbListFields(db, 'chemical')
chemical.nm <- chemical.nm[-c(1:3)]


# build draft data column -> method column association
physical.assoc <- draftAssociation(physical.nm)
chemical.assoc <- draftAssociation(chemical.nm)

# there are a lot of problems here and need to be manually sorted
write.csv(physical.assoc$association, file = 'physical-column-association-to-edit.csv', row.names = FALSE)
write.csv(chemical.assoc$association, file = 'chemical-column-association-to-edit.csv', row.names = FALSE)

# note missing
physical.assoc$missing
chemical.assoc$missing

## manually correct in:
# physical-column-association.csv
# chemical-column-association.csv


## after corrections:

physical.assoc <- read.csv('physical-column-association.csv', stringsAsFactors = FALSE)
chemical.assoc <- read.csv('chemical-column-association.csv', stringsAsFactors = FALSE)

# init DT
physical.assoc$path <- with(physical.assoc, sprintf("physical|%s|%s", method, columns))
chemical.assoc$path <- with(chemical.assoc, sprintf("chemical|%s|%s", method, columns))

physical <- as.Node(physical.assoc, pathName = 'path', pathDelimiter = '|')
chemical <- as.Node(chemical.assoc, pathName = 'path', pathDelimiter = '|')

## TODO: splice / merge into method metadata DT objects

