*DATA CLEANING - PRIMARY CARE REGISTRATION/DEDUCTION DATA
************************************************************

*Import primary care registrations/deductions csv file
import delimited /mnt/project/primarycare_registrations.csv, clear
describe
list in 1/5

*Save phenotype data as stata .dta file
save primarycare_registrations

*Upload saved .dta file to project in DNA Nexus
!dx upload primarycare_registrations.dta


*************************************************************************************
**************************************************************************************
***Need to go out of JupyterLab and then back in again to use .dta file saved in DNA Nexus project



*Open registration/deduction data
use /mnt/project/primarycare_registrations.dta, clear
describe
list in 1/5

*Drop all observations that don't have England-TPP as the data provider
***Didn't do this - don't have data provider in dataset as will merge with pc event data that has been cut down to 
*just event provider 3 (TPP)
*keep if data_provider == //Need to check value of TPP. 3?
*drop data_provider

*Convert registration date and deduction date from string to stata elapsed date format
generate reg_date_stata = date(reg_date, "YMD")
generate deduct_date_stata = date(deduct_date, "YMD")
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


*Generate eventno variable to use when reshaping data
sort eid reg_date
list in 1/20
egen eventno = seq(), by (eid)
list in 1/10


*Reshape from long to wide format
reshape wide reg_date deduct_date, i(eid) j(eventno)
list in 1/5
describe

*Save registration/deduction data ready to merge with primarycare events data
save pc_regs_wide.dta, replace

*Upload to DNA Nexus repository
!dx upload pc_regs_wide.dta

