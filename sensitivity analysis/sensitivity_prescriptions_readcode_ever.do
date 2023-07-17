**Sensitivity Analysis - prescriptions - read code ever & bnf code within 90 days of read code
*********************************************************************************************

*Only keep observations where bnf_date is within 90 days of read code event_date
*********************************************************************************************


*1. Reshape primarycare_insomnia_cases from long to wide format ready to merge with pc_prescription_cases.dta

**********************************************************************************************


*Open primarycare insomnia cases (event data for those with an insomnia read code)
*Long format: obs: 17,251. unique eid: 9,862. *Will include people without self-report data who are not included in the study.


use /mnt/project/primarycare_insomnia_cases.dta, clear
set more off
describe 
ssc install unique
unique eid // obs: 17,251. unique eid: 9,862.

*Drop any variables we don't need.Just need eid  and event_date.
keep eid event_date
describe // obs: 17,251. vars: 2

*Save as separate dataset:  pc_insomniacase_eid_eventdate (2 vars: eid, event_date)
save pc_insomniacase_eid_eventdate.dta, replace
!dx upload pc_insomniacase_eid_eventdate.dta.dta

****************************************************************************************
*Go out of DNA Nexus & back in again...

*Open dataset
use /mnt/project/pc_insomniacase_eid_eventdate.dta, clear
set more off
describe 

*Generate eventno variable to use when reshaping data
sort eid event_date
list in 1/10
egen eventno = seq(), by (eid)
list in 1/10


*Reshape from long to wide
reshape wide event_date, i(eid) j(eventno) // j goes up to 51.


*Check looks ok.
describe // obs: 9,862. Vars: 52 (eid and event_date1-51)
ssc install unique
unique eid // unique eid: 9,862.
list in 1/5

*Save & upload ready to merge with pc_prescription_cases
save pc_insomniacase_eid_eventdate_wide.dta, replace
!dx upload pc_insomniacase_eid_eventdate_wide.dta

**********************************************************************************************************
***********************************************************************************************************

*2. Merge primary care insomna (read code) cases dataset with prescription insomnia cases dataset
*****************************************************************************************************
*Master dataset: pc_prescription_cases.dta (long format: eid, bnf_date: unique eids: 31,128 obs: 243,294 )
*Using dataset: pc_insomniacase_eid_eventdate_wide.dta (wide format: eid, event_date1-51: 9,862 obs & unique eids)


*Open primary care prescription cases dataset.
use /mnt/project/pc_prescription_cases.dta, clear
set more off
describe // vars: 2 (eid, bnf_date). obs: 243,294.
ssc install unique
unique eid // long format: unique eid: 31128. Obs: 243,294
compress // compress dataset to see if we can reduce amount of memory used by the data. //variable bnf_date was float now int   (486,588 bytes saved) 

*Merge with primary care insomnia cases dataset.
merge m:1 eid using /mnt/project/pc_insomniacase_eid_eventdate_wide.dta



* Result                           # of obs.
*    -----------------------------------------
*    not matched                       169,934
*        from master                   165,460  (_merge==1)
*        from using                      4,474  (_merge==2)
*
*    matched                            77,834  (_merge==3)
*    -----------------------------------------


*Rename merge variable
rename _merge _merge_bnf_read


*Explore merged dataset
describe
unique eid if _merge_bnf_read ==3 // obs: 77,834. unique eid: 5388. = People who have both a read code & a prescription for insomnia.
unique eid if _merge_bnf_read ==1 // obs: 165,460. unique eid: 25740 = People who have a prescription but not a read code for insomnia. 
unique eid if _merge_bnf_read ==2 // obs: 4474. unique eid: 4474. = People have have a read code but not a prescription for insomnia.

*Keep only observations which are an insomnia case (read code ever) & have a prescription (ever)
keep if _merge_bnf_read ==3 //169,934 obs deleted
describe //  obs: 77,834. vars: 54
unique eid //unique eid: 5388. = People who have both a read code & a prescription for insomnia. 

*Drop merge variable: Leaves us with eid, event_date1-51, bnf_date
drop _merge_bnf_read
describe // vars 53.


*Save & upload dataset of people with both a read code & a prescription ever
save prescriptions_insomniacases_matches.dta, replace
!dx upload prescriptions_insomniacases_matches.dta

