*****************************************************************

*Append the 87merged group files (events & registrations merged)
*********************************************

set more off
use /mnt/project/group1_pcevents_regs, clear
   *loop to append groups 2-87
 foreach i of num 2/87 {
 	append using /mnt/project/group`i'_pcevents_regs.dta
	 *save group1to`i'.dta, replace
	  *!dx upload group1to`i'.dta
 }
 save allgroups_pcevents_regs.dta, replace
  !dx upload allgroups_pcevents_regs.dta
  
************************************************************************  


*Check combined dataset opens & looks ok.

set more off
use /mnt/project/allgroups_pcevents_regs, clear
describe //obs: 33,064,673. Vars 211 (lots of merge variables!)
ssc install unique
unique eid // obs: 33,064,673. Unique eids: 137,406.


****We have 137,406 participants with valid events data.

*See if there are observations / people registration dates but no primary care events (merge ==2 not matched (using (regs) only) or merge ==1 not matched (Master, events dataset only)).

 foreach i of num 1/87 {
 	count if _merge_pceventsregs_grp`i' ==2 //0 for all 87 merge variables
 }	

 foreach i of num 1/87 {
 	count if _merge_pceventsregs_grp`i' ==1  //0 for all 87 merge variables
 }	 
 
 **We only have observations that matched.
 
foreach i of num 1/87 {
 	count if _merge_pceventsregs_grp`i' ==3  // Around 375,000 per merge variable.  
 }	
 

*Drop the 87 merge variables
drop _merge* 
describe //obs: 33,064,673. Vars: 124   
 
*Save & upload dataset minus merge variables. 
save allgroups_pcevents_regs2.dta, replace
!dx upload allgroups_pcevents_regs2.dta


******************************************************************

*Loop to check total number of records in combined dataset equals number in individual group datasets

set more off
ssc install unique

foreach i of num 1/87 {
 	use /mnt/project/group`i'_pcevents_regs.dta, clear
	unique eid //around 375,000 obs per dataset & around 1500 eids per dataset = adds up to the right amount.
	} 
	
	