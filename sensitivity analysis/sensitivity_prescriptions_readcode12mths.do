**Sensitivity Analysis - prescriptions - read code in 12 months prior to initial UKB assessment centre & bnf code within 90 days of read code
**********************************************************************************************************************************

*Only keep observations where read code is in the 12 months perior to the initial UKB assessment centre visit & bnf_date is within 90 days of read code event_date
***************************************************************************************************************************************************************

*1. Create dataset (including event dates) for those with read code 12 mths prior to initial UKB assessment.
*************************************************************************************************************

*Open primary care insomnia cases dataset. **This includes people without self-report data who are not included in our study but main dataset & prescriptions dataset don't so can remove when merge.
use /mnt/project/primarycare_insomnia_cases.dta, clear
describe //obs: 17,251. vars: 125 (eid, read_code, event_date, reg_date1-60, deduct_date1-60 )
ssc install unique
unique eid // 9,862.



*Create variable for the date of 12 months (365.25 days) before UKB asessment date & only keep observations where event_date is after this.
generate twelvemonths = date_assess-365.25
describe
keep if event_date  >= twelvemonths & event_date <= date_assess // 14,787 obs deleted.
list event_date date_assess in 1/10
describe // obs: 2464. vars: 126.
unique eid // obs: 2464. unique eids: 1920. 


*Drop any variables we don't need.Just need eid and event_date.
keep eid event_date
describe // obs: 2,464. vars: 2.

*Generate eventno variable to use when reshaping data
sort eid event_date
list in 1/10
egen eventno = seq(), by (eid)
list in 1/10


*Reshape from long to wide 
reshape wide event_date, i(eid) j(eventno) // j=1-9


*Check looks ok.
describe // obs: 1,920. Vars: 10 (eid and event_date1-9)
unique eid // unique eid:1920
list in 1/5

*Save & upload ready to merge with pc_prescription_cases
save pc_insomniacase_twelvemonths_eid_eventdate_wide.dta, replace
!dx upload pc_insomniacase_twelvemonths_eid_eventdate_wide.dta

**************************************************************************


*2. Merge primary care insomnia (read code 12 mths) cases dataset with prescription insomnia cases dataset
*****************************************************************************************************
*Master dataset: pc_prescription_cases.dta (long format: eid, bnf_date: unique eids: 31,128 obs: 243,294 )
*Using dataset: pc_insomniacase_twelve-months_eid_eventdate_wide.dta (wide format: eid, event_date1-9: 1920 obs & unique eids)


*Open primary care prescription cases dataset.
use /mnt/project/pc_prescription_cases.dta, clear
set more off
describe // vars: 2 (eid, bnf_date). obs: 243,294.
ssc install unique
unique eid // long format: unique eid: 31,128. Obs: 243,294
compress // compress dataset to see if we can reduce amount of memory used by the data. //variable bnf_date was float now int   (486,588 bytes saved) 

*Merge with primary care 12 months insomnia cases dataset.
merge m:1 eid using /mnt/project/pc_insomniacase_twelvemonths_eid_eventdate_wide.dta

*  Result                           # of obs.
*    -----------------------------------------
*    not matched                       227,485
*        from master                   226,657  (_merge==1)
*        from using                        828  (_merge==2)
*
*    matched                            16,637  (_merge==3)
*    -----------------------------------------


*Rename merge variable
rename _merge _merge_bnf_readtwelve


*Explore merged dataset
describe // obs: 244,122. vars: 12. eid, bnf_date, event_date1-9
unique eid if _merge_bnf_readtwelve ==3 // obs: 16,637. unique eid: 1092. Have read code 12 mths & prescription.
unique eid if _merge_bnf_readtwelve ==1 // obs: 226,657. Unique eid: 30,036. Have prescription but no read code 12 mths.
unique eid if _merge_bnf_readtwelve ==2 // obs & unique eid: 828. Have read code 12 mths but no prescription. (some of these will be people without self-report data not included in study)

*Keep only observations which are an insomnia case: read code in 12 months prior to UKB initial assessment & have a prescription (ever)
keep if _merge_bnf_readtwelve ==3 //227,485 obs deleted.
describe   // obs: 16,637. vars: 12. eid, bnf_date, event_date1-9, _merge_bnf_readtwelve
unique eid // obs: 1,637. Unique eid: 1092.

*Drop merge variable: Leaves us with eid, event_date1-9, bnf_date
drop _merge_bnf_readtwelve
describe // vars: 11.

*Save & upload dataset of people with both a read code 12 mths & a prescription ever
save prescriptions_insomniacases_twelve_matches.dta, replace
!dx upload prescriptions_insomniacases_twelve_matches.dta

