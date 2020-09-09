library(DBI)
library(RSQLite)
library(knitr)

## geochem DB background
# https://www.nrcs.usda.gov/wps/portal/nrcs/detail/soils/research/?cid=nrcs142p2_053632


# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')


# list tables
dbListTables(db)

dbListFields(db, 'webmap')

sql <- "
SELECT pedon_key, lyr.labsampnum,
CASE WHEN geo.labsampnum IS NULL THEN 0 ELSE 1 END AS geochemical_present,
CASE WHEN gls.labsampnum IS NULL THEN 0 ELSE 1 END AS glass_present,
CASE WHEN xry.labsampnum IS NULL THEN 0 ELSE 1 END AS xray_thermal_present
FROM layer AS lyr
LEFT JOIN geochemical AS geo ON lyr.labsampnum = geo.labsampnum
LEFT JOIN glass AS gls ON lyr.labsampnum = gls.labsampnum
LEFT JOIN xray_thermal AS xry ON lyr.labsampnum = xry.labsampnum
;
"

data.available.by.hz <- dbGetQuery(db, sql)


sql <- "
SELECT * from webmap
;
"

wm <- dbGetQuery(db, sql)


sql <- "
SELECT * from physical
;
"

phys <- dbGetQuery(db, sql)





kable(head(data.available.by.hz, 7))


nm <- names(phys)

# non-method columns
method.idx <- grep('_me', x = nm, fixed = TRUE, invert = TRUE)
id.idx <- match(c('labsampnum', 'result_source_key', 'prep_code'), nm)

keep.idx <- setdiff(method.idx, id.idx)
nm[keep.idx]


dataFieldAvail <- function(i) {
  
}



dataAvail <- function(i) {
  # identify tally columns
  nm <- names(i)
  idx <- grep(pattern = 'present', x = nm)
  
  # iterate over tally columns 
  prop <- sapply(nm[idx], function(j) {
    # there should be no NA in here
   sum(i[[j]]) / nrow(i)
  })
  
  # compile into a DF
  # convert proportions to rounded percentages
  res <- data.frame(
    pedon_key = i$pedon_key[1],
    round(t(prop) * 100),
    stringsAsFactors = FALSE
  )
  
  return(res)
}

# this is probably more efficient in SQL
z <- split(data.available.by.hz, data.available.by.hz$pedon_key)
zz <- lapply(z, dataAvail)
zz <- do.call('rbind', zz)

str(zz)

kable(head(zz, 7), row.names = FALSE)

wm.combined <- merge(wm, zz, by = 'pedon_key', sort = FALSE)
wm.subset <- subset(wm.combined, subset = geochemical_present > 50)

nrow(wm)
nrow(wm.combined)
nrow(wm.subset)

vars <- c('long', 'lat', 'pedon_key', 'user_pedon_id', 'series', names(zz[-1]))
kable(head(wm.subset, 3)[, vars], row.names = FALSE)


# save a copy for now
write.csv(zz, file = 'e:/temp/geochem-available.csv', row.names = FALSE)


