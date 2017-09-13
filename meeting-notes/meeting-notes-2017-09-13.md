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

4. anything else?


## Action Items


## Discussion





