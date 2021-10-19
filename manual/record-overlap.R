
## load packages
library(aqp)
library(soilDB)
library(venn)

library(DBI)
library(RSQLite)



## TODO: cross-tabulate record IDs in KSSL snapshot vs. NASIS



##
## local SQLite snapshot, you will have to download / edit path to file
##

# connect
db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/LDM/LDM-compact.sqlite')

# list tables
dbListTables(db)


qq <- "
SELECT 
l.labsampnum AS layer_id, g.labsampnum AS geochem_id, x.labsampnum AS mineral_id, gl.labsampnum AS glass_id, p.labsampnum AS physical_id, c.labsampnum AS chemical_id
FROM layer AS l
LEFT JOIN physical AS p ON l.labsampnum = p.labsampnum
LEFT JOIN chemical AS c ON l.labsampnum = c.labsampnum
LEFT JOIN geochemical AS g ON l.labsampnum = g.labsampnum
LEFT JOIN xray_thermal AS x ON l.labsampnum = x.labsampnum
LEFT JOIN glass AS gl ON l.labsampnum = gl.labsampnum
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






