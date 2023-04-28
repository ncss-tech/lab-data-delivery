# Bugs to Fix

## Encoding of Dates
 
  * dates are mangled (appear as integers) in lab_pedon and lab_combine_nasis_ncss (SQLite snapshot), and lab_pedon (SDA)

## User Pedon/Site ID

  * the field "user_pedon_id" in lab_pedon appears to be *a user pedon ID*, but the field name doesn't match other instances
  * the field "upedonid" in lab_combine_nasis_ncss appears to be a *user site ID*
  
  
## Pedon / Site records

  * The lab_site table has 129650 observation each with a unique site_key. The lab_pedon table only has 67384 observations. The extra lab_site observations appear to be due to replicate entries that differ in the decimal degree fields.
  
  
## internal IDs

  * use `labsampnum` in all tables where possible (rosetta table?)
  
  
# Documentation

# compact MIR data?

