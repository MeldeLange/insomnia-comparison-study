**Sensitivity Analysis - prescriptions - read code in 4 weeks prior to initial UKB assessment centre & bnf code within 90 days of read code
**********************************************************************************************************************************

*Only keep observations where read code is in the 4 weeks perior to the initial UKB assessment centre visit & bnf_date is within 90 days of read code event_date
***************************************************************************************************************************************************************

*1. Create dataset (including event dates) for those with read code 4 weeks prior to initial UKB assessment.
*************************************************************************************************************

*Open primary care insomnia cases dataset. **This includes people without self-report data who are not included in our study but main dataset & prescriptions dataset don't so can remove when merge.
use /mnt/project/primarycare_insomnia_cases.dta, clear
set more off
describe //obs: 17,251. vars: 125 (eid, read_code, event_date, reg_date1-60, deduct_date1-60 )
ssc install unique
unique eid // 9,862.

*Create variable for the date of four weeks before UKB asessment date & only keep observations where event_date is after this.
generate fourweeks=date_assess-28
describe
list fourweeks date_assess in 1/5
keep if event_date >= fourweeks & event_date <= date_assess // 17,037 obs deleted
list event_date date_assess in 1/10
unique eid // obs: 214. unique eid: 199.


*Drop any variables we don't need.Just need eid and event_date.
keep eid event_date
describe // obs: 214. vars: 2

*Generate eventno variable to use when reshaping data
sort eid event_date
list in 1/10
egen eventno = seq(), by (eid)
list in 1/10


*Reshape from long to wide
reshape wide event_date, i(eid) j(eventno) // j = 1-3


*Check looks ok.
describe 
unique eid 
list in 1/5

*Save & upload ready to merge with pc_prescription_cases
save pc_insomniacase_fourweeks_eid_eventdate_wide.dta, replace
!dx upload pc_insomniacase_fourweeks_eid_eventdate_wide.dta

**************************************************************************

*2. Merge primary care insomnia (read code 4 weeks) cases dataset with prescription insomnia cases dataset
*****************************************************************************************************
*Master dataset: pc_prescription_cases.dta (long format: eid, bnf_date: unique eids: 31,128 obs: 243,294 )
*Using dataset: pc_insomniacase_fourweeks_eid_eventdate_wide.dta (wide format: eid, event_date*:  obs & unique eids)


*Open primary care prescription cases dataset.
use /mnt/project/pc_prescription_cases.dta, clear
set more off
describe // vars: 2 (eid, bnf_date). obs: 243,294.
ssc install unique
unique eid // long format: unique eid: 31,128. Obs: 243,294
compress // compress dataset to see if we can reduce amount of memory used by the data. //variable bnf_date was float now int   (486,588 bytes saved) 

*Merge with primary care 4 weeks insomnia cases dataset.
merge m:1 eid using /mnt/project/pc_insomniacase_fourweeks_eid_eventdate_wide.dta

*Result                           # of obs.
*    -----------------------------------------
*    not matched                       241,898
*        from master                   241,819  (_merge==1)
*        from using                         79  (_merge==2)
*
*    matched                             1,475  (_merge==3)
*    -----------------------------------------

*Rename merge variable
rename _merge _merge_bnf_readfour


*Explore merged dataset
describe // obs:243,373  vars: 6. eid, bnf_date, event_date1-3, _merge_bnf_readfour
unique eid if _merge_bnf_readfour ==3 // obs:1475 unique eid: 120. Have read code 4 weeks & prescription.
unique eid if _merge_bnf_readfour ==1 // obs: 24,1819   Unique eid: 31,008 Have prescription but no read code 4 weeks.
unique eid if _merge_bnf_readfour ==2 // obs & unique eid: 79. Have read code 4 weeks but no prescription. (some of these will be people without self-report data not included in study)

*Keep only observations which are an insomnia case: read code in 4 weeks prior to UKB initial assessment & have a prescription (ever)
keep if _merge_bnf_readfour ==3 // 241,898 obs deleted.
describe   // obs: 1475. vars: 6.
unique eid // 120.

*Drop merge variable: Leaves us with eid, event_date1-3, bnf_date
drop _merge_bnf_readfour
describe obs // 1475. vars: 5.

*Save & upload dataset of people with both a read code 4 weeks & a prescription ever
save prescriptions_insomniacases_four_matches.dta, replace
!dx upload prescriptions_insomniacases_four_matches.dta

