**Sensitivity Analysis - prescriptions - data cleaning
*******************************************************


*1. Clean prescription dataset & cut down to just those in our study & those with an insomnia prescription
************************************************************************************************************
************************************************************************************************************

************************************
*a) Prepare list of eids in study
***********************************
*Open main dataset
set more off
use /mnt/project/pheno_primarycare9.dta, clear // (18.04GiB)

*Only keep the eid variable
describe // obs: 173,748. vars: 50
keep eid
describe //vars: 1

*Save & upload
save study_eids.dta, replace
!dx upload study_eids.dta

***************************************

*b) Clean prescriptions dataset
******************************************

*Open prescriptions dataset
set more off
use /mnt/project/primarycare_prescriptions.dta, clear

describe //obs: 57,974,270. vars: 5 (eid, bnf_code, issue_date, drug_name, quantity)
list in 1/5


*Lots missing bnf_code - this will be for all 502,000 participants in UKB - not cut down to correct data provider / those with correct registration data / those with self-report insomnia not missing.

*Drop variable we don't need (quantity/drug name) to cut down size of dataset
drop quantity drug_name // leaves us with eid, bnf_code, issue_date
describe

*Drop any observations without a bnf_code to cut down size of datset
drop if bnf_code =="" // 14,213,431 observations deleted
describe // obs: 43,760,839. vars: 3

*Rename issue_date bnf_date
rename issue_date bnf_date
describe // vars now: eid, bnf_code, bnf_date

*Format bnf_date so can be read by stata
*Convert bnf_date from string to stata elapsed date format
	generate bnf_date_stata = date(bnf_date, "YMD")
	list eid bnf_date bnf_date_stata in 1/5
	
	*Make elapsed date readable
	format bnf_date_stata %d
	list eid bnf_date bnf_date_stata in 1/5
	
	*Rename variable back to original name
	drop bnf_date
	rename bnf_date_stata bnf_date
	list in 1/5

*****************************************

*Need to generate new variable bnf_shortcode (contains first 6 numbers of bnf code in prescriptions dataset without the full stops) so we have comparable TPP bnf codes to the codelist

*****BNF codes used in TPP data are not the same as standard BNF codes provided in the UK Biobank Lookup file***
*https://biobank.ndph.ox.ac.uk/showcase/showcase/docs/primary_care_data.pdf
*"3.2.3. BNF codes in TPP data
*BNF codes in the TPP extract follow the format 00.00.00.00.00. However, the coding structure does not always map to codes provided by the NHSBSA. The first six digits of the code typically relate to BNF chapter, section and paragraph in the NHSBSA code lists, although this is not consistent. Digits 7 and 8 do not appear to correspond to subparagraphs in the NHSBSA codes, and digits 9 and 10 are always coded as 00. To support analysis, the associated drug name or description for each BNF code is included".

gen bnf_shortcode=substr(bnf_code,1,2)+substr(bnf_code,4,2)+substr(bnf_code,7,2)
list bnf_code bnf_shortcode in 1/10
drop bnf_code


*Save & upload dataset (contains variables: eid, bnf_shortcode, bnf_date in long format)
save primarycare_prescriptions2.dta, replace
!dx upload primarycare_prescriptions2.dta

**************************************************************************

*c) Cut down prescriptions dataset to just those people included in our study
********************************************************************************
*Merge prescriptions data with list of eids of study sample & drop anyone not in study (master=presciptions dataset. Using = study eids)
set more off
use /mnt/project/primarycare_prescriptions2.dta, clear
merge m:1 eid using /mnt/project/study_eids.dta


*Result                           # of obs.
*    -----------------------------------------
*    not matched                     4,841,428
*        from master                 4,835,280  (_merge==1)
*        from using                      6,148  (_merge==2)
*
*    matched                        38,925,559  (_merge==3)
*    -----------------------------------------

*Rename merge variable
rename _merge _merge_studysample

*Explore merged datasets
describe 
ssc install unique
unique eid if _merge_studysample==3 // unique eids matched: 157,600 (records 38,925,559)
unique eid if _merge_studysample==2 // unique eids of people in our study without prescriptions: 6148
unique eid if _merge_studysample==1 // unique eids of people with prescriptions but not in our study: 27,141 (records 4,835,280)

*Only keep observations with eids in our study sample
keep if _merge_studysample ==3 //4,841,428 obs deleted
unique eid // unique eids: 157,600. records: 38,925,559

*Drop variables we don't need: leaves us with eid and bnf_date (long format)
drop _merge_studysample
describe // obs: 38,925,559. Vars: 3.

*Save & upload: dataset of just observations with insomnia prescriptions in long format.
save primarycare_prescriptions3.dta, replace
!dx upload primarycare_prescriptions3.dta



************************************************************************

************************************************************************

*d) Cut down prescriptions dataset to people with an insomnia prescription code.
********************************************************************************


*Merge prescriptions dataset with prescriptions codelist. prescription data = master. codelist = using
set more off
use /mnt/project/primarycare_prescriptions3.dta, clear
merge m:1 bnf_shortcode using /mnt/project/hypnotics_codelist.dta

*Result                           # of obs.
*    -----------------------------------------
*    not matched                    38,682,265
*        from master                38,682,265  (_merge==1)
*        from using                          0  (_merge==2)
*
*    matched                           243,294  (_merge==3)
*    -----------------------------------------


*Rename merge variable
rename _merge _merge_hypnoticscodelist

*Explore merged datasets
describe // obs: 38,925,562. Vars: 4. vars: eid, bnf_date, bnf_shortcode, _merge_hypnoticscodelist
ssc install unique
unique eid if _merge_hypnoticscodelist==3 // unique eids of people with insomnia prescriptions: 31,128 (records 243,294)


*Only keep observations with bnf codes in our codelist - will give us list of observations with insomnia prescriptions.
keep if _merge_hypnoticscodelist ==3 // 38,682,265 obs deleted
unique eid //unique eids: 31,128 Records: 243,294 

*Drop variables we don't need: leaves us with eid and bnf_date (long format)
drop bnf_shortcode _merge_hypnoticscodelist
describe // 2 vars: eid, bnf_date. obs: 243,294

*Save & upload: dataset of just observations with insomnia prescriptions in long format.
save pc_prescription_cases.dta, replace // 1.86MiB
!dx upload pc_prescription_cases.dta

