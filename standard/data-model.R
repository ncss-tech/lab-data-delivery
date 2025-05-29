
library(dm)

fp <- "D:/geodata/soils/NCSS-SCD"
dsn <- file.path(fp, "ncss_labdata.gpkg")
con <- DBI::dbConnect(RSQLite::SQLite(), dbname = dsn)


# dm example
lyrs <- DBI::dbListTables(con)
nm  <- lyrs[grepl("^lab_", lyrs)]
scd <- lapply(nm, function(x) DBI::dbReadTable(con, x))
names(scd) <- nm

test <- dm(
  lab_analysis_procedure = scd$lab_analysis_procedure, 
  lab_analyte            = scd$lab_analyte,
)


# dm example 1
scd_dm <- dm_from_con(con)
nm <- names(scd_dm)
nm_sub <- nm[grepl("^lab|Metadata", nm)]
scd_dm <- scd_dm[nm_sub]


# dm example 2
scd_new <- readRDS(file.path(fp, "ncss_labdata_phynames.rds"))
scd_orig <- scd_new
nm <- names(scd_new)
scd_new <- lapply(scd_new, function(x) {
  x <- x |>
    sf::st_drop_geometry() |>
    as.data.frame()
  x$objectid_1 <- NULL
  return(x)
  })
scd_new$labcombinenasisncss <- scd_new$labcombinenasisncss |>
  within({
    sampclassdate = as.character(sampclassdate)
    corrclassdate = as.character(corrclassdate)
    sslclassdate  = as.character(sslclassdate)
  })
scd_new$labcombinenasisncss$shape <- NULL


scd_dm <- new_dm(scd_new)

# create fake method code to draw foreign key relationship
scd_dm <- scd_dm |> 
  dm_zoom_to(labphysicalproperties) |> 
  mutate(`method*` = NA) |>
  dm_insert_zoomed(new_tbl_name = "new_labphysicalproperties") |>
  dm_select_tbl(-labphysicalproperties) |>
  dm_rename_tbl(labphysicalproperties = new_labphysicalproperties)
scd_dm <- scd_dm |> 
  dm_zoom_to(labchemicalproperties) |> 
  mutate(`method*` = NA) |>
  dm_insert_zoomed(new_tbl_name = "new_labchemicalproperties") |>
  dm_select_tbl(-labchemicalproperties) |>
  dm_rename_tbl(labchemicalproperties = new_labchemicalproperties)
scd_dm <- scd_dm |> 
  dm_zoom_to(labmajortrelementsoxides) |> 
  mutate(`method*` = NA) |>
  dm_insert_zoomed(new_tbl_name = "new_labmajortrelementsoxides") |>
  dm_select_tbl(-labmajortrelementsoxides) |>
  dm_rename_tbl(labmajortrelementsoxides = new_labmajortrelementsoxides)
scd_dm <- scd_dm |> 
  dm_zoom_to(labxrayandthermal) |> 
  mutate(`method*` = NA) |>
  dm_insert_zoomed(new_tbl_name = "new_labxrayandthermal") |>
  dm_select_tbl(-labxrayandthermal) |>
  dm_rename_tbl(labxrayandthermal = new_labxrayandthermal)
scd_dm <- scd_dm |> 
  dm_zoom_to(labmineralogyglasscount) |> 
  mutate(`method*` = NA) |>
  dm_insert_zoomed(new_tbl_name = "new_labmineralogyglasscount") |>
  dm_select_tbl(-labmineralogyglasscount) |>
  dm_rename_tbl(labmineralogyglasscount = new_labmineralogyglasscount)


scd_dm <- scd_dm |>
  # primary keys ----
  dm_add_pk(labanalysisprocedure, columns = apid,    autoincrement = TRUE) |>
  dm_add_pk(labanalyte,           columns = analytekey) |>
  dm_add_pk(labarea,              columns = areakey) |> # missing from NASIS
  # dm_add_pk(labcombinenasisncss,  columns = pedlabsampnum) |>
  dm_add_pk(lablayer,             columns = c(layerkey #,
                                              # labsampnum
                                              )) |>
  dm_add_pk(labmethodcode,        columns = mcid) |>
  dm_add_pk(labpedon,             columns = c(pedonkey #,
                                              # pedlabsampnum
                                              )) |>
  dm_add_pk(labpreparation,       columns = c(prepkey), autoincrement = TRUE) |>
  dm_add_pk(labsite,              columns = sitekey, autoincrement = TRUE) |>
  dm_add_pk(labmir,               columns = id) |> # missing from NASIS
  dm_add_pk(labmirwavelength,     columns = dwavelengtharrayid) |> # missing from NASIS
  dm_add_pk(labrosettakey,        columns = rosetta_key) |>
  dm_add_pk(labwebmap,            columns = wmiid) |>
  dm_add_pk(MetadataCardinality,  columns = OBJECTID) |>
  dm_add_pk(MetadataColumnLookup, columns = OBJECTID) |>
  dm_add_pk(MetadataDomainDetail, columns = OBJECTID) |>
  dm_add_pk(MetadataIndexDetail,  columns = OBJECTID) |>
  dm_add_pk(MetadataRelationshipDetail, columns = OBJECTID) |>
  dm_add_pk(MetadataRelationshipMaster, columns = OBJECTID) |>
  dm_add_pk(MetadataTable,        columns = c(OBJECTID,
                                              TableID)) |>
  dm_add_pk(MetadataTableColumn,  columns = c(OBJECTID,
                                              ColumnID))

  # foreign keys ----
