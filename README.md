# NSW Crime Data Analysis

This is a short project where I analyse the NSW Bureau of Crime Statistics and Research (BOCSAR) data using SQL on Google's BigQuery. This repo contains all the SQL queries I used and the script which I used to clean the data. 

This project uses three datasets:
- [NSW BOCSAR crime incident data ](https://csi.nsw.gov.au/content/dcj/bocsar/bocsar-home/statistics-dashboards/open-datasets/criminal-offences-data.html)
- [ABS population data](https://www.abs.gov.au/statistics/people/population/regional-population/latest-release#data-downloads)
- [Socio-economic Index for Area (SEIFA) data](https://www.abs.gov.au/statistics/people/people-and-communities/socio-economic-indexes-areas-seifa-australia/latest-release#data-downloads)

## SQL Queries

I will describe below what each SQL query is trying to do.


### create_lookup_table

This creates a lookup table which links the local goverment area codes with the names used by the ABS and BOSCAR.

### annual_rates

This calculates the annual rate of incidents for each offence category in each area. The annual rate is given as the number of incidents and the rate per 100k people. 


### highest_rate_per_offence

This query ranks the area with the highest number of incidents for each category.  

### rise_fall_offences

This query calculates the percentage change in incidents compared to the start of the data which I defined as 2016.

### streak_months

This query works out which suburb has an increase in incidents for a particular offence for consecutive months.