****************************************************************************************
****************************************************************************************

*3. Only keep observations if bnf_date is within 90 days either side of event date.
*************************************************************************************

*Open dataset of people with both a read code & a prescription 
use /mnt/project/prescriptions_insomniacases_matches.dta, clear
set more off
describe // obs: 77,834/ vars: 53: eid, bnf_date, event_date1-51

***Loop through each event date to create date of 90 days before and 90 days after.
foreach num of numlist 1/51{
generate ninetybefore`num' = event_date`num' - 90
generate ninetyafter`num' = event_date`num' + 90
}

list in 1/1
list in 2/2

*Loop to create an eligible flag variable for each event date
foreach num of numlist 1/51{
generate eligible`num'=0
}

list in 1/1

*Replace each eligible flag with 1 if the bnf_date is within 90 days of that event date.
foreach num of numlist 1/51{
replace eligible`num'=1 if bnf_date>= ninetybefore`num' & bnf_date <= ninetyafter`num'
}


*Loop to create flag variable if any of the eligible flags is 1.
generate totaleligible=0
foreach num of numlist 1/51{
replace totaleligible=1 if eligible`num'==1		
}



*Explore those with a bnf date within 90 days of any read code event
count if totaleligible==1 //8,059
ssc install unique
unique eid if totaleligible==1 //3,023 unique eids.


*Only keep those who have a bnf date within 90 days of any read code event
keep if totaleligible==1 //69,775 obs deleted
describe // 8,059 obs. 207 vars.
unique eid //3,023

*drop all variable apart from eid
keep eid
describe // obs: 8,059. vars: 1

*drop duplicate eids
duplicates drop //5,036 obs deleted.
describe // obs: 3,023. vars: 1
unique eid // 3,023.

* Save dataset as pc_insomniacase_read_ever_bnf (just a list of eids of thos with a prescription within 90 days of a read code event)
save pc_insomniacase_read_ever_bnf.dta, replace
!dx upload pc_insomniacase_read_ever_bnf.dta


*****************************************************************************************************
*4. Merge list of eids of those with read code ever & bnf code within 90 days, with current main dataset: pheno_primarycare9.dta
******************************************************************************************************************************

*Open main dataset
use /mnt/project/pheno_primarycare9.dta, clear
set more off
describe //obs: 163,748. Vars: 50
ssc install unique 
unique eid // obs & unique eids: 163,748. == wide format.


*Merge main dataset (master) with pc insomnia cases (list of eids for people with read code ever & prescription within 90 days) (using)
merge 1:1 eid using /mnt/project/pc_insomniacase_read_ever_bnf.dta


*Result                           # of obs.
*    -----------------------------------------
*    not matched                       160,725
*        from master                   160,725  (_merge==1)
*        from using                          0  (_merge==2)
*
*    matched                             3,023  (_merge==3)
*    -----------------------------------------

*Rename merge variable.
rename _merge _merge_read_ever_bnf



*Generate indicator variable for read_ever_bnf case using merge variable
generate read_ever_bnf_case =0
*Make it 1 if eid matches the read ever bnf dataset
replace read_ever_bnf_case=1 if _merge_read_ever_bnf ==3
*Label the variable
label variable read_ever_bnf_case "PC insomnia case (ever read code + bnf within 90 days) 1=Yes 0=No"
*Label the variable values
label define read_ever_bnf_case_lb 1"Yes" 0 "No"
label values read_ever_bnf_case read_ever_bnf_case_lb
*Check looks ok
tab read_ever_bnf_case, missing //1.85% of our sample have a read code ever & prescription within 90 days.
codebook read_ever_bnf_case


*Save & upload dataset as pheno_primarycare10
save pheno_primarycare10.dta, replace
!dx upload pheno_primarycare10.dta


*************************************************************************************************

*5. Run cross tabs of primary care insomnia cases (read code ever & bnf code within 90 days) vs self-reported insomnia cases
****************************************************************************************
*Open dataset
use /mnt/project/pheno_primarycare10.dta, clear
set more off
describe // obs: 163,748. Vars: 52

*Tabulate primary care insomnia cases (read code ever & bnf code within 90 days) by self-reported insomnia cases
tab read_ever_bnf_case sr_insomniacase, row col

**********************************************************************************************************
**********************************************************************************************************