scd_dm <- scd_dm |>
  dm_add_fk(labcalculationsandestimates, columns = c(layerkey #,
                                                       # labsampnum
                                                       ),
            ref_table = lablayer,        ref_columns = c(layerkey #,
                                                           # labsampnum
                                                           )) |>
  dm_add_fk(labchemicalproperties,       columns = c(layerkey #,
                                                       #absampnum
                                                       ),
            ref_table = lablayer,        ref_columns = c(layerkey #,
                                                           #labsampnum
                                                           )) |>
  dm_add_fk(labcombinenasisncss,         columns = c(pedonkey #,
                                                       #pedlabsampnum
                                                       # sitekey,
                                                       # peiid
                                                       ),
            ref_table = labpedon,        ref_columns = c(pedonkey #,
                                                           #pedlabsampnum
                                                           )) |>
  dm_add_fk(labcombinenasisncss,         columns = sitekey,
            ref_table = labsite,         ref_columns = sitekey) |>
  # areakeys  these aren't unique (i.e. valid) therefore they won't export via copy_dm_to()
  dm_add_fk(labcombinenasisncss,         columns     = countrykey,
            ref_table = labarea,         ref_columns = areakey) |>
  dm_add_fk(labcombinenasisncss,         columns     = statekey,
            ref_table = labarea,         ref_columns = areakey) |>
  dm_add_fk(labcombinenasisncss,         columns     = countykey,
            ref_table = labarea,         ref_columns = areakey) |>
  dm_add_fk(labcombinenasisncss,         columns     = mlrakey,
            ref_table = labarea,         ref_columns = areakey) |>
  dm_add_fk(labcombinenasisncss,         columns     = ssakey,
            ref_table = labarea,         ref_columns = areakey) |>
  dm_add_fk(labcombinenasisncss,         columns     = nparkkey,
            ref_table = labarea,         ref_columns = areakey) |>
  dm_add_fk(labcombinenasisncss,         columns     = nforestkey,
            ref_table = labarea,         ref_columns = areakey) |>
  # prepcodes these aren't unique (i.e. valid) therefore they won't export via copy_dm_to()
  dm_add_fk(labcalculationsandestimates,  columns     = prepcode,
            ref_table = labpreparation,  ref_columns = prepcode) |>
  dm_add_fk(labchemicalproperties,       columns     = prepcode,
            ref_table = labpreparation,  ref_columns = prepcode) |>
  dm_add_fk(labmajortrelementsoxides,    columns     = prepcode,
            ref_table = labpreparation,  ref_columns = prepcode) |>
  dm_add_fk(labmineralogyglasscount,     columns     = prepcode,
            ref_table = labpreparation,  ref_columns = prepcode) |>
  dm_add_fk(labphysicalproperties,       columns     = prepcode,
            ref_table = labpreparation,  ref_columns = prepcode) |>
  dm_add_fk(labxrayandthermal,           columns     = prepcode,
            ref_table = labpreparation,  ref_columns = prepcode) |>
  
  dm_add_fk(lablayer,                    columns = c(pedonkey,
                                                     # projectkey,
                                                     # sitekey,
                                                     ),
            ref_table = labpedon,        ref_columns = pedonkey) |>
    dm_add_fk(labphysicalproperties,       columns = c(layerkey #,
                                                       #labsampnum
                                                       ),
              ref_table = lablayer,      ref_columns = c(layerkey #,
                                                         #labsampnum
                                                         )) |>
    dm_add_fk(labmajortrelementsoxides,    columns = c(layerkey #,
                                                       #labsampnum
                                                       # resourcesourcekey
                                                       ),
              ref_table = lablayer,        ref_columns = c(layerkey #,
                                                           #labsampnum
                                                           )) |>
  dm_add_fk(labmineralogyglasscount,     columns = c(layerkey #,
                                                     #labsampnum
                                                     # resultsourcekey
                                                     ),
            ref_table = lablayer,        ref_columns = c(layerkey #,
                                                         #labsampnum
                                                         )) |>
  dm_add_fk(labmethodcode,               columns = c(procedurekey,
                                                     # sourcesystemkey
                                                     ),
            ref_table = labanalysisprocedure, ref_columns = c(procedurekey)) |>
  dm_add_fk(labmir,                      columns = c(layerkey #,
                                                     #labsampnum
                                                     ),
            ref_table = lablayer,        ref_columns = c(layerkey #,
                                                         #labsampnum
                                                         )) |>
  dm_add_fk(labmir,                       columns     = dwavelengtharrayid,
            ref_table = labmirwavelength, ref_columns = dwavelengtharrayid) |>
  dm_add_fk(labpedon,                    columns = sitekey,
            ref_table = labsite,         ref_columns = sitekey) |>
  dm_add_fk(labrosettakey,              columns = c(layerkey #,
                                                     # resultsourcekey
                                                     ),
            ref_table = lablayer,        ref_columns = layerkey) |>
  dm_add_fk(labxrayandthermal,           columns = c(layerkey #,
                                                     # labsampnum #,
                                                     # resultsourcekey
                                                     ),
            ref_table = lablayer,        ref_column = c(layerkey #,
                                                        #labsampnum
                                                        )) |>
  dm_add_fk(labwebmap,                   columns = c(pedonkey,
                                                     # peiid
                                                     ),
            ref_table = labpedon,        ref_columns = c(pedonkey,
                                                         # pedlabsampnum
                                                         )) |>
  # fake .method foreign key relationship
  dm_add_fk(labphysicalproperties,        columns    = `method*`,
            ref_table = labmethodcode,   ref_columns = procedcode) |>
  dm_add_fk(labchemicalproperties,        columns    = `method*`,
            ref_table = labmethodcode,   ref_columns = procedcode) |>
  dm_add_fk(labmajortrelementsoxides,     columns    = `method*`,
            ref_table = labmethodcode,   ref_columns = procedcode) |>
  dm_add_fk(labxrayandthermal,            columns    = `method*`,
            ref_table = labmethodcode,   ref_columns = procedcode) |>
  dm_add_fk(labmineralogyglasscount,        columns  = `method*`,
            ref_table = labmethodcode,   ref_columns = procedcode) |>
  
  # Metadata tables
  dm_add_fk(MetadataTableColumn,               columns     = TableID,
            ref_table = MetadataTable,         ref_columns = TableID) |>
  dm_add_fk(MetadataTableColumn,               columns     = DomainID,
            ref_table = MetadataDomainDetail,  ref_columns = DomainID) |>
  dm_add_fk(MetadataColumnLookup,              columns     = c(ColumnID),
            ref_table = MetadataTableColumn,   ref_column  = ColumnID) |>
  dm_add_fk(MetadataIndexDetail,               columns     = ColumnID,
            ref_table = MetadataTableColumn,   ref_columns = ColumnID) |>
  dm_add_fk(MetadataRelationshipMaster,        columns     = RelationshipID,
            ref_table = MetadataColumnLookup,  ref_columns = RelationshipID) |>
  dm_add_fk(MetadataCardinality,               columns =   Cardinality,
            ref_table = MetadataRelationshipMaster, ref_columns = Cardinality) |>
  dm_add_fk(MetadataRelationshipMaster,        columns     = c(LeftTableID,
                                                               RightTableID),
            ref_table = MetadataRelationshipDetail, ref_columns = c(LeftTableID,
                                                                    RightTableID))
  
  

