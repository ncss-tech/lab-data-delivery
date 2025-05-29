
library(soilDB)
library(sf)
library(dplyr)


# include the link to the webpage so we know which version we're talking about
# Tabular and Spatial GPKG add in the metadata tables from a download
fp <- "D:/geodata/soils/NCSS-SCD"
dsn <- file.path(fp, "ncss_labdata.gpkg")
con  <- DBI::dbConnect(RSQLite::SQLite(), dbname = dsn)
lyrs <- st_layers(dsn) |> as.data.frame()

dsn2  <- file.path(fp, "NASIS_Morphological_09142021.sqlite")
con2  <- DBI::dbConnect(RSQLite::SQLite(), dbname = dsn2)
lyrs2 <- DBI::dbListTables(con2)
lyrs2 <- lyrs2[grepl("Metadata", lyrs2)]

# read in data ----
## dm ----
test <- dm_from_con(con)


## NASIS ----
# query


## domains ----
dom <- soilDB::dbQueryNASIS(
  soilDB::dbConnectNASIS(), 
  "SELECT DomainName, DomainRanked, ColumnPhysicalName, ColumnLogicalName, ColumnLabel, ColumnDescription, UnitsofMeasureUnabbreviated, UnitsofMeasureAbbreviated, ChoiceSequence, ChoiceValue, ChoiceName, ChoiceLabel, ChoiceDescription
  
  FROM
  MetadataTableColumn  mtc INNER JOIN
  MetadataDomainMaster mdm ON mdm.DomainID = mtc.DomainID INNER JOIN
  MetadataDomainDetail mdd ON mdd.DomainID = mdm.DomainID ---- INNER JOIN
  ---- domaingroup          dg  ON dg.grpiidref = mdm.grpiidref
  
  ---- WHERE domgrpname = 'Current NASIS/SSURGO Domains'
  "
  )
dom <- dom[!duplicated(dom), ]

# # replicate missing domains
# vars <- c("corrtaxonkind", "samptaxonkind", "ssltaxonkind")
# dom_sub  <- subset(dom, ColumnPhysicalName == "taxonkind")
# dom_sub  <- lapply(vars, function(i) {
#   x <- dom_sub
#   x[, "ColumnPhysicalName"] <- i
#   return(x)
# })
# dom_sub <- do.call("rbind", dom_sub)
# 
# dom <- rbind(dom, dom_sub)


## nasis data model ----
dd <- soilDB::dbQueryNASIS(
  soilDB::dbConnectNASIS(), 
  " SELECT sysnm, tablecollectname, tabphynm, tablognm, tablab, tabdesc, tabhelptext,
  attributeid, attlognm, attphynm, attlabel, attoffdef, attlogdattyp, 
  uomunits, uomsym
  
  FROM 
  system                                                        INNER JOIN 
  tablecollection tc ON tc.sysiidref       = sysiid             INNER JOIN 
  systemtable     st ON tablecollectiidref = tc.tablecollectiid INNER JOIN 
  tablecolumn     tb ON tb.systabiidref    = st.systabiid       INNER JOIN 
  attribute       at ON at.attiid          = tb.attiidref       LEFT OUTER JOIN
  uom                ON uom.uomiid         = at.uomiidref 
  
  WHERE sysnm = 'Lab SDA Data Mart' OR sysver = 'METADATA 2.0.2'
  "
  )

lev <- dom |> 
  subset(DomainName == "logical_data_type_nasis", select = c(ChoiceValue, ChoiceLabel)) |>
  arrange(ChoiceValue)
lev <- lev[lev$ChoiceValue %in% unique(dd$attlogdattyp), ]

dd <- within(dd, {
  # convert to factor
  attlogdattyp = factor(attlogdattyp, levels = lev$ChoiceValue, labels = lev$ChoiceLabel) |>
    as.character()
  
  system = ifelse(tablecollectname == "Lab Data Mart Tables", "Lab Data Mart Tables", "METADATA")
})

# replicate missing data attributes
# vars <- c("choice", "choicesequence") # "ChoiceObsolete", 
# dd_sub  <- subset(dd, attphynm %in% vars)
# dd_sub  <- lapply(vars, function(i) {
#   x <- dd_sub
#   x[, "attphynm"] <- i
#   x$sysnm <- "METADATA"
#   return(x)
# })
# dd_sub <- do.call("rbind", dd_sub)
# 
# dd <- rbind(dd, dd_sub)


