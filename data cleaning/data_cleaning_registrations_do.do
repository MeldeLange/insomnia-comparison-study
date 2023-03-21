*DATA CLEANING - PRIMARY CARE REGISTRATION/DEDUCTION DATA
************************************************************

*Import primary care registrations/deductions csv file
import delimited /mnt/project/primarycare_registrations.csv, clear
describe //634,928 obs
list in 1/5
*Variables: eid, reg_date, deduct_date, data_provider

*Save phenotype data as stata .dta file
save primarycare_registrations, replace

*Upload saved .dta file to project in DNA Nexus
!dx upload primarycare_registrations.dta


*************************************************************************************
**************************************************************************************
***Need to go out of JupyterLab and then back in again to use .dta file saved in DNA Nexus project

*Install unique
ssc install unique

*Open registration/deduction data
use /mnt/project/primarycare_registrations.dta, clear
describe
list in 1/5

*Drop all observations that don't have England-TPP as the data provider
unique eid //Number of unique eids: 502,387. Number of unique records: 634,928
keep if data_provider == 3 //388,694 observations deleted
count //246,234
unique eid // number of unique eids: 164,190. number of unique records: 246,234
drop data_provider


*Convert registration date and deduction date from string to stata elapsed date format
generate reg_date_stata = date(reg_date, "YMD") //7 missing values generated
generate deduct_date_stata = date(deduct_date, "YMD") //145,493 missing values generated
list eid reg_date reg_date_stata deduct_date deduct_date_stata in 1/5
	*Make elapsed date readable
	format reg_date_stata %d
	format deduct_date_stata %d
	list eid reg_date reg_date_stata deduct_date deduct_date_stata in 1/5

*Rename data variables back to original format
drop reg_date
drop deduct_date
rename reg_date_stata reg_date
rename deduct_date_stata deduct_date
list in 1/5

*Count how many observations are missing registration/deduction data
count if reg_date ==. //7 
count if deduct_date ==. //145,493

*Count how many individual people are missing registration data
unique eid if reg_date ==. //unique values of eid:6. Unique number of records: 7
unique eid if deduct_date ==. //unique values of eid: 141,492. Unique number of records: 145,493

*Drop those without registration date
unique eid // unique eid: 164,190. unique records: 246234
drop if reg_date ==. //7 observations deleted
unique eid if reg_date ==. // eid & observations: 0
unique eid // number of unique eid: 164,184. number of records: 246,227.


*Temporarliy replace missing deduction dates with current date (so that, once I've merged the primary care event and registration data I can delete events not within the registration periods to cut down the dataset)
*Once I've merged the primary care data with the pheno data I will then be deleting any events after the date of assessment centre visit anyway.
count if deduct_date ==. //145,487
list eid deduct_date in 1/10
replace deduct_date=mdy(3,21,2023) if deduct_date ==. //145,487 changes made.
list eid deduct_date in 1/10
count if deduct_date ==. //0

*Generate eventno variable to use when reshaping data
sort eid reg_date
list in 1/20
egen eventno = seq(), by (eid)
list in 1/10


*Reshape from long to wide format
reshape wide reg_date deduct_date, i(eid) j(eventno)
list in 1/5 //**the max no of registrations/deductions is 60.
set more off
describe //obs: 164,184: 121 vars.

*Count number of unique eids
unique eid // Unique values of eid:164184 . Number of records: 164184

*Save registration/deduction data ready to merge with primarycare events data
save pc_regs_wide.dta, replace

*Upload to DNA Nexus repository
!dx upload pc_regs_wide.dta



