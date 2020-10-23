library(soilDB)

x <- SDA_query("SELECT * from lab_analyte WHERE analyte_abbrev = 'db_13bw' ;")
x

x <- SDA_query("SELECT * from lab_analyte WHERE analyte_algorithm LIKE '%db_13bw%' ;")
x$analyte_algorithm

x <- SDA_query("SELECT distinct analyte_abbrev ;")


x <- SDA_query("SELECT TOP 10 * FROM lab_chemical_properties ;")

x <- SDA_query("SELECT TOP 10 * FROM lab_analysis_procedure ;")
x
