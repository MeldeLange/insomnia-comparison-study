*Splitting prinmary care event dataset into smaller datasets by observations so can merge with registration/deduction dataset
*****************************************************************************************************************************


 *Split in 87 groups each with  around 1 million observations.
 *Total dataset has 87,468,188 observations!
 
 *Open primarycare cleaned events dataset
use /mnt/project/pc_events_cleaned.dta, clear

set more off

*Split into 87 groups
xtile group = _n, nq(87)
tab group
*This worked (took 9 minutes to do!)

 	 *Loop to save groups 1 -87 separately
 preserve 
 foreach i of num 1/87 {
         keep if group == `i'
         save group`i', replace
         restore, preserve 
 }
*This worked second time round! (first time got stuck on record 35)
 
 *Loop to upload group.dtas to my project
 
 foreach i of num 1/87 {
          !dx upload group`i'.dta
 }
 
