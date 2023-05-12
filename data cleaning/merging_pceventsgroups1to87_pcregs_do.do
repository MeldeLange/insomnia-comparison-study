*MERGING PRIMARY CARE REGISTRATIONS/DEDUCTIONS WITH PRIMARY CARE EVENTS DATA (pc events data split into 87 separate files)
***********************************************************************************************************************

*A) Merging the primary care events 87 groups with primary care registration data.
*********************************************************************************

	**It is important to set more off. Otherwise stata pauses until you press a key.

set more off

*Loop to merge
 foreach i of num 1/87 {
 	use /mnt/project/group`i'.dta, clear
         drop group
		 merge m:1 eid using /mnt/project/pc_regs_wide.dta
		rename _merge _merge_pceventsregs_grp`i'
		save group`i'_pcevents_regs.dta, replace
		 !dx upload group`i'_pcevents_regs.dta
 }
 
***************************************************************************************

*B) Drop observations/people we don't need to cut down size of datasets.
************************************************************************

*1. In each primary care events group dataset:Drop observations of people not in registration dataset
*************************************************************
*Go out of jupyterlabs & back in again to be able to use saved .dta files.
 
 **In each group: drop people/observations in events dataset who are not in the registration dataset (i.e. don't have any registration data) *_merge_pceventsregs_grp`i == 1
*We are keeping people/observations with registration data but no events. (_merge_pceventsregs_grp`i == 2)


*Loop to drop those without registration data (not in registration dataset)
*This will drop around 1 million observations in total (around 11,000 per group)

set more off

 foreach i of num 1/87 {
 	use /mnt/project/group`i'_pcevents_regs.dta, clear
         drop if _merge_pceventsregs_grp`i' == 1
		save group`i'_pcevents_regs.dta, replace
		 !dx upload group`i'_pcevents_regs.dta
}


*Step 1 cut around 11,000 per group, so roughly 960,000 observations in total.



*2. In each primary care events group dataset: drop events not in registration period.
***************************************************************************
*Go out of jupyterlabs & back in again to use saved .dta files.

*Outerloop opens each group dataset & generates eligible variable set to 0
*Inner loop replaces eligible as 1 if event date is within any of the 60 registration periods & event date isn't missing.	
*Outer loop drops observations not eligible (eligible==0) (events not within registration period) & drops the eligible variable.
	
	***NB. Maximum number of reg/deduction dates =60. 
	**I have already dropped observations where the registration date is missing (see data_cleaning_registrations_do) 
	**Missing deduction dates have already been temporarily replaced with 21st March 2023 so that loop works.


set more off
foreach i of num 1/87 {
 	use /mnt/project/group`i'_pcevents_regs.dta, clear
	generate eligible =0
	foreach num of numlist 1/60{
	replace eligible=1 if (event_date >= reg_date`num' & event_date <= deduct_date`num') & event_date!=. 
	}	
	drop if eligible==0
	drop eligible
	save group`i'_pcevents_regs.dta, replace
	!dx upload group`i'_pcevents_regs.dta
}
	
*Step 2 cut around 205,000 observations per group so roughly 17,835,000 observations in total.


*3. In each group: drop events after date of assessment centre visit.
***********************************************************************
*NB we have already removed any observations where event date is missing in step 2 but will include removing here just in case.

set more off
foreach i of num 1/87 {
 	use /mnt/project/group`i'_pcevents_regs.dta, clear
	generate eligible =0
	foreach num of numlist 1/60{
	replace eligible=1 if event_date <= date_assess & event_date!=.
	}	
	drop if eligible==0
	drop eligible
	save group`i'_pcevents_regs.dta, replace
	!dx upload group`i'_pcevents_regs.dta
}
	
	
*Step 3 cut around 500,000 observations per group, so roughly 43,500,000 observations in total.

*Final total dataset should be around: 26,173,188 observations (289,347 per group dataset)

**************************************************************************************************

*C) Check a group dataset looks how I expect
*********************************************
set more off
use /mnt/project/group1_pcevents_regs.dta, clear
describe //obs: 381,038. vars:125. Vars = eid, read_code, event_date, reg_date1-60 deduct_date1-60, date_assess, _mergepceventsregs_grp1
ssc install unique
unique eid //obs: 381038, eids: 1625.


count if _merge_pceventsregs_grp1 == 1 //0
count if event_date==. //0
count if event_date > date_assess //0
list in 1/1
list in -1/-1
list in 300000
list in 150000