****************************************************************************************


****************************************************************************************

*3. Only keep observations if bnf_date is within 90 days either side of event date.
*************************************************************************************

*Open dataset of people with both a read code 4 weeks & a prescription 
use /mnt/project/prescriptions_insomniacases_four_matches.dta, clear
set more off
describe 


***Loop through each event date to create date of 90 days before and 90 days after.
foreach num of numlist 1/3{
generate ninetybefore`num' = event_date`num' - 90
generate ninetyafter`num' = event_date`num' + 90
}

list in 1/1
list in 2/2

*Loop to create an eligible flag variable for each event date
foreach num of numlist 1/3{
generate eligible`num'=0
}

list in 1/1

*Replace each eligible flag with 1 if the bnf_date is within 90 days of that event date.
foreach num of numlist 1/3{
replace eligible`num'=1 if bnf_date>= ninetybefore`num' & bnf_date <= ninetyafter`num'
}


*Loop to create flag variable if any of the eligible flags is 1.
generate totaleligible=0
foreach num of numlist 1/3{
replace totaleligible=1 if eligible`num'==1		
}



*Explore those with a bnf date within 90 days of any read code event
count if totaleligible==1 // 119 obs
ssc install unique
unique eid if totaleligible==1 // unique eids: 51.


****************

*Only keep those who have a bnf date within 90 days of any read code event
keep if totaleligible==1 // 1,356 obs deleted.
describe // obs: 19. Vars: 15.
unique eid // 51.

*drop all variable apart from eid
keep eid
describe // obs: 119. var: 1.

*drop duplicate eids
duplicates drop // 68 obs deleted.
describe // obs: 51. vars: 1
unique eid // 51

* Save dataset as pc_insomniacase_read_four_bnf (just a list of eids of those with a prescription within 90 days of a read code event 4 weeks prior to UkB initial assessment centre)
save pc_insomniacase_read_four_bnf.dta, replace
!dx upload pc_insomniacase_read_four_bnf.dta

*****************************************************************************************

*****************************************************************************************************
*4. Merge list of eids of those with read code 4 wks prior to initial UKB assessment centre & bnf code within 90 days, with current main dataset: pheno_primarycare11.dta
******************************************************************************************************************************

*Open main dataset
use /mnt/project/pheno_primarycare11.dta, clear
set more off
describe // obs: 163,748. vars: 54.
ssc install unique
unique eid // obs & unique eids: 163,748. == wide format.


*Merge main dataset (master) with pc insomnia cases 4 weeks (list of eids for people with read code 4 weeks pre UKB assessment centre & prescription within 90 days) (using)
merge 1:1 eid using /mnt/project/pc_insomniacase_read_four_bnf.dta

*Result                           # of obs.
*    -----------------------------------------
*    not matched                       163,697
*        from master                   163,697  (_merge==1)
*        from using                          0  (_merge==2)
*
*    matched                                51  (_merge==3)
*    -----------------------------------------



*Rename merge variable.
rename _merge _merge_read_four_bnf


*Generate indicator variable for read_four_bnf case using merge variable
generate read_four_bnf_case =0
*Make it 1 if eid matches the read four bnf dataset
replace read_four_bnf_case=1 if _merge_read_four_bnf ==3 // 51 changes made.
*Label the variable
label variable read_four_bnf_case "PC insomnia case (read 4wks + bnf within 90 days) 1=Yes 0=No"
*Label the variable values
label define read_four_bnf_case_lb 1"Yes" 0 "No"
label values read_four_bnf_case read_four_bnf_case_lb
*Check looks ok
tab read_four_bnf_case, missing
codebook read_four_bnf_case


*Save & upload dataset as pheno_primarycare12
save pheno_primarycare12.dta, replace
!dx upload pheno_primarycare12.dta


*************************************************************************************************

*5. Run cross tabs of primary care insomnia cases (read code in 4 weeks prior to UKB initial assessment centre & bnf code within 90 days) vs self-reported insomnia cases
****************************************************************************************************************************************
*Open dataset
use /mnt/project/pheno_primarycare12.dta, clear
set more off
describe 

*Tabulate primary care insomnia cases (read code in 4 weeks prior to UKB assess & bnf code within 90 days) by self-reported insomnia cases
tab read_four_bnf_case sr_insomniacase, row col

**********************************************************************************************************
**********************************************************************************************************

