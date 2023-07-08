## load packages
library(aqp)
library(soilDB)
library(DBI)
library(RSQLite)
library(lattice)
library(tactile)

## NASIS data next
# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/NASIS_Pedons_20210525.sqlite')

# # figure out query
# dbListTables(db)
# dbListFields(db, 'phcolor')
# dbListFields(db, 'phorizon')


qq <- "
SELECT 
s.labsampnum AS labsampnum,
h.phiid, h.peiidref AS peiid,
hzname, hzdept, hzdepb,
colorpct, colorhue, colorvalue, colorchroma, colormoistst
FROM phsample AS s
JOIN
phorizon AS h ON h.phiid = s.phiidref
JOIN phcolor AS c ON h.phiid = c.phiidref
WHERE s.labsampnum IS NOT NULL
AND colormoistst = 'Moist'
;"

# run query
y <- dbGetQuery(db, qq)

# close connection
dbDisconnect(db)



z <- y[grep('O|A|B|C', y$hzname), ]

z$m <- sprintf("%s %s/%s", z$colorhue, z$colorvalue, z$colorchroma)
z$col <- parseMunsell(z$m)

sort(table(z$hzname), decreasing = TRUE)

z$type <- 'Mineral'
z$type[grep('e', z$hzname)] <- 'Oe'
z$type[grep('a', z$hzname)] <- 'Oa'
z$type[grep('i', z$hzname)] <- 'Oi'

z$type <- factor(z$type, levels = c('Mineral', 'Oi', 'Oe', 'Oa'))
table(z$type, useNA = 'always')

z <- z[which(!is.na(z$type)), ]


colorChart(z$m, g = z$type, thresh = 0.001)

zz <- split(z, z$type)
qc <- lapply(zz, function(i) colorQuantiles(i$col))

names(qc)
plotColorQuantiles(qc[[3]])


str(z)

# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/NCSSLabDataMartSQLite.sqlite3')

# list tables
dbListTables(db)
dbListFields(db, 'lab_chemical_properties_vw')

.is <- format_SQL_in_statement(z$labsampnum)

qq <- sprintf("
SELECT 
l.labsampnum AS labsampnum, estimated_organic_carbon
FROM lab_layer AS l
LEFT JOIN lab_chemical_properties_vw AS c ON l.labsampnum = c.labsampnum
WHERE estimated_organic_carbon IS NOT NULL AND l.labsampnum IN %s
;", .is
)

# run query
x <- dbGetQuery(db, qq)

str(x)



xy <- merge(z, x, by = 'labsampnum', all.x = TRUE)

str(xy)

.lab <- parseMunsell(xy$m, returnLAB = TRUE)

xy <- cbind(xy, .lab)
head(xy)

bwplot(type ~ estimated_organic_carbon, data = xy, theme = tactile.theme())
bwplot(type ~ L, data = xy, theme = tactile.theme())
bwplot(type ~ A, data = xy, theme = tactile.theme())
bwplot(type ~ B, data = xy, theme = tactile.theme())

library(MASS)
lda <- lda(type ~ L + A + B, data = xy)
lda

