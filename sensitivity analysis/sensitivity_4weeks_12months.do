*Sensitivity analysis - primary care insomnia case = read code in the 4 weeks or 12 months prior to UKB asessment 
******************************************************************************************************************

*1. Create dataset of just those with primary care event in the 4 weeks prior to initial UKB assessment centre visit date
*************************************************************************************************************************

*Open dataset of people who have had an insomnia read code at any point prior to UKB assessment
set more off
use /mnt/project/primarycare_insomnia_cases.dta, clear
describe
list in 1/5
ssc install unique
unique eid //eid: 9862. Obs: 17251

*Create variable for the date of four weeks before UKB asessment date & only keep observations where event_date is after this.
generate fourweeks=date_assess-28
keep if event_date >= fourweeks & event_date <= date_assess
list in 1/2
unique eid //eid: 199. obs: 214

*Drop all variables except eid
keep eid
describe //obs:214  vars:1

*Drop any duplicate records for the same eid
duplicates drop //15 obs deleted
describe //obs: 199 vars: 1
unique eid //eid: 199. obs: 199

*Save & upload
save pc_insomniacases_fourweeks.dta, replace
!dx upload pc_insomniacases_fourweeks.dta
	
*******************************************************************************************************************

*2. Create dataset of just those with primary care event in the 12 months prior to initial UKB assessment centre visit date

use /mnt/project/primarycare_insomnia_cases.dta, clear

*Create variable for the date of 12 months (365.25 days) before UKB asessment date & only keep observations where event_date is after this.
generate twelvemonths = date_assess-365.25
describe
keep if event_date  >= twelvemonths & event_date <= date_assess // 14,787 obs deleted.
list in 1/2
describe // obs: 2464. vars: 126.
unique eid // obs: 2462. unique eids: 1920. 

*Drop all variables except eid
keep eid
describe // obs: 2462. vars: 1

*Drop any duplicate records for the same eid
duplicates drop
describe // 544 obs deleted.
unique eid //obs: 1920. eids: 1920.


*Save & upload
save pc_insomniacases_twelvemonths.dta, replace
!dx upload pc_insomniacases_twelvemonths.dta


****************************************************************************************************************************

*Merge new insomnia cases datasets with current main analysis dataset & create variables for pc_insomniacase_fourweeks & pc_insomniacase_twelvemonths
*********************************************************************************************************************


*Create variable in main analysis dataset for primary health care insomnia 4 weeks cases by merging eids of those with an insomnia read code

*Open primary care insomnia cases four weeks dataset (master)
use /mnt/project/pc_insomniacases_fourweeks.dta, clear
set more off
describe // 

ssc install unique
unique eid // obs: 199. eid: 199


*Merge primary care insomnia cases (master) with phenotype dataset (using)
merge 1:1 eid using /mnt/project/pheno_primarycare7.dta

*Result                           # of obs.
*    -----------------------------------------
*    not matched                       163,551
*        from master                         1  (_merge==1)
*        from using                    163,550  (_merge==2)
*
*    matched                               198  (_merge==3)
*    -----------------------------------------

**NB pheno_primarycare7 dataset has had people missing self-report insomnia data removed. That is why there is an eid in our 4 weeks cases dataset that is not in the pheno_primarycare7 dataset.


*Rename merge variable
rename _merge _merge_fourweeks



*Generate indicator variable for primary care insomnia case in 4 weeks prior to UB assessment
generate pc_insomniacase_fourweeks =0
	*Make it 1 if eid matches the primary care insomnia cases 4 weeks dataset 
	replace pc_insomniacase_fourweeks =1 if _merge_fourweeks == 3 //198 real changes made
	*Label the variable
	label variable pc_insomniacase_fourweeks "Insomnia read code in 4 weeks prior to UKB assess 1=Yes 0=No."
	*Label the variable values
	label define pc_insomniacase_fourweeks_lb 1"Yes" 0"No"
	label values pc_insomniacase_fourweeks pc_insomniacase_fourweeks_lb

*Check looks ok
tab pc_insomniacase_fourweeks, missing // 0.12% of our sample are an insomnia case.
describe
codebook pc_insomniacase_fourweeks

unique eid if pc_insomniacase_fourweeks ==1
unique eid if pc_insomniacase_fourweeks ==0 

*Drop extra observation of eid that is not in main (using) dataset 
drop if _merge_fourweeks==1 //1 observation deleted.

*Check looks ok
tab pc_insomniacase_fourweeks, missing
describe
codebook pc_insomniacase_fourweeks

unique eid if pc_insomniacase_fourweeks ==1
unique eid if pc_insomniacase_fourweeks ==0 



*Save & Upload
save pheno_primarycare8.dta, replace
!dx upload pheno_primarycare8.dta

**********************************************************************************************************************

*Create variable in main analysis dataset for primary health care insomnia 12 months cases by merging eids of those with an insomnia read code

*Open primary care insomnia cases twelve months dataset (master)
use /mnt/project/pc_insomniacases_twelvemonths.dta, clear
set more off
describe // obs: 1920. vars: 1

ssc install unique
unique eid // obs 1920. eid: 1920.


*Merge primary care insomnia cases 12 months (master) with main dataset (using)
merge 1:1 eid using /mnt/project/pheno_primarycare8.dta


*Result                           # of obs.
*    -----------------------------------------
*    not matched                       161,850
*        from master                        11  (_merge==1)
*        from using                    161,839  (_merge==2)
*
*    matched                             1,909  (_merge==3)
*    -----------------------------------------

*Rename merge variable
rename _merge _merge_twelvemonths



*Generate indicator variable for primary care insomnia case in 12 months prior to UB assessment
generate pc_insomniacase_twelvemonths =0
	*Make it 1 if eid matches the primary care insomnia cases 12 months dataset 
	replace pc_insomniacase_twelvemonths =1 if _merge_twelvemonths == 3 //1909 real changes made
	*Label the variable
	label variable pc_insomniacase_twelvemonths "Insomnia read code in 12 months prior to UKB assess 1=Yes 0=No."
	*Label the variable values
	label define pc_insomniacase_twelvemonths_lb 1"Yes" 0"No"
	label values pc_insomniacase_twelvemonths pc_insomniacase_twelvemonths_lb

*Drop extra observation of eid that is not in main (using) dataset (due to main dataset having had people with missing self-reported insomnia removed)
drop if _merge_twelvemonths==1 // 11 observations deleted.
	
*Check looks ok
tab pc_insomniacase_twelvemonths, missing // 1.17% of our sample are an insomnia case.
describe
codebook pc_insomniacase_twelvemonths

unique eid if pc_insomniacase_twelvemonths ==1 //1909
unique eid if pc_insomniacase_twelvemonths ==0  //161839


*Save & Upload
save pheno_primarycare9.dta, replace
!dx upload pheno_primarycare9.dta



*******************************************************************************

*Run tabulations of primary care insomnia cases 4 weeks & 12 months prior to UKB assessment vs self-reported insomnia cases
**************************************************************************************************************************

*Open dataset
set more off
use /mnt/project/pheno_primarycare9.dta, clear

*Tabulate primary care insomnia cases 4 weeks prior to UKB assess by self-reported insomnia cases
tab pc_insomniacase_fourweeks sr_insomniacase, row col


*Tabulate primary care insomnia cases 12 months prior to UKB assess by self-reported insomnia cases
tab pc_insomniacase_twelvemonths sr_insomniacase, row col

