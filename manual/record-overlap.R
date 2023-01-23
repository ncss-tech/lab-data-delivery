
## load packages
library(aqp)
library(soilDB)
library(venn)

library(DBI)
library(RSQLite)



## TODO: cross-tabulate record IDs in KSSL snapshot vs. NASIS

## TODO: special syntax required, rosetta table missing labsampnum... why?


##
## local SQLite snapshot, you will have to download / edit path to file
##

# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/ncss_labdata.sqlite')

# list tables
dbListTables(db)


qq <- "
SELECT 
l.labsampnum AS layer_id, g.labsampnum AS geochem_id, x.labsampnum AS mineral_id, gl.labsampnum AS glass_id, p.labsampnum AS physical_id, c.labsampnum AS chemical_id,
CASE WHEN rk.layer_key IS NOT NULL THEN l.labsampnum ELSE NULL END AS rosetta_id
FROM lab_layer AS l
LEFT JOIN lab_physical_properties AS p ON l.labsampnum = p.labsampnum
LEFT JOIN lab_chemical_properties AS c ON l.labsampnum = c.labsampnum
LEFT JOIN lab_major_and_trace_elements_and_oxides AS g ON l.labsampnum = g.labsampnum
LEFT JOIN lab_xray_and_thermal AS x ON l.labsampnum = x.labsampnum
LEFT JOIN lab_mineralogy_glass_count AS gl ON l.labsampnum = gl.labsampnum
LEFT JOIN lab_rosetta_key AS rk ON l.layer_key = rk.layer_key
;"

# run query
x <- dbGetQuery(db, qq)

# close connection
dbDisconnect(db)




l <- list(
  `Layers\n(samples)\n` = unique(na.omit(x$layer_id)),
  `Geochemical\n(elemental analysis)\n` = unique(na.omit(x$geochem_id)),
  `Mineralogy\n(XRD or TGA)\n` = unique(na.omit(x$mineral_id)),
  `Glass Counts\n(sand, silt fractions)\n` = unique(na.omit(x$glass_id))
)


png(file = 'KSSL-record-overlap-venn.png', width = 850, height = 800, res = 90, type = 'cairo', antialias = 'subpixel')

par(mar = c(0, 0, 2, 0))
venn(l, ellipse = TRUE, ilcs = 0.85, sncs = 0.85, par = FALSE, zcolor = 'style', box = FALSE)
title('KSSL Record Overlap')

text(x = 730, y = 130, 'Intersections describe overlap in record availability.\n\nThere are 342,199 records missing geochemical, \nminerology, or glass count data. There are 10,621\nrecords with all data.', cex = 0.66, adj = 0)

dev.off()



l <- list(
  `Layers\n(samples)\n` = unique(na.omit(x$layer_id)),
  `Physical\n(PSD, Db, ...)\n` = unique(na.omit(x$physical_id)),
  `Chemical\n(pH, CEC, ...)\n` = unique(na.omit(x$chemical_id)),
  `Geochemical\n(elemental analysis)\n` = unique(na.omit(x$geochem_id)),
  `Mineralogy\n(XRD or TGA)\n` = unique(na.omit(x$mineral_id))
)

png(file = 'KSSL-record-overlap-full-venn.png', width = 850, height = 800, res = 90, type = 'cairo', antialias = 'subpixel')

par(mar = c(0, 0, 2, 0))
venn(l, ellipse = TRUE, ilcs = 0.85, sncs = 0.85, par = FALSE, zcolor = 'style', box = FALSE)
title('KSSL Record Overlap')

dev.off()



l <- list(
  `Layers\n(samples)\n` = unique(na.omit(x$layer_id)),
  `Physical\n(sand, silt, clay, Db, COLE, ...)` = unique(na.omit(x$physical_id)),
  `Chemical\n(pH, EC, CEC, ...)\n` = unique(na.omit(x$chemical_id))
)


png(file = 'KSSL-record-overlap-phys-chem-venn.png', width = 850, height = 800, res = 90, type = 'cairo', antialias = 'subpixel')

par(mar = c(0, 0, 2, 0))
venn(l, ellipse = FALSE, ilcs = 0.85, sncs = 1, par = FALSE, zcolor = 'style', box = FALSE)
title('KSSL Record Overlap')

dev.off()





## ROSETTA

l <- list(
  `Layers\n(samples)\n` = unique(na.omit(x$layer_id)),
  `Physical\n(sand, silt, clay, Db, COLE, ...)` = unique(na.omit(x$physical_id)),
  `ROSETTA` = unique(na.omit(x$rosetta_id))
)


png(file = 'KSSL-record-overlap-phys-chem-venn.png', width = 850, height = 800, res = 90, type = 'cairo', antialias = 'subpixel')

par(mar = c(0, 0, 2, 0))
venn(l, ellipse = FALSE, ilcs = 0.85, sncs = 1, par = FALSE, zcolor = 'style', box = FALSE)
title('KSSL Record Overlap')

dev.off()


# cross-check ROSETTA record number
# ~ 79,200
SDA_query("SELECT COUNT(layer_key) FROM lab_rosetta_key;")




## water retention at various suctions

.sql <- "SELECT COUNT(water_retention_10th_bar) FROM lab_physical_properties WHERE water_retention_10th_bar IS NOT NULL ;"
.tenth <- SDA_query(.sql)$V1

.sql <- "SELECT COUNT(water_retention_third_bar) FROM lab_physical_properties WHERE water_retention_third_bar IS NOT NULL ;"
.third <- SDA_query(.sql)$V1

.sql <- "SELECT COUNT(water_retention_15_bar) FROM lab_physical_properties WHERE water_retention_15_bar IS NOT NULL ;"
.fifteen <- SDA_query(.sql)$V1

.sql <- "SELECT COUNT(water_retention_0_bar_sieve) FROM lab_physical_properties WHERE water_retention_0_bar_sieve IS NOT NULL ;"
.sat <- SDA_query(.sql)$V1



x <- data.frame(
  zerobar = .sat,
  tenthbar = .tenth,
  thirdbar = .third,
  fifteen = .fifteen
)

knitr::kable(x)

## 2023-01-20
#  | zerobar| tenthbar| thirdbar| fifteen|
#  |-------:|--------:|--------:|-------:|
#  |      89|    17271|   105963|  222023|




