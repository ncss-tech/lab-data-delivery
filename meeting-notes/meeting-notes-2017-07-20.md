# 2017-07-20 Meeting Notes

Members present:

 * Kevin Godsey
 * Jason Nemecek
 * Rick Nesser
 * Jay Skovlin
 * Dylan Beaudette

## Action Items

 1. Rick gets access setup for team members
 2. ~~Dylan sends table results (access DB) to those who don't have it~~
 3. ~~Dylan will init a GitHub repository on ncss-tech and invite subteam members~~
 4. Jason / Adolfo write python to export CSV from FGDB
 5. ~~Dylan will ask Rick about table partitioning and indexing~~
 6. Everyone: pick a table to work on
 
## Topics ##

### Status of the "six tables" (Rick) ###
Some of the tables are ready to use, others are not due to long run times. Rick is willing to give access to the group (1) so that we can test query optimization strategies. Rick suggests updating vs. re-making the tables each release cycle. Dylan will send out access DB to Jason and Jay (2).

### Working environment ###
Sharepoint or GitHub? Going to try GitHub due to the text-based nature of these files and ability to move between revisions (3). Syntax highlighting might also be helpful.

### Open source version of morphologic tables ###
Jason and Adolfo will investigate some python code (4) that will help automate the process of creating and filling a companion SQLite database. This will help those users who aren't using or don't have access to ESRI tools. (See issues #1 and #2)

### Table review ###
The tables are large and the data complex, we need to divy up the work (6). So far:

 * chemical (Dylan)
 * physical
 * x-ray and thermal
 * mineralogy and glass counts
 * elements
 * calculations

I'll move this list to the GH repository, add your name when ready.
 

### Immediate tasks ###
 1. optimize reshaping queryies as much as possible
 2. identify the magnitude and nature of "data quality" issues in each table
 3. make decisions: NULL, truncate to range, etc.
 4. finalize metadata: ranges, datatypes, column names, etc.


### Long-term tasks ###
 1. harmonization of morphologic data on LIMS side via NASIS data (?)
 2. synchronization of source data, "six tables", NASIS, etc.
 

### Final thoughts ###
The group was interested in learning more about how the source (restult table) is indexed, and if [table partitioning](https://docs.microsoft.com/en-us/sql/relational-databases/partitions/partitioned-tables-and-indexes) can be used to improve performance.




