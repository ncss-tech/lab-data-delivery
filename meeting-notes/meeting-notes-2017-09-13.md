# 2017-09-13 Meeting Notes

Members present:

 * Kevin Godsey
 * Jason Nemecek
 * Rick Nesser
 * Jay Skovlin
 * Dylan Beaudette
 * Henry Ferguson
 * Shawn Salley

## Agenda

1. Regroup since last meeting; access to server in Lincoln
   * who has had a chance to tinker, thoughts?
2. Progress on FGDB -> text files -> SQLite process
   * data issues ([#5](https://github.com/ncss-tech/lab-data-delivery/issues/5), [#6](https://github.com/ncss-tech/lab-data-delivery/issues/6)) we are working on 
   * [notes on the current workflow and links to code](https://github.com/ncss-tech/lab-data-delivery/issues/2)

3. Discuss possible work-flow:
   * get access to server
   * re-write queries to run more efficiently (discuss)
   * double-check that the correct analytes are returned
   * create "6 tables" for data review
   * summary by column:
      + missing data: NULL, whitespace, 'NA', etc.
      + logical range: 0-100, 0-??, not-negative, etc.
      + oddities: "trace" quantities, corrupt field contents, etc.

   * make decisions on how to deal with above issues
      + enforce restricted table defs vs. iterative refinement of *strange* values
 
    * finish metadata, send to Susan in Ft. Worth
    * review and publish "6 tables"


## Discussion




## Action Items
 1. Dylan: document / distribute SQLite files for review
 2. Everyone: think about data "oddities" and reasonable solutions
     * each "oddity" can be described and discussed as an issue, here is the [first one](https://github.com/ncss-tech/lab-data-delivery/issues/9)
     * search for these issues [like this](https://github.com/ncss-tech/lab-data-delivery/labels/data%20error)
     * tag new issues with the "data error" label
 3. Everyone: adopt a table and get familiar with the [metadata](https://github.com/ncss-tech/lab-data-delivery/tree/master/tables/_metadata) and text export (see next item)
 4. Jason: distribute textfile exports from all table via cloudvault or similar
 5. Rick: continue checking that analyte codes are correct and report back when updated queries are ready
 6. Rick: add comments to queries so that the rest of us have an idea of the original intent
 


## For Next Time
 * snapshot cycle?
 * should the web-service use a snapshot (tables) or be live (views)... indexing / efficiency?
 * essential to sort-out linkages between lab characterization *and* morphologic data ([for example](https://github.com/ncss-tech/lab-data-delivery/issues/8))
 * there needs to be pedon "check" reports, similar to the effort placed on DMU/component records
 * what about the RaCA pedons / data? are they included in the current snapshot or 6 tables?
 
 
 
 

