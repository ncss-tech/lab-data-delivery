# lab-data-delivery
Re-working the LIMS + NASIS data integration process for snapshot and future web-service based delivery.




## Table review ##
Each table has a folder and associated README.

 * [chemical](https://github.com/ncss-tech/lab-data-delivery/tree/master/tables/chemical) (Dylan)
 * [physical](https://github.com/ncss-tech/lab-data-delivery/tree/master/tables/physical)
 * [x-ray and thermal](https://github.com/ncss-tech/lab-data-delivery/tree/master/tables/x-ray_thermal)
 * [mineralogy and glass counts](https://github.com/ncss-tech/lab-data-delivery/tree/master/tables/mineralogy_glass)
 * [elements](https://github.com/ncss-tech/lab-data-delivery/tree/master/tables/elements)
 * [calculations](https://github.com/ncss-tech/lab-data-delivery/tree/master/tables/calculations)
 

## Immediate tasks ##
 * confirm that each sub-query is in fact returning the requested analyte
 * optimize reshaping query as much as possible: indexing, CTE, temporary tables, reshape-then-filter, etc.
 * identify the magnitude and nature of "data quality" issues in each table
 * make decisions: NULL, truncate to range, etc.
 * finalize metadata: ranges, datatypes, column names, etc.


## Long-term tasks ##
 1. harmonization of morphologic data on LIMS side via NASIS data (?)
 2. synchronization of source data, "six tables", NASIS, etc.
 
