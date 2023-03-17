*DATA CLEANING - PRIMARY CARE EVENT DATA
************************************************************

*Import primary care events csv file
import delimited /mnt/project/primarycare_events.csv, clear
describe
list in 1/5

*Save phenotype data as stata .dta file
save primarycare_events

*Upload saved .dta file to project in DNA Nexus
!dx upload primarycare_events.dta


*************************************************************************************
**************************************************************************************
***Need to go out of JupyterLab and then back in again to use .dta file saved in DNA Nexus project


*Open primary care event data
use /mnt/project/primarycare_events.dta, clear
describe
list in 1/5

*Rename read code variable
rename read_3 read_code
list in 1/5

*Drop all observations that don't have England-TPP as the data provider
count //123,908,327
tab data_provider
codebook data_provider
keep if data_provider == 3 //36,440,139 observations deleted
count //87,468,188
list in 1/5
drop data_provider
list in 1/5


*Convert event date from string to stata elapsed date format
generate event_date_stata = date(event_dt, "YMD")
list eid event_dt event_date_stata in 1/5

*Make elapsed date readable
	format event_date_stata %d
	list eid event_dt event_date_stata in 1/5

*Rename data variables back to original format
drop event_dt
rename event_date_stata event_date
list in 1/5
describe

*Save primary care event data (long format) ready to merge with primary care registrations/deductions data (wide format)
save pc_events_cleaned.dta, replace

*Upload to DNA Nexus repository
!dx upload pc_events_cleaned.dta

*See how many eids we have
unique eid //No of unique values: 165145. No of records is 87,468,188