****************************************************************************************


****************************************************************************************

*3. Only keep observations if bnf_date is within 90 days either side of event date.
*************************************************************************************

*Open dataset of people with both a read code 12 mths & a prescription 
use /mnt/project/prescriptions_insomniacases_twelve_matches.dta, clear
set more off
describe //  obs: 16,637. vars: 11 (eid, event_date1-9, bnf_date)

***Loop through each event date to create date of 90 days before and 90 days after.
foreach num of numlist 1/9{
generate ninetybefore`num' = event_date`num' - 90
generate ninetyafter`num' = event_date`num' + 90
}

list in 1/1
list in 2/2

*Loop to create an eligible flag variable for each event date
foreach num of numlist 1/9{
generate eligible`num'=0
}

list in 1/1

*Replace each eligible flag with 1 if the bnf_date is within 90 days of that event date.
foreach num of numlist 1/9{
replace eligible`num'=1 if bnf_date>= ninetybefore`num' & bnf_date <= ninetyafter`num'
}


*Loop to create flag variable if any of the eligible flags is 1.
generate totaleligible=0
foreach num of numlist 1/9{
replace totaleligible=1 if eligible`num'==1		
}



*Explore those with a bnf date within 90 days of any read code event
count if totaleligible==1 // 1,196 obs.
ssc install unique
unique eid if totaleligible==1 // unique eids: 543.


****************

*Only keep those who have a bnf date within 90 days of any read code event
keep if totaleligible==1 // 15,441 obs deleted
describe // obs: 1,196. Vars: 39.
unique eid // 543

*drop all variable apart from eid
keep eid
describe // obs: 1,196. Vars: 1.

*drop duplicate eids
duplicates drop // 653 obs deleted.
describe // obs: 543. vars: 1
unique eid // unique eid: 543.

* Save dataset as pc_insomniacase_read_twelve_bnf (just a list of eids of those with a prescription within 90 days of a read code event 12 mths prior to UkB initial assessment centre)
save pc_insomniacase_read_twelve_bnf.dta, replace
!dx upload pc_insomniacase_read_twelve_bnf.dta

*****************************************************************************************

*****************************************************************************************************
*4. Merge list of eids of those with read code ever & bnf code within 90 days, with current main dataset: pheno_primarycare10.dta
******************************************************************************************************************************

*Open main dataset
use /mnt/project/pheno_primarycare10.dta, clear
set more off
describe // obs: 163,748. vars: 52.
ssc install unique 
unique eid // obs & unique eids: 163,748. == wide format.


*Merge main dataset (master) with pc insomnia cases 12 mths (list of eids for people with read code 12 mths pre UKB assessment centre & prescription within 90 days) (using)
merge 1:1 eid using /mnt/project/pc_insomniacase_read_twelve_bnf.dta

*Rename merge variable.
rename _merge _merge_read_twelve_bnf

*  Result                           # of obs.
*    -----------------------------------------
*    not matched                       163,205
*        from master                   163,205  (_merge==1)
*        from using                          0  (_merge==2)
*
*    matched                               543  (_merge==3)
*    -----------------------------------------

*Generate indicator variable for read_ever_bnf case using merge variable
generate read_twelve_bnf_case =0
*Make it 1 if eid matches the read ever bnf dataset
replace read_twelve_bnf_case=1 if _merge_read_twelve_bnf ==3 // 543 changes made.
*Label the variable
label variable read_twelve_bnf_case "PC insomnia case (read 12mths + bnf within 90 days) 1=Yes 0=No"
*Label the variable values
label define read_twelve_bnf_case_lb 1"Yes" 0 "No"
label values read_twelve_bnf_case read_twelve_bnf_case_lb
*Check looks ok
tab read_twelve_bnf_case, missing
codebook read_twelve_bnf_case


*Save & upload dataset as pheno_primarycare11
save pheno_primarycare11.dta, replace
!dx upload pheno_primarycare11.dta


*************************************************************************************************

*5. Run cross tabs of primary care insomnia cases (read code in 12 months prior to UKB initial assessment centre & bnf code within 90 days) vs self-reported insomnia cases
****************************************************************************************************************************************
*Open dataset
use /mnt/project/pheno_primarycare11.dta, clear
set more off
describe // obs: 163,748. vars: 54.

*Tabulate primary care insomnia cases (read code in 12 months prior to UKB assess & bnf code within 90 days) by self-reported insomnia cases
tab read_twelve_bnf_case sr_insomniacase, row col

**********************************************************************************************************
**********************************************************************************************************

