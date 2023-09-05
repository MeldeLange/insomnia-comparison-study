**Sensitivity Analysis - prescriptions - just a prescription for hypnotic before or on date of UK Biobank assessment.
**********************************************************************************************************************************

*1. Get date of UK Biobank assessment from main dataset ready to merge with prescriptions dataset.
*Open main dataset
use /mnt/project/pheno_primarycare12.dta, clear
set more off
describe // 163,748 vars: 56

*Just keep eid and date of UK Biobank assessment centre
keep eid date_assess
describe // 2 vars

*Save dataset 
save assessment_date.dta, replace
!dx upload assessment_date.dta

******************************************

*2. Prepare prescription cases dataset & merge with date of assessment centre datset.
*Open dataset already created that has just people in our study with a hypnotic prescription (ever). (long format)
use /mnt/project/pc_prescription_cases.dta, clear
set more off
describe // obs: 243,294. vars: 2 (eid, bnf_date)

*merge with date of assessment centre dataset
	*Master dataset: pc_prescription_cases(long format)
	*Using dataset: assessment_date (wide)
merge m:1 eid using /mnt/project/assessment_date.dta

*Result                           # of obs.
*    -----------------------------------------
*    not matched                       132,620
*        from master                         0  (_merge==1)
*        from using                    132,620  (_merge==2)
*
*    matched                           243,294  (_merge==3)
*    -----------------------------------------

*Rename merge variable
rename _merge _merge_date_assess

*Only keep those with prescriptions data (in pc_prescription_cases dataset)
keep if _merge_date_assess == 3 // 132,620 obs deleted

*Explore
describe // 243,294 obs. vars: 4. (eid, bnf_date, date_assess, _merge_date_assess)
ssc install unique
unique eid // eids: 31,128. 

*Save merged dataset
save prescriptions_assessment.dta
!dx upload prescriptions_assessment.dta

*Drop if bnf_date is after initial UK Biobank assessment centre date
drop if bnf_date > date_assess // 125,535 obs deleted.
unique eid // eids: 18,559. obs: 117,759.

*drop all variables apart from eid
keep eid
describe // vars: 1. obs: 117,759

*drop duplicate eids
duplicates drop // 99,200 obs deleted
describe // obs: 18,559. vars: 1
unique eid // 18,559

*Save & upload
save pc_prescriptioncases_eids.dta, replace
!dx upload pc_prescriptioncases_eids.dta

*************************************************

*3. Merge prescription cases with main dataset

*Open main dataset
use /mnt/project/pheno_primarycare12.dta, clear
set more off
describe // 163,748 obs. 56 vars.
ssc install unique 
unique eid // both obs & eid: 163,748.


*Merge main dataset (master) with prescription cases (list of eids for people with prescription before or on UKB assessment centre date) (using)
merge 1:1 eid using /mnt/project/pc_prescriptioncases_eids.dta

*Result                           # of obs.
*    -----------------------------------------
*    not matched                       145,189
*        from master                   145,189  (_merge==1)
*        from using                          0  (_merge==2)
*
*    matched                            18,559  (_merge==3)
*    -----------------------------------------

*Rename merge variable.
rename _merge _merge_prescriptions

describe

************************************
*3.Generate indicator variable based on merge

generate prescriptions_case =0
*Make it 1 if eid matches the prescriptions ever dataset
replace prescriptions_case=1 if _merge_prescriptions ==3 // 18,559 changes made.
*Label the variable
label variable prescriptions_case "Prescriptions insomnia case (hypnotic prescription ever) 1=Yes 0=No"
*Label the variable values
label define prescriptions_case_lb 1"Yes" 0 "No"
label values prescriptions_case prescriptions_case_lb
*Check looks ok
tab prescriptions_case, missing
codebook prescriptions_case

*Save & upload dataset as pheno_primarycare13
save pheno_primarycare13.dta, replace
!dx upload pheno_primarycare13.dta

******************************
*4. Run cross tabs of primary care insomnia prescription cases (hypnotic prescription ever) vs self-reported insomnia cases
****************************************************************************************************************************************
*Open dataset
use /mnt/project/pheno_primarycare13.dta, clear
set more off
describe // 


*Tabulate primary care insomnia cases (prescription ever) by self-reported insomnia cases
tab prescriptions_case sr_insomniacase, row col


