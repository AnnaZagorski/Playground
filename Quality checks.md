# Ideas for quality checks on the ePRTR data

These checks should run before submitting the data under the LRTAP convention:

* Total lps emssions < national total
* All releases to compartment air for given year inculded in output.csv
* unit mistakes
* not empty: IDs, stack height, GNFR, coordinates
* at least one pollutant given for each lps
* coordinates inside German borders
* combination of coordinates unique
* Sanitize plant names
* TSP > PM10 >PM2.5 >BC
* PM > HM

See NECD review results 2020 for more ideas!