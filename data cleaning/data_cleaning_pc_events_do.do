*DATA CLEANING - PRIMARY CARE EVENT DATA
************************************************************

*Open primary care event data
use primarycare_events.dta, clear
describe
list in 1/5

*Rename read code variable so numbering doesn't get confused when reshaped
rename read_3 read_code

*Drop all observations that don't have England-TPP as the data provider
keep if data_provider == //Need to check value of TPP. 3?
drop data_provider

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


*Generate eventno variable to use when reshaping data
sort eid event_date read_code
list in 1/5
egen eventno = seq(), by (eid)



*Reshape from long to wide format
reshape wide event_date read_code, i(eid) j(eventno)
list in 1/5


*Save primary care event data ready to merge with primary care registrations/deductions data
save pc_events_wide.dta, replace

*Upload to DNA Nexus repository
!dx upload pc_events_wide.dta