scd_dm |> dm_select_tbl(!starts_with("Metadata")) |>
  dm_draw(column_types = TRUE, rankdir = "RL")
scd_dm |> dm_select_tbl(starts_with("Metadata")) |>
  dm_draw(column_types = TRUE)

dm_draw(scd_dm, column_types = TRUE)
test <- dm_draw(scd_dm)
test |> 
  DiagrammeRsvg::export_svg() |>
  xml2::read_xml() |>
  xml2::write_xml("ncss-scd_dm_xml.svg")
test |> htmltools::HTML() |> htmltools::html_print()

scd_dm2 <- dm_select_tbl(scd_dm, labanalysisprocedure, labsite, labpreparation)


destination_db <- DBI::dbConnect(RSQLite::SQLite(), bigint = "integer64", dbname = "ncss_labdata_relationships2.sqlite")
copy_dm_to(
  destination_db, 
  scd_dm, 
  temporary = FALSE,
  set_key_constraints = TRUE
  )

template_db <- DBI::dbConnect(RSQLite::SQLite(), bigint = "integer64", dbname = "ncss-scd_template_db.sqlite")

tmp1 <- dm_ddl_pre(scd_dm, template_db, temporary = TRUE)
tmp2 <- dm_ddl_post(scd_dm, template_db, temporary = FALSE)

lapply(tmp1, write, "test.txt", append = TRUE)
lapply(tmp2$indexes, write, "test2.txt", append = TRUE)

