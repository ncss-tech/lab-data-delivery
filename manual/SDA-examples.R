library(soilDB)

x <- SDA_query("SELECT * from lab_analyte WHERE analyte_abbrev = 'db_13bw' ;")
x

x <- SDA_query("SELECT * from lab_analyte WHERE analyte_algorithm LIKE '%db_13bw%' ;")
x$analyte_algorithm

x <- SDA_query("SELECT distinct analyte_abbrev ;")


x <- SDA_query("SELECT TOP 1 * FROM lab_chemical_properties ;")
str(x)

names(x)[grep('carbon', names(x), ignore.case = TRUE)]


x <- SDA_query("SELECT TOP 10 * FROM lab_physical_properties ;")
str(x)

x <- SDA_query("SELECT TOP 10 * FROM lab_site ;")
str(x)


x <- SDA_query("SELECT TOP 10 * FROM lab_analysis_procedure ;")

# see proced_code --> links to methods in properties table
x <- SDA_query("SELECT TOP 10 * FROM lab_method_code ;")



x <- SDA_query("SELECT TOP 1 * FROM lab_layer ;")
str(x)


x <- SDA_query("SELECT TOP 1 * FROM lab_pedon ;")
str(x)



# from NASIS
x <- SDA_query("SELECT TOP 1 * FROM lab_combine_nasis_ncss ;")
str(x)

x <- SDA_query("SELECT site_obsdate FROM lab_combine_nasis_ncss ;")
str(x)

x <- as.Date(x$site_obsdate, format = "%m/%d/%y")

range(x)