## static data model ----
dd2  <- read.csv(file.path(fp, "NCSS Columns Description.csv"))



## NCSS-SCD ----
# issue, the lab_analysis_procedure table appears to be redundant
# issue, the lab_analyte table doesn't join to anything, but really should, how else can someone tell what units the methods are using
scd <- lapply(lyrs$name, function(x) {
  cat("reading", as.character(x), format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
  
  tmp <- read_sf(dsn, x, as_tibble = FALSE)
})
names(scd) <- lyrs$name


scd2 <- lapply(lyrs2, function(x) {
  cat("reading", as.character(x), format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
  
  tmp <- DBI::dbReadTable(con, x)
})
names(scd2) <- lyrs2

scd <- c(scd, scd2)
# saveRDS(scd, file.path(fp, "ncss_labdata.rds"))
scd <- readRDS(file.path(fp, "ncss_labdata.rds"))



# fix deployed NCSS-SCD variable names ----
# deployed tables                                             system tables
# var2[var2 == "d_wavelength_array_id"]                       = issue, "?" # this doesn't have a match in NASIS, added to NASIS
# var2[var2 == "description"]                                 = issue, "?" # this doesn't have a match in NASIS, added to NASIS
# var2[var2 == "KH_Halloysite_Differential_thermal_Analysis"] = "kh_halloysite_fifferential_thermal_analysis" # fixed in NASIS
fix_nms <- rbind(
  c("RB_Riebeckite_Blue_Amphibole_Pero_Count", "rb_riebeckite_blue_amphibole_petro_count"),
  # c("rosetta_key",                            "?"), # issue, this doesn't have a match in NASIS, it doesn't appear to be necessary all(rosetta_key == result_source_key) == TRUE
  c("volume_pct_2_to_5_mm_third_ws",           "volume_pct_2_to_5_mm_thirdbar_ws"),    # fixed in NASIS
  c("volume_pct_5_to_20_mm_third_ws",          "volume_pct_5_to_20_mm_thirdbar_ws"),   # fixed in NASIS
  c("volume_pct_20_to_75_mm_third_ws",         "volume_pct_20_to_75_mm_thirdbar_ws"),  # fixed in NASIS
  c("volume_pct_75_to_250_mm_third_ws",        "volume_pct_75_to_250_mm_thirdbar_ws"), # fixed in NASIS
  c("volume_pct_2_to_75_mm_third_ws",          "volume_pct_2_to_75_mm_thirdbar_ws"),   # fixed in NASIS
  c("volume_pct_lt_2_mm_third_ws",             "volume_pct_lt_2_mm_thirdbar_ws"),      # fixed in NASIS
  # c("wavelength_string",                     "wavelength"),                          # fixed in NASIS
  c("water_retention_field_state_me",          "water_retention_field_state_method"),
  c("wt_pct_clay_clay_free_2mm_base",          "wt_pct_clay_clay_free_2_mm_base"),
  c("choice",                                  "ChoiceName"),
  c("choice_obsolete",                         "ChoiceObsolete"),
  c("choice_id",                               "ChoiceValue"),
  # # c("choice_acronym",                        "?"),
  c("choice_label",                             "ChoiceLabel"),
  c("choice_sequence",                          "ChoiceSequence"),
  # c("choice_sequence",                         "ChoiceSequence"),
  c("fieldSize",                               "FieldSize"),
  c("NotNull_",                                "NotNull"),
  c("TableName",                               "TablePhysicalName"),
  c("domain_id",                               "DomainID")
) |>
  as.data.frame()
names(fix_nms) <- c("bad_nms", "good_nms")


scd_nms <- names(scd)
scd_new <- lapply(scd_nms, function(i) {
  
  x <- scd[[i]]
  
  nms <- names(x)
  idx <- nms %in% fix_nms$bad_nms
  
  new_nms <- sapply(nms[idx], function(x) {
    fix_nms$good_nms[fix_nms$bad_nms == x]
  }) |>
    unname()
  
  names(x)[idx] <- new_nms
  
  if (grepl("^lab", i))              names(x) <- tolower(names(x))
  
  return(x)
})
names(scd_new) <- scd_nms


# scd$lab_calculations_including_estimates_and_default_values |> names() |> cbind() |> View()



# convert data model and domain names ----
# to the physical names and choicelabels to be consistent with SSURGO
# the current design uses a mix and match of physical, logical, and label names
# similarly the Choice fields mix and match the values, names, and labels.


## subset tables, columns, and choices ----
### table names ----
tb_vars <- c("tabphynm", "tablognm", "tablab")
dd_tbs <- dd[tb_vars]
dd_tbs <- dd_tbs[!duplicated(dd_tbs), ]


### column names ----
col_vars <- c("attphynm", "attlognm", "attlabel")
dd_cols <- dd[col_vars]
dd_cols <- dd_cols[!duplicated(dd_cols), ]


### choice names ----
choice_vars <- c("ColumnPhysicalName", "ChoiceValue", "ChoiceName", "ChoiceLabel")
dom_choices <- dom[choice_vars]
dom_choices <- dom_choices[!duplicated(dom_choices), ]


## rename tables, columns and choices ----
### rename column names ----
scd_new <- lapply(scd_nms, function(i) {
  
  cat(as.character(Sys.time()), i, "\n")
  
  x <- scd_new[[i]]
  
  
  # column names
  nms <- names(x)
  
  nms_phy_idx <- nms %in% dd$attphynm
  nms_log_idx <- nms %in% dd$attlognm
  nms_lab_idx <- nms %in% dd$attlabel
  nms_idx     <- nms_phy_idx | nms_log_idx | nms_lab_idx
  nms_sub     <- nms[nms_idx]
  
  nms_phy <- sapply(nms_sub, function(y) {
    
    phy <- dd_cols$attphynm[
      dd_cols$attphynm %in% y
      | dd_cols$attlognm %in% y
      | dd_cols$attlabel %in% y
    ]
    return(phy)
  }) |> unname()
  
  nms_new <- nms
  nms_new[nms_idx] <- nms_phy
  
  names(x) <- nms_new
  
  return(x)
})
names(scd_new) <- scd_nms



### rename table names ----
scd_new_nms <- sapply(scd_nms, function(x) {
  
  # table names
  tbs_phy <- dd_tbs$tabphynm[
    dd_tbs$tabphynm   %in% x
    | dd_tbs$tablognm %in% x
    | dd_tbs$tablab   %in% x
  ]
}) |> unname()
names(scd_new) <- scd_new_nms



### rename table value choices ----
# issue it looks like SSL_classtype etc could be taxonkind
vars    <- c("sampclasstype", "corrclasstype", "sslclasstype")
new_nms <- c("samptaxonkind", "corrtaxonkind", "ssltaxonkind")
idx <- names(scd_new$labcombinenasisncss) %in% vars
names(scd_new$labcombinenasisncss)[idx] <- new_nms


scd_new <- lapply(scd_new_nms, function(i) {
  
  cat(as.character(Sys.time()), i, "\n")
  
  x <- scd_new[[i]]
  
  # find character columns that match domain choices and
  # relabels them to the 
  col_nms <- names(x)
  col_nms <- data.frame(
    col_nms, 
    col_nms_sub = gsub("^corr|^samp|^ssl", "", col_nms)
  )
  col_choice_idx <- sapply(1:ncol(x), function(i) {
    (is.character(x[[i]]) | is.integer(x[[i]])) & col_nms[i, 2] %in% dom$ColumnPhysicalName
  })
  col_choice <- col_nms[col_choice_idx, 1]
  
  
  col_new <- lapply(which(col_choice_idx), function(i) {
    
    col     <- x[[i]]
    col_nm  <- col_nms[i, 2]
    
    dom_idx <- dom_choices$ColumnPhysicalName %in% col_nm
    choice_value <- dom_choices$ChoiceValue[dom_idx]
    choice_name  <- dom_choices$ChoiceName[dom_idx]
    choice_label <- dom_choices$ChoiceLabel[dom_idx]
    
    
    # relabel values
    col <- ifelse(
      col %in% choice_value,
      factor(col, levels = choice_value, labels = choice_label) |> as.character(),
      col
    )
    # relabel labels
    col <- ifelse(
      col %in% choice_name,
      factor(col, levels = choice_name, labels = choice_label) |> as.character(),
      col
    )
    
    return(col)
  })
  
  x_new <- x
  x_new[col_choice_idx] <- col_new
  
  if (all(is.na(x) != is.na(x_new))) stop("all(is.na(x) == is.na(x_new))")
  
  return(x_new)
})
names(scd_new) <- scd_new_nms

# saveRDS(scd_new, file.path(fp, "ncss_labdata_phynames.rds"))
scd_new <- readRDS(file.path(fp, "ncss_labdata_phynames.rds"))


# estimate completeness ----
idx <- length(scd_new)
idx <- 1:(idx)
# future::plan(future::multisession, workers = 8)
prep_fun <- function(i) {
  
  cat(as.character(Sys.time()), names(scd_new)[i], "\n")
  
  x <- scd_new[[i]]
  
  tmp  <- data.frame(
    n_na = colSums(is.na(x))
  )
  row.names(tmp) <- names(x)
  
  tmp$n <- sapply(x, function(x) {
    sum(!is.na(x))
  })
  
  tmp$`Data Type` <- sapply(x, function(x) {
    ifelse(
      any(class(x) %in% c("POSIXct", "POSIXt")),
      "DateTime",
      class(x)[1]
    )})
  
  tmp$min <- sapply(x, function(x) {
    ifelse(
      is.numeric(x) |
        any(class(x) %in% c("POSIXct", "POSIXt")),
      min(x, na.rm = TRUE),
      NA
    )})
  tmp$max <- sapply(x, function(x) {
    ifelse(
      is.numeric(x) |
        any(class(x) %in% c("POSIXct", "POSIXt")),
      max(x, na.rm = TRUE),
      NA
    )})
  tmp$l <- sapply(x, function(x) {
    idx <- 1:1000
    ifelse(
      is.character(x),
      substr(paste(sort(unique(x[1:1000][!is.na(x[1:1000])])), collapse = ";"), 1, 1000),
      NA
    )})
  
  tmp$tbname = names(scd_new)[i]
  tmp$var    = row.names(tmp)
  row.names(tmp) <- NULL
  tmp <- tmp[c(7:8, 1:6)]
  
  return(tmp)
}
# scd_prep <- future.apply::future_lapply(idx, prep_fun) #, scd_new, names(scd_new)[idx])
scd_prep <- lapply(idx, prep_fun) 
scd_prep <- do.call("rbind", scd_prep) |>
  within({
    system = ifelse(grepl("Metadata", tbname), "METADATA", "Lab Data Mart Tables")
    })
table(scd_prep$`Data Type`)
# saveRDS(scd_prep, file.path(fp, "scd_prep.rds"))
scd_prep <- readRDS(file.path(fp, "scd_prep.rds"))



# issues: ----
# _Mineral_Interpretation codes, where are they coming from
# texture_lab codes include a mix of data types (e.g. numeric, characters), and use a mix of upper and lower cases (e.g. cosl, CoSL)
# bulk_density_3rd_bar_source, missing codes
# limnic_material_type, missing codes
# decomposition_state, missing codes
# analyzed_size_frac, missing codes
# method codes missing from the following c("analyte_agg_method", "differential_scanning_calorimeter_method", "thermal_gravimetric_method", "differential_thermal_analysis_method", "x_ray_method", "glass_count_method", "cole_whole_soil_method", "le_third_ovendry_lt_2_mm_method", "le_fm_to_od_method", "water_retention_3_bar_method", "water_retention_field_state_method", "petro_count_method", "phosphorus_bray2_method")



# lookup domains ----
## methods ----
met <- scd_new$labmethodcode # method table
met$method <- paste0(met$procedname, " (", met$proceddesc, ")")
vars <- c("procedcode", "method")
idx  <- !duplicated(met[vars]) & !is.na(met$procedcode)
met <- met[idx, vars]
met <- met[order(met$procedcode), ]
names(met) <- c("code", "description")
row.names(met) <- NULL


## area
area <- scd_new$labarea # area table
vars <- c("areakey", "areaname", "areatype", "areasubtype")
idx  <- !duplicated(area[vars])
area <- area[idx, vars]

area <- within(area, {
  areasubtype = gsub("\\($", "", area$areasubtype)
  areasubtype = gsub("\\(Kinya", "(Kinya)", areasubtype) # issue with unclosed parentheses
  
  description = paste0(
  area$areaname, 
  ifelse(
    is.na(area$areasubtype), 
    paste0(" (",  area$areatype,                           ")"),
    paste0(" (",  area$areatype, " and ", area$areasubtype, ")")
  ))
})
area <- area[c(1, 2)]
names(area) <- c("code", "description")
row.names(area) <- NULL


## prep
# issue, the prep code aren't unique, causes one to many joins
prep <- scd_new$labpreparation # preparation table
vars <- c("prepcode", "prepdesc")
idx  <- !duplicated(prep[vars])
prep <- prep[idx, vars]
names(prep) <- c("code", "description")
row.names(prep) <- NULL


## scd tables ----
scd_nm <- names(scd_new)
scd_dom <- c("labpreparation", "labmethodcode", "labarea", "labanalyte", "labanalysisprocedure", "labrosettakey", "MetadataIndexDetail") #, "MetadataTableColumn", "MetadataCardinality", "MetadataColumnLookup", "MetadataDomainDetail", "MetadataRelationshipDetail", "MetadataRelationshipMaster", "MetadataTable")
scd_pat   <- "method$|waterretentionfieldstateme|prepcode"
nasis_pat <- "^samp|^corr|^SSL|latdir$|longdir$|horizdatnm$"
var_pat   <- paste0(scd_pat, "|", nasis_pat) 

scd_char_vars <- c(
  scd_prep$var[scd_prep$`Data Type` == "character"],
  c("countrykey", "statekey", "countykey", "mlrakey", "ssakey", "nparkkey", "nforestkey"),
  c("SortDirectionName", "SortTypeName", "AlignmentName", "Cardinality", 
    "CardinalityName", "DefaultTypeName", "LogicalDataTypeName", 
    "PhysicalDataTypeName", "LogicalDataType", "Alignment", "SortType", 
    "SortDirection", "DefaultType", "PhysicalDataType", "DatetimePrecision", 
    "DatetimePrecisionName")
  )


idx <- ! scd_nm %in% scd_dom
scd_nm <- scd_nm[idx]


## join scd with methods ----

test <- lapply(scd_nm, function(i) {
  
  cat(as.character(Sys.time()), i, "\n")
  
  x <- scd_new[[i]] |> 
    sf::st_drop_geometry()
  
  nm  <- names(x) 
  idx <- nm %in% scd_char_vars
  nm  <- nm[idx]
  idx <- which(idx)
  
  x2 <- x[idx]
  x2$tbname <- i
  
  x2 <- x2 |>
    reshape(
      direction = "long",
      timevar = "var",   times = nm,
      v.names = "value", varying = nm
    )
  x2 <- subset(
    x2,
    !is.na(var)
    & !is.na(value)
    & value != ""
   )
  vars <- c("tbname", "var", "value")
  idx  <-!duplicated(x2)
  x2   <- x2[idx, vars]
  
  vars <- c("ColumnPhysicalName", "ColumnLabel")
  dom_sub <- dom[vars]
  dom_sub <- dom_sub[!duplicated(dom_sub), ]
  
  
  # merge lab_methods_code ----
  x2_prep1 <- x2 |>
    subset(
      grepl(scd_pat, var, ignore.case = TRUE)
      ) |>
    data.table::data.table() |>
    merge(met, by.x = "value", by.y = "code", all = FALSE, allow.cartesian = TRUE) |>
    as.data.frame()
  x2_prep1 <- x2_prep1[!duplicated(x2_prep1), ]
  if (nrow(x2_prep1) > 0) {
    x2_prep1$lookup = "labmethodcode"
    x2_prep1$tbname = i
  } else {
    x2_prep1$lookup[0] = "labmethodcode"
    x2_prep1$tbname[0] = i
  }
  
  
  # merge lab_preparation ----
  x2_prep2 <- x2 |>
    subset(
      var == "prep_code"
      ) |>
    data.table::data.table() |>
    merge(prep, by.x = "value", by.y = "code", all = FALSE, allow.cartesian = TRUE) |>
    as.data.frame()
  x2_prep2 <- x2_prep2[!duplicated(x2_prep2), ]
  if (nrow(x2_prep2) > 0) {
    x2_prep2$lookup = "labpreparation"
    x2_prep2$tbname = i
  } else {
    x2_prep2$lookup[0] = "labpreparation"
    x2_prep2$tbname[0] = i
  }
  
  # merge lab_area ----
  x2_prep4 <- x2 |>
    subset(
      var %in% c("countrykey", "statekey", "countykey", "mlrakey", "ssakey", "nparkkey", "nforestkey")
      ) |>
    transform(
      value = as.integer(value)
    ) |>
    data.table::data.table() |>
    merge(area, by.x = "value", by.y = "code", all = FALSE, allow.cartesian = TRUE) |>
    as.data.frame()
  x2_prep4 <- x2_prep4[!duplicated(x2_prep4), ]
  if (nrow(x2_prep4) > 0) {
    x2_prep4$lookup = "labarea"
    x2_prep4$tbname = i
  } else {
    x2_prep4$lookup[0] = "labarea"
    x2_prep4$tbname[0] = i
  }
  
  
  # merge NASIS domains ----
  # issues with using a mix of physical, logical, and label names
  dom_vars <- c("ColumnPhysicalName", "ColumnDescription", "ChoiceLabel")
  
  x2$var2 <- gsub("^samp|^corr|^ssl", "", x2$var)
  
  x2_prep3 <- x2 |>
    subset(
      grepl(nasis_pat, var)
      ) |>
    data.table::data.table() |>
    merge(dom[c(dom_vars)], by.x = c("var2", "value"), by.y = c("ColumnPhysicalName", "ChoiceLabel"), all.x = TRUE, allow.cartesian = TRUE) |>
    as.data.frame() |>
    subset(!is.na(ColumnDescription))
  x2_prep3$var2 <- NULL
  x2$var2       <- NULL
  
  names(x2_prep3)[4] <- "description"    
  if (nrow(x2_prep3) > 0) {
    x2_prep3$lookup = "MetadataDomainDetail"
    x2_prep3$tbname = i
  } else {
    x2_prep3$lookup[0] = "MetadataDomainDetail"
    x2_prep3$tbname[0] = i
  }
  x2_prep3 <- subset(x2_prep3, !duplicated(x2_prep3))
  
  
  # METADATA tables
  dom_vars3 <- c("ColumnPhysicalName", "ColumnDescription", "ChoiceLabel")
  
  x2_prep5 <- x2 |>
    subset(
      grepl("^Metadata", tbname)
      ) |>
    data.table::data.table() |>
    merge(dom[c(dom_vars3)], by.x = c("var", "value"), by.y = c("ColumnPhysicalName", "ChoiceLabel"), all.x = TRUE, allow.cartesian = TRUE) |>
    as.data.frame() |>
    subset(!is.na(ColumnDescription))
    
  x2_prep5 <- x2_prep5[!duplicated(x2_prep5), ]
  names(x2_prep5)[4] <- "description"
  if (nrow(x2_prep5) > 0) {
    x2_prep5$lookup = "MetadataDomainDetail"
    x2_prep5$tbname = i
  } else {
    x2_prep5$lookup[0] = "MetadataDomainDetail"
    x2_prep5$tbname[0] = i
  }
  x2_prep5 <- subset(x2_prep5, !duplicated(x2_prep5))
  
  
  x2_prep <- rbind(x2_prep1, x2_prep2, x2_prep3, x2_prep4, x2_prep5)
})
names(test) <- scd_nm
scd_lookup <- do.call("rbind", test)
# saveRDS(scd_lookup, file.path(fp, "scd_lookup.rds"))
scd_lookup <- readRDS(file.path(fp, "scd_lookup.rds"))
names(scd_lookup)[names(scd_lookup) == "description"] <- "domain_description"

scd_lookup_nodups <- scd_lookup[!duplicated(scd_lookup[c("tbname", "var")]), ]
scd_lookup_nodups$ChoiceList <- TRUE
scd_lookup_nodups$var <- scd_lookup_nodups$var


test2 <- subset(
  scd_lookup, 
  ! tbname %in% scd_dom 
  & !grepl(var_pat, var, ignore.case = TRUE)
)
View(test2)


# Validations ----
## issue, some variables data types in NASIS don't match what is in the NCSS-SCD database



# export data dictionary ----

scd_dd <- merge(
  scd_prep,
  dd,
  by.x = c("var",      "system"), # "tbname",   
  by.y = c("attphynm", "system"), # "tabphynm", 
  all.x = TRUE,
  sort  = FALSE
  ) |>
  merge(
    scd_lookup_nodups, 
    by.x = c("tbname", "var"),
    by.y = c("tbname", "var"),
    all.x = TRUE,
    sort  = FALSE
    ) 

View(scd_dd[
  is.na(scd_dd$attoffdef) 
  & !grepl("object", scd_dd$var, ignore.case = TRUE) 
  # & scd_dd$system == "METADATA"
  , ])
# |>
  # merge(
  #   dd[c("system", "attoffdef", "attlabel2_lower")],
  #   by.x = c("system", "var2_lower"),
  #   by.y = c("system", "attlabel2_lower"),
  #   all.x = TRUE,
  #   sort  = FALSE
  #   ) |> View()
  
# scd_dd <- merge(
#   scd_dd,
#   # dd,
#   dd2,
#   by.x = c("tbname", "var3"),
#   # by.y = c("tablognm", "attlognm"),
#   by.y = c("table_name", "column_name"),
#   all.x = TRUE,
#   sort = FALSE
# )
# scd_dd$attoffdef <- ifelse(is.na(scd_dd$attoffdef), scd_dd$column_description, scd_dd$attoffdef)

# calculate Obligation/Condition
scd_dom <- c("labpreparation", "labmethodcode", "labarea", "labanalyte", "labanalysisprocedure", "labrosetta_key")

scd_dd <- within(scd_dd, {
  n_na = ifelse(
    n_na == 1 
    | scd_dd$tbname %in% c("labanalyte", "labanalysisprocedure", "labpreparation", "labarea", "MetadataCardinality", "MetadataColumnLookup", "MetadataDomainDetail", "MetadataIndexDetail", "MetadataRelationshipDetail", "MetadataRelationshipMaster", "MetadataTable", "MetadataTableColumn"), 
    "M", 
    "O")
  n_na = ifelse(
    n_na == "O" & grepl("key$|^apid$|^wmiid$|^mcid$|^smp_id$|dwavelengtharrayid|siteobsdate|^areacode$|^layertype$", var), 
    "M", 
    n_na)
  n_na = ifelse(
    n_na == "O" & grepl("method$", var), 
    "C/if the matching measure is NOT NULL", 
    n_na)
  n_na = ifelse(
    n_na == "O" & grepl("^peiid$|^siteiid$", var), 
    "C/if present in NASIS", 
    n_na)
  n_na = ifelse(
    n_na == "O" & grepl("^pedlabsampnum$|^labsampnum$", var), 
    "C/if present in LIMS", 
    n_na)
  n_na = ifelse(
    var  %in% c("resultsourcekey", "parentarekey", "parentorgkey", "countrykey", "statekey", "countykey", "mlrakey", "ssakeynforestkey") 
    & tbname != "labchemicalproperties", 
    "O", 
    n_na
    )
  ChoiceList = ifelse(ChoiceList == TRUE | !is.na(lookup), TRUE, FALSE)
  `Data Type` = ifelse(
    `Data Type` != "sfc_Point", 
    paste0(toupper(substr(`Data Type`, 1, 1)), substr(`Data Type`, 2, nchar(`Data Type`))),
    `Data Type`
    )
  `Data Type` = ifelse(
    `attlogdattyp` == "Boolean",
    "Boolean",
    `Data Type`
    )
  `Data Type` = ifelse(
    is.na(ChoiceList),
    `Data Type`,
    paste0("<<CodeListe>>", "\n", lookup)
    )
  attoffdef = ifelse(!is.na(uomunits), paste0(attoffdef, " (", uomunits,")"), attoffdef)
})
# scd_dd <- within(scd_dd, {
#   `Data Type` = ifelse(`Data Type` == "numeric", "real", `Data Type`)
#   `Data Type` = ifelse(`Data Type` == "character", "CharacterString", `Data Type`)
# })

# vars <- c("tbname", "var", "attoffdef", "n_na", "attlogdattyp")
vars <- c("tabhelptext", "tbname", "var", "attoffdef", "n_na", "Data Type")
scd_dd <- scd_dd[vars]

vars <- c("Table Name", "Name/Role Name", "Definition", paste0("Obligation/", "\n", "Condition"), "Data Type")
names(scd_dd)[2:ncol(scd_dd)] <- vars

scd_dd$`Maximum Occurrence` <- "*"
scd_dd$`Domain` <- "Unrestricted"

vars <- c("tabhelptext", "Table Name", "Name/Role Name", "Definition", paste0("Obligation/", "\n", "Condition"), "Maximum Occurrence", "Data Type", "Domain")
idx <- grepl("^object", scd_dd$`Name/Role Name`, ignore.case = TRUE)
scd_dd <- scd_dd[!idx, vars]

# saveRDS(scd_dd, file.path(fp, "scd_dd.rds"))
scd_dd <- readRDS(file.path(fp, "scd_dd.rds"))

scd_dd |> subset(is.na(`Definition`)) |> View()



