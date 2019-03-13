# lab-data-delivery
Re-working the LDM + NASIS data integration process for snapshot and future web-service based delivery.



## Immediate tasks ##
 * confirm that each sub-query is in fact returning the requested analyte
 * optimize reshaping query as much as possible: indexing, CTE, temporary tables, reshape-then-filter, etc.
 * identify the magnitude and nature of "data quality" issues in each table
 * make decisions: NULL, truncate to range, etc.
 * finalize metadata: ranges, datatypes, column names, etc.


## Long-term tasks ##
 1. harmonization of morphologic data on LIMS side via NASIS data (?)
 2. synchronization of source data, "six tables", NASIS, etc.
 3. make snapshots viable for NASIS calculations (e.g. particle size estimator)--include Cathy Seybold in the next conf. call
 
