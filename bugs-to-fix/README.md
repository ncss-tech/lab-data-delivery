# Bugs to Fix

## Encoding of Dates
 
  * dates are mangled (appear as integers) in lab_pedon and lab_combine_nasis_ncss (SQLite snapshot), and lab_pedon (SDA)

## User Pedon/Site ID

  * the field "user_pedon_id" in lab_pedon appears to be *a user pedon ID*, but the field name doesn't match other instances
  * the field "upedonid" in lab_combine_nasis_ncss appears to be a *user site ID*
  
  
