*Merging read code list with primary care data
***********************************************

*Prepare codelist for merging
******************************
*Open codelist
use /mnt/project/insomnia_finalcodelist.dta, clear

set more off
describe // obs: 181. Vars: 2 (both string vars).

*Rename readcode to read_code so can merge on this common variable.
rename readcode read_code

*Delete description variable
drop desc
describe //vars: 1.


*Save & upload file
save insomnia_finalcodelist2.dta, replace
!dx upload insomnia_finalcodelist2.dta


***************************************************

*Go out & back into jupyterlabs so can use saved .dta file.

*Merge combined primary care data with codelist
	*Primary care =  master
	*Codelist = using.

set more off
use /mnt/project/allgroups_pcevents_regs2.dta, clear
merge m:1 read_code using /mnt/project/insomnia_finalcodelist2.dta
rename _merge _mergecodelist

*Explore merged dataset
ssc install unique
unique eid if _mergecodelist==3 // 9862 eids have an insomnia code.
*unique eid in primary care registration data = 164,184
*6% of participants have an insomnia code.

*Save & upload
save primarycare_codelist.dta, replace
!dx upload primarycare_codelist.dta //file is 15.34 GiB


*Result                           # of obs.
*    -----------------------------------------
*    not matched                    33,047,524
*        from master                33,047,422  (_merge==1)
*        from using                        102  (_merge==2)
*
*    matched                            17,251  (_merge==3)
*    -----------------------------------------

*************************************************************

*Go out & back into jupyterlabs so can use saved .dta file.

*Keep only events with read codes in our codelist
set more off
use /mnt/project/primarycare_codelist.dta, clear
keep if _mergecodelist == 3 //33,047,524 obs deleted. 
ssc install unique
unique eid // obs: 17,251. eid: 9,862. 
save primarycare_insomnia_cases.dta, replace
!dx upload primarycare_insomnia_cases.dta