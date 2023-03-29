*Splitting primary care event dataset by observations so can merge with registration/deduction dataset
******************************************************************************************************

*Open primarycare cleaned events dataset
use /mnt/project/pc_events_cleaned.dta, clear
describe
list in 1/5

*Generate group variable 1=observations 1-44mill, 2=observations >44mill
gen group = 1
replace group = 2 if _n >44000000
tab group

*Loop to save groups 1 and 2 separately
 preserve 
 foreach i of num 1/2 {
         keep if group == `i'
         save group`i'
         restore, preserve 
 }
 
*Group 1 = 44,000,000 observations
*Group 2 = 43,468,188 observations
 
 
*Upload groups to DNA Nexus
!dx upload group1.dta
!dx upload group2.dta