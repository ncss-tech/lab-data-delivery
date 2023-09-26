## load packages
library(venn)

# flag for re-making the cached data
remake <- TRUE


## pre-cache data
if(remake) {
  library(DBI)
  library(RSQLite)
  
  
  ## KSSL data first
  
  # connect
  db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/NCSSLabDataMartSQLite.sqlite3')
  
  # list tables
  dbListTables(db)
  
  
  qq <- "
SELECT 
l.labsampnum AS layer_id, g.labsampnum AS geochem_id, x.labsampnum AS mineral_id, gl.labsampnum AS glass_id, p.labsampnum AS physical_id, c.labsampnum AS chemical_id,
CASE WHEN rk.layer_key IS NOT NULL THEN l.labsampnum ELSE NULL END AS rosetta_id
FROM lab_layer AS l
LEFT JOIN lab_physical_properties_vw AS p ON l.labsampnum = p.labsampnum
LEFT JOIN lab_chemical_properties_vw AS c ON l.labsampnum = c.labsampnum
LEFT JOIN lab_major_and_trace_elements_and_oxides_vw AS g ON l.labsampnum = g.labsampnum
LEFT JOIN lab_xray_and_thermal_vw AS x ON l.labsampnum = x.labsampnum
LEFT JOIN lab_mineralogy_glass_count_vw AS gl ON l.labsampnum = gl.labsampnum
LEFT JOIN lab_rosetta_key AS rk ON l.layer_key = rk.layer_key
;"
  
  # run query
  x <- dbGetQuery(db, qq)
  
  # close connection
  dbDisconnect(db)
  
  
  ## NASIS data next
  # connect
  db <- dbConnect(RSQLite::SQLite(), 'E:/NASIS-KSSL-LDM/NASIS_Pedons_20210525.sqlite')
  
  # list tables
  dbListTables(db)
  
  qq <- "
SELECT 
s.labsampnum AS morp_id
FROM phsample AS s
JOIN
phorizon AS h ON h.phiid = s.phiidref
JOIN phcolor AS c ON h.phiid = c.phiidref
JOIN phstructure AS st ON h.phiid = st.phiidref
WHERE s.labsampnum IS NOT NULL
;"
  
  # run query
  y <- dbGetQuery(db, qq)
  
  # close connection
  dbDisconnect(db)

  save(x, y, file = 'cached-data.rda')
    
} else {
  load('cached-data.rda')
}




# assemble list of labsampnum (IDs)

z <- list(
  `Morphology\n(color, structure, ...)\n` = unique(na.omit(y$morp_id)),
  `Physical\n(PSD, Db, ...)\n` = unique(na.omit(x$physical_id)),
  `Chemical\n(pH, CEC, ...)\n` = unique(na.omit(x$chemical_id)),
  `Geochemical\n(elemental analysis)\n` = unique(na.omit(x$geochem_id)),
  `Mineralogy\n(XRD, TGA, optical)\n` = unique(c(na.omit(x$mineral_id), na.omit(x$glass_id)))
)



ragg::agg_png(file = 'KSSL-record-overlap-full-venn.png', width = 1800, height = 1800, scaling = 2.25)

par(mar = c(0, 0, 2, 0))
venn(z, ellipse = TRUE, ilcs = 0.85, sncs = 0.85, par = FALSE, zcolor = 'style', box = FALSE)

dev.off()



svglite::svglite(file = 'KSSL-record-overlap-full-venn.svg', width = 15, height = 15, scaling = 1.5)

par(mar = c(0, 0, 2, 0))
venn(z, ellipse = TRUE, ilcs = 0.85, sncs = 0.85, par = FALSE, zcolor = 'style', box = FALSE)

dev.off()


svglite::svglite(file = 'KSSL-record-overlap-full-venn-no-names.svg', width = 20, height = 20, scaling = 1.5)

par(mar = c(0, 0, 2, 0))
names(z) <- NULL
venn(z, ellipse = TRUE, ilcs = 0.85, sncs = 0.001, par = FALSE, zcolor = 'style', box = FALSE)

dev.off()



