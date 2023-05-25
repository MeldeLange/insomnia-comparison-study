*Data cleaning phenotype data
**************************************


*Import phenotype csv file
import delimited /mnt/project/insomnia_pheno.csv, clear
describe
list in 1/5

*Save phenotype data as stata .dta file
save insomnia_pheno

*Upload saved .dta file to project in DNA Nexus
!dx upload insomnia_pheno.dta


*************************************************************************************
**************************************************************************************
***Need to go out of JupyterLab and then back in again to use .dta file saved in DNA Nexus project


*Open phenotype data
use /mnt/project/insomnia_pheno.dta, clear
describe

***************************************************************
*Renaming & labelling variables

*Rename variables

rename v2 date_assess
rename v3 sex
rename v4 depriv
rename v5 income
rename v6 ethnicity
rename v7 insomnia
rename v8 chrono
rename v9 age_asess
rename v10 bmi
rename v11 overall_health
rename v12 worrier
rename v13 depress
rename v14 employ
rename v15 household_relations
rename v16 pop_dens
rename v17 night_shift
rename v18 sleep_dur
rename v19 getting_up
rename v20 nap
rename v21 day_dozing
rename v22 household_no
rename v23 menopause
rename v24 alcohol
rename v25 smoking
rename v26 risk
rename v27 quals
rename v28 met_mins
rename v29 coffee
rename v30 tea

describe

*Relabel variables
label variable eid "participant id"
label variable sex "sex at recruitment category (31)"
label variable depriv "index of multiple deprivation for England (26410)"
label variable date_assess "date attended assessment centre (53)"
label variable age "age when attended assessment centre (21003)"
label variable income "average total household income before tax category (738)"
label variable ethnicity "ethnic category (21000)"
label variable insomnia "insomnia category(1200)"
label variable chrono "chronotype category(1180)"
label variable bmi "bmi at assessment centre (21001)"
label variable overall_health "overall health rating category (2178)"
label variable worrier "are a worrier category (1980)"
label variable depress "frequency depressed mood past 2 weeks category (2050)"
label variable employ "current employment status category (6142)"
label variable quals "qualification have (can choose >1) category (6138)"
label variable household_relations "how others in household related to participant (can choose >1) category (6141)"
label variable pop_dens "home area population density category (20118)"
label variable night_shift "job involves night shift work category (3426)"
label variable sleep_dur "sleep duration in hours (inc naps) category (1160)"
label variable getting_up "how easy find getting up in morning category (1170)"
label variable nap "nap during the day category (1190)"
label variable day_dozing "daytime dozing/sleeping when don't mean to category (1220)"
label variable household_no "number of people in household category (709)"
label variable menopause "had menopause (2724)"
label variable alcohol "alcohol intake frequency (1558)"
label variable smoking "smoking status (20116)"
label variable risk "risk taking (2040)"
label variable met_mins "total met mins/week for all activity (22040)"
label variable coffee "coffee intake (cups per day) (1498)"
label variable tea "tea intake (cups per day) (1488)"

*Check naming & labeling
describe

******************************************************************************************
*Clean & generate new insomnia variable

*Clean insomnia variable
	*Set 'prefer not to answer' (-3) as missing & add value labels.
tab insomnia, missing
recode insomnia (-3 = .)
tab insomnia, missing 
	
*Generate new insomnia variable to be used in analyses
	* 0 if never/sometimes. 1 if usually
		*Generate new variable
		gen insomnia_case = insomnia 
		tab insomnia_case, missing
		label variable insomnia_case "Insomnia cases: 1= usually 0=sometimes & never/rarely"
		*Recode categories (previously 3 = usually, 2 = sometimes, 1 = never/rarely)
		recode insomnia_case (3 = 1) (2 = 0) (1 = 0)
		*Add value labels
		label define insomnia_lab 1 "Yes" 0 "No"
		label values insomnia_case insomnia_lab
		tab insomnia_case, missing
	

		
*Check insomnia variables look ok
describe
codebook insomnia_case

	
*Save as different file name
save insomnia_pheno_cleaned.dta, replace

*Upload to DNA Nexus repository
!dx upload insomnia_pheno_cleaned.dta



************************************************************************************************

*Merge self-report pheno data with registration data (164,184 participants being included in our study)

*Open registration data (master)
set more off
use /mnt/project/pc_regs_wide.dta, clear
describe
list in 1/1

*Drop all variables except eid
keep eid

*Merge registration data (master) with phenotype data (using)

merge 1:1 eid using /mnt/project/insomnia_pheno_cleaned.dta
rename _merge _mergepheno_regs
describe


*Just keep those in registration dataset (master)
keep if _mergepheno_regs == 3 //338,203 observations dropped. 
describe // vars: 32. Observations: 164,184.
drop _mergepheno_regs // Vars: 31

*Save & Upload
save pheno_primarycare.dta, replace
!dx upload pheno_primarycare.dta


***************************************************************************************************
*Create variable in pheno data for primary health care insomnia cases by merging eids of those with an insomnia read code

*Open primary care insomnia cases dataset (master)
use /mnt/project/primarycare_insomnia_cases.dta, clear
set more off
describe // 125 vars

ssc install unique
unique eid //9862 unique eid. 17251 obs.

*Drop all variables except eid
keep eid
describe // 71251 obs, 1 var.
duplicates drop
describe // 9862 obs, 1 var.
unique eid //9862 unique eid.


*Merge primary care insomnia cases (master) with phenotype dataset (using)
merge 1:1 eid using /mnt/project/pheno_primarycare.dta
rename _merge _mergepc_insomniacases

*Result                           # of obs.
*    -----------------------------------------
*    not matched                       154,322
*        from master                         0  (_merge==1)
*        from using                    154,322  (_merge==2)
*
*    matched                             9,862  (_merge==3)
*    -----------------------------------------

*Generate indicator variable for primary care insomnia case
generate pc_insomniacase =0
	*Make it 1 if eid matches the primary care insomnia cases dataset 
	replace pc_insomniacase =1 if _mergepc_insomniacases == 3
	*Label the variable
	label variable pc_insomniacase "Primary care insomnia case (has insomnia read code) 1=Yes 0=No."
	*Label the variable values
	label define pc_insomniacase_lb 1"Yes" 0"No"
	label values pc_insomniacase pc_insomniacase_lb

*Check looks ok
tab pc_insomniacase, missing
describe
codebook pc_insomniacase

unique eid if pc_insomniacase ==1 //9862
unique eid if pc_insomniacase ==0 //154322

*Save & Upload
save pheno_primarycare.dta, replace
!dx upload pheno_primarycare.dta


********************************************************************************************
********************************************************************************************

*Cleaning self-report phenotype data
**************************************
**************************************
*Open complete dataset
use /mnt/project/pheno_primarycare.dta, clear
set more off
describe // 164,184 obs. 33 vars.
list in 1/1

*Rename self report insomnia_case variable to be consistent with primary care one. 
rename insomnia_case sr_insomniacase
describe

*Recode N/A (-3) prefer not to answer or don't know (-1) in categorical variables to missing and add value labels (if not recoding the variable further).
****************************************************************************************************************************

tab sex, missing
label define sex_lb 1"Male" 0"Female"
label values sex sex_lb
tab sex, missing

tab income , missing
recode income (-3 -1 =.)
tab income , missing
label define income_lb 1"<£18,000" 2 "£18,000-£30,999" 3 "£31,000-£51,999" 4 "£52,000-£100,000" 5 ">£100,000"
label values income income_lb
tab income , missing

tab overall_health, missing
recode overall_health (-3 -1 =.)
tab overall_health, missing
label define overall_health_lb 1 "Excellent" 2 "Good" 3 "Fair" 4 "Poor"
label values overall_health overall_health_lb
tab overall_health, missing

tab worrier, missing
recode worrier (-3 -1 =.)
tab worrier, missing
label define worrier_lb 1 "Yes" 0 "No"
label values worrier worrier_lb
tab worrier, missing

tab depress, missing
recode depress (-3 -1 =.)
tab depress, missing
label define depress_lb 1 "Not at all" 2 "Several days" 3 "More than half the days" 4 "Nearly every day"
label values depress depress_lb
tab depress, missing

*Only people who do shift work were asked this question. Therfore we count anyone with missing data (.) (i.e. who wasn't asked the question) as a no (put in the"Never/rarely" category (1))
tab night_shift, missing
recode night_shift (. = 1)
recode night_shift (-3 -1 =.)
tab night_shift, missing
label define night_shift_lb 1 "Never/rarely" 2 "Sometimes" 3 "Usually" 4 "Always"
label values night_shift night_shift_lb
tab night_shift, missing

tab getting_up, missing
recode getting_up (-3 -1 =.)
tab getting_up, missing
label define getting_up_lb 1 "Not at all easy" 2 "Not very easy" 3 "Fairly easy" 4 "Very easy"
label values getting_up getting_up_lb
tab getting_up, missing

tab nap, missing
recode nap (-3 =.)
tab nap, missing
label define nap_lb 1 "Never/rarely" 2 "Sometimes" 3 "Usually"
label values nap nap_lb
tab nap, missing

tab day_dozing, missing
recode day_dozing (-3 -1 =.)
tab day_dozing, missing
label define day_dozing_lb 0 "Never/rarely" 1 "Sometimes" 2 "Often" 3 "All of the time"
label values day_dozing day_dozing_lb
tab day_dozing, missing

*Menopause - we are counting anyone who has had a hysterectomy (2) as a yes (have been through the menopause (1)). 
*We are counting anyone who says not sure - other reason (3) as missing. Prefer not to answer (-3) set to missing.
tab menopause, missing
recode menopause (-3 =.)
tab menopause, missing
recode menopause (2 = 1)
recode menopause (3=.)
tab menopause, missing
label define menopause_lb 1"Yes" 0"No"
label values menopause menopause_lb
tab menopause, missing

tab alcohol, missing
recode alcohol (-3 =.)
tab alcohol, missing
label define alcohol_lb 1 "Daily/almost daily" 2 "3-4 times a week" 3 "Once or twice a week" 4 "1-3 times a month" 5 "Special occasions only" 6 "Never"
label values alcohol alcohol_lb
tab alcohol, missing

tab smoking, missing
recode smoking (-3 =.)
tab smoking, missing
label define smoking_lb 0 "Never" 1 "Previous" 2 "Current"
label values smoking smoking_lb
tab smoking, missing

tab risk, missing
label variable risk "describe yourself someone as who takes risks binary?"
recode risk (-3 -1 =.)
tab risk, missing
label define risk_lb 1"Yes" 0"No"
label values risk risk_lb
tab risk, missing


tab sr_insomniacase, missing
tab sr_insomniacase
*28.91% of our sample self report having insomnia.

tab pc_insomniacase, missing
tab pc_insomniacase
*6.01% of our sample have primary care read code for insomnia.


******************************************************************************


*Convert date of assessment centre from string to stata elapsed date format
	generate date_assess_stata = date(date_assess, "YMD")
	list eid date_assess date_assess_stata in 1/5
	
	*Make elapsed date readable
	format date_assess_stata %d
	list eid date_assess date_assess_stata in 1/5
	
	*Rename variable back to original name
	drop date_assess
	rename date_assess_stata date_assess
	list in 1/5


***Clean categorical variables that require more specific recoding
******************************************************************

*chrono
*Recode chronotype so -1 = no preference
tab chrono, missing
recode chrono (-3 =.)
tab chrono
recode chrono (1=1) (2=2) (-1=3) (3=4) (4=5)
tab chrono
label define chrono_lb 1 "Definite morning" 2 "Morning more than evening" 3 "No preference" 4 "Evening more than morning" 5 "Definite evening"  
label values chrono chrono_lb
tab chrono, missing



*pop_dens (recode to fewer categories). 1: All urban categories together, 2: all town categories together, 3: all village & hamlet categories together as rural.
*We have some people who are living in Scotland (original categories 11, 12, 13, 16). They must have lived in England at some point as we have their English primary care records but by the time they go to the UKB assessment centre they have moved to Scotland. We have coded these people as missing just for this variable. 9 (postcode not linkable) is coded as missing
tab pop_dens, missing
recode pop_dens (9=.)
tab pop_dens, missing
recode pop_dens (1=1) (2=2) (3=3) (4=3) (5=1) (6=2) (7=3) (8=3) (11=.) (12=.) (13=.) (16=.)
tab pop_dens, missing
label define pop_dens_lb 1 "Urban" 2 "Town" 3 "Rural"
label values pop_dens pop_dens_lb
tab pop_dens, missing



*ethnicity (recode into 6 top level categories)
tab ethnicity, missing
recode ethnicity (-3 -1 =.)
tab ethnicity, missing
recode ethnicity (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (1001=1) (1002=1) (1003=1) (2001=2) (2002=2) (2003=2) (2004=2)(3001=3) (3002=3) (3003=3) (3004=3) (4001=4) (4002=4) (4003=4)
tab ethnicity
label define ethnicity_lb 1 "White" 2 "Mixed" 3 "Asian/Asian British" 4 "Black/Black British" 5 "Chinese" 6 "Other"
label values ethnic ethnicity_lb
tab ethnicity


********************************************************************************

*Clean categorical variables with multiple answers that are string variables
**********************************************************************

*Qualifications
tab quals, missing
	*Generate new variable for highest qualification
generate qual_highest = 0 //By coding this as 0 rather than it being quals it effectively destrings the variable.
replace qual_highest =0 if quals == "-7"
replace qual_highest =. if quals == "-3"
replace qual_highest =. if quals == "" // Note: quals was a string variable so missing values weren't coded as .
tab qual_highest, missing
	
replace qual_highest =1 if quals == "1"
replace qual_highest =1 if quals == "1|2"
replace qual_highest =1 if quals == "1|2|3"
replace qual_highest =1 if quals == "1|2|3|4"
replace qual_highest =1 if quals == "1|2|3|4|5"
replace qual_highest =1 if quals == "1|2|3|4|5|6"
replace qual_highest =1 if quals == "1|2|3|4|6"
replace qual_highest =1 if quals == "1|2|3|5"
replace qual_highest =1 if quals == "1|2|3|5|6"
replace qual_highest =1 if quals == "1|2|3|6"
replace qual_highest =1 if quals == "1|2|4"
replace qual_highest =1 if quals == "1|2|4|5"
replace qual_highest =1 if quals == "1|2|4|5|6"
replace qual_highest =1 if quals == "1|2|4|6"
replace qual_highest =1 if quals == "1|2|5"
replace qual_highest =1 if quals == "1|2|5|6"
replace qual_highest =1 if quals == "1|2|6"
replace qual_highest =1 if quals == "1|3"
replace qual_highest =1 if quals == "1|3|4"
replace qual_highest =1 if quals == "1|3|4|5"
replace qual_highest =1 if quals == "1|3|4|5|6"
replace qual_highest =1 if quals == "1|3|4|6"
replace qual_highest =1 if quals == "1|3|5"
replace qual_highest =1 if quals == "1|3|5|6"
replace qual_highest =1 if quals == "1|3|6"
replace qual_highest =1 if quals == "1|4"
replace qual_highest =1 if quals == "1|4|5"
replace qual_highest =1 if quals == "1|4|5|6"
replace qual_highest =1 if quals == "1|4|6"
replace qual_highest =1 if quals == "1|5"
replace qual_highest =1 if quals == "1|5|6"
replace qual_highest =1 if quals == "1|6"
replace qual_highest =2 if quals == "2"
replace qual_highest =2 if quals == "2|3"
replace qual_highest =2 if quals == "2|3|4"
replace qual_highest =2 if quals == "2|3|4|5"
replace qual_highest =2 if quals == "2|3|4|5|6"
replace qual_highest =2 if quals == "2|3|4|6"
replace qual_highest =2 if quals == "2|3|5"
replace qual_highest =2 if quals == "2|3|5|6"
replace qual_highest =2 if quals == "2|3|6"
replace qual_highest =2 if quals == "2|4"
replace qual_highest =2 if quals == "2|4|5"
replace qual_highest =2 if quals == "2|4|5|6"
replace qual_highest =2 if quals == "2|4|6"
replace qual_highest =2 if quals == "2|5"
replace qual_highest =2 if quals == "2|5|6"
replace qual_highest =2 if quals == "2|6"
replace qual_highest =3 if quals == "3"
replace qual_highest =3 if quals == "3|4"
replace qual_highest =3 if quals == "3|4|5"
replace qual_highest =3 if quals == "3|4|5|6"
replace qual_highest =3 if quals == "3|4|6"
replace qual_highest =3 if quals == "3|5"
replace qual_highest =3 if quals == "3|5|6"
replace qual_highest =3 if quals == "3|6"
replace qual_highest =4 if quals == "4"
replace qual_highest =4 if quals == "4|5"
replace qual_highest =4 if quals == "4|5|6"
replace qual_highest =4 if quals == "4|6"
replace qual_highest =5 if quals == "5"
replace qual_highest =5 if quals == "5|6"
replace qual_highest =6 if quals == "6"

tab qual_highest, missing
*qual_highest is now a float variable (no longer string)

*Label the qual_highest variable
label variable qual_highest "Highest qualification"


		*Create value labels for qual_highest

label define qual_highest_lb 0"None" 1"College/University degree" 2"A/AS levels or equivalent" 3"O levels/GCSEs or equivalent" 4"CSEs or equivalent" 5"NVQ/HND/HNC or equivalent" 6"Other professional qualifications" 
label values qual_highest qual_highest_lb
tab qual_highest, missing


********************************************************************

*employ

*We are simplifying the categories for this to reduce it to 3 categories. Anyone that has a 1 at all (employed/self-employed) counts as employed (1), anyone who has a 2 at all counts as retired (2). If they don't have a 1 or a 2 (including -7 "none of the above") they are put in the 'other' category (3). Prefer not to answer (-3) is coded as missing.

tab employ, missing
	*Generate new variable for employ_3cats
generate employ_3cats =0
replace employ_3cats =3 if employ == "-7"
replace employ_3cats =. if employ == "-3"
replace employ_3cats =. if employ == "" 
tab employ_3cats, missing

replace employ_3cats =1 if employ== "1"
replace employ_3cats =1 if employ == "1|2"
replace employ_3cats =1 if employ == "1|2|3"
replace employ_3cats =1 if employ == "1|2|3|4"
replace employ_3cats =1 if employ == "1|2|3|4|5|6|7"
replace employ_3cats =1 if employ == "1|2|3|4|6"
replace employ_3cats =1 if employ == "1|2|3|6"
replace employ_3cats =1 if employ == "1|2|3|6|7"
replace employ_3cats =1 if employ == "1|2|3|7"
replace employ_3cats =1 if employ == "1|2|4"
replace employ_3cats =1 if employ == "1|2|4|6"
replace employ_3cats =1 if employ == "1|2|4|7"
replace employ_3cats =1 if employ == "1|2|5"
replace employ_3cats =1 if employ == "1|2|6"
replace employ_3cats =1 if employ == "1|2|6|7"
replace employ_3cats =1 if employ == "1|2|7"
replace employ_3cats =1 if employ == "1|3"
replace employ_3cats =1 if employ == "1|3|4"
replace employ_3cats =1 if employ == "1|3|4|6"
replace employ_3cats =1 if employ == "1|3|5"
replace employ_3cats =1 if employ == "1|3|5|6"
replace employ_3cats =1 if employ == "1|3|6"
replace employ_3cats =1 if employ == "1|3|6|7"
replace employ_3cats =1 if employ == "1|3|7"
replace employ_3cats =1 if employ == "1|4"
replace employ_3cats =1 if employ == "1|4|5"
replace employ_3cats =1 if employ == "1|4|6"
replace employ_3cats =1 if employ == "1|4|7"
replace employ_3cats =1 if employ == "1|5"
replace employ_3cats =1 if employ == "1|5|6"
replace employ_3cats =1 if employ == "1|5|7"
replace employ_3cats =1 if employ == "1|6"
replace employ_3cats =1 if employ == "1|6|7"
replace employ_3cats =1 if employ == "1|7"
replace employ_3cats =2 if employ == "2"
replace employ_3cats =2 if employ == "2|3"
replace employ_3cats =2 if employ == "2|3|4"
replace employ_3cats =2 if employ == "2|3|4|5"
replace employ_3cats =2 if employ == "2|3|4|5|6"
replace employ_3cats =2 if employ == "2|3|4|6"
replace employ_3cats =2 if employ == "2|3|4|6|7"
replace employ_3cats =2 if employ == "2|3|5"
replace employ_3cats =2 if employ == "2|3|5|6"
replace employ_3cats =2 if employ == "2|3|6"
replace employ_3cats =2 if employ == "2|3|6|7"
replace employ_3cats =2 if employ == "2|3|7"
replace employ_3cats =2 if employ == "2|4"
replace employ_3cats =2 if employ == "2|4|5"
replace employ_3cats =2 if employ == "2|4|5|6"
replace employ_3cats =2 if employ == "2|4|6"
replace employ_3cats =2 if employ == "2|4|6|7"
replace employ_3cats =2 if employ == "2|4|7"
replace employ_3cats =2 if employ == "2|5"
replace employ_3cats =2 if employ == "2|5|6"
replace employ_3cats =2 if employ == "2|5|7"
replace employ_3cats =2 if employ == "2|6"
replace employ_3cats =2 if employ == "2|6|7"
replace employ_3cats =2 if employ == "2|7"
replace employ_3cats =3 if employ == "3"
replace employ_3cats =3 if employ == "3|4"
replace employ_3cats =3 if employ == "3|4|5"
replace employ_3cats =3 if employ == "3|4|5|7"
replace employ_3cats =3 if employ == "3|4|6"
replace employ_3cats =3 if employ == "3|4|6|7"
replace employ_3cats =3 if employ == "3|5"
replace employ_3cats =3 if employ == "3|5|6"
replace employ_3cats =3 if employ == "3|5|6|7"
replace employ_3cats =3 if employ == "3|5|7"
replace employ_3cats =3 if employ == "3|6"
replace employ_3cats =3 if employ == "3|6|7"
replace employ_3cats =3 if employ == "3|7"
replace employ_3cats =3 if employ == "4"
replace employ_3cats =3 if employ == "4|5"
replace employ_3cats =3 if employ == "4|5|6"
replace employ_3cats =3 if employ == "4|5|7"
replace employ_3cats =3 if employ == "4|6"
replace employ_3cats =3 if employ == "4|6|7"
replace employ_3cats =3 if employ == "4|7"
replace employ_3cats =3 if employ == "5"
replace employ_3cats =3 if employ == "5|6"
replace employ_3cats =3 if employ == "5|6|7"
replace employ_3cats =3 if employ == "5|7"
replace employ_3cats =3 if employ == "6"
replace employ_3cats =3 if employ == "6|7"
replace employ_3cats =3 if employ == "7"

tab employ_3cats, missing

	*label the employ_3cats variable
	label variable employ_3cats "Current employment status"


		*Create value labels for employ_3cats

label define employ_3cats_lb 1 "Paid employment/self-employed" 2 "Retired" 3 "Other"
label values employ_3cats employ_3cats_lb
tab employ_3cats, missing


******************************************
*household_relations
tab household_relations, missing

*We are simplifying the categories for this to reduce it to a binary variable. Anyone who is living with a husband/wife/patner is coded as 1. Everyone else is coded as 0. Prefer not to answer (-3) is coded as missing.


	*Generate new variable for house_rels_binary
generate house_rels_binary =0
replace house_rels_binary=. if household_relations == "-3"
replace house_rels_binary =. if household_relations == "" 
tab house_rels_binary, missing

replace house_rels_binary =1 if household_relations== "1"
replace house_rels_binary =1 if household_relations== "1|2"
replace house_rels_binary =1 if household_relations== "1|2|3"
replace house_rels_binary =1 if household_relations== "1|2|3|4"
replace house_rels_binary =1 if household_relations== "1|2|3|4|5"
replace house_rels_binary =1 if household_relations== "1|2|3|4|7"
replace house_rels_binary =1 if household_relations== "1|2|3|5"
replace house_rels_binary =1 if household_relations== "1|2|3|7"
replace house_rels_binary =1 if household_relations== "1|2|4"
replace house_rels_binary =1 if household_relations== "1|2|4|5"
replace house_rels_binary =1 if household_relations== "1|2|4|6"
replace house_rels_binary =1 if household_relations== "1|2|4|6|7"
replace house_rels_binary =1 if household_relations== "1|2|4|7"
replace house_rels_binary =1 if household_relations== "1|2|4|8"
replace house_rels_binary =1 if household_relations== "1|2|5"
replace house_rels_binary =1 if household_relations== "1|2|6"
replace house_rels_binary =1 if household_relations== "1|2|6|7"
replace house_rels_binary =1 if household_relations== "1|2|6|8"
replace house_rels_binary =1 if household_relations== "1|2|7"
replace house_rels_binary =1 if household_relations== "1|2|7|8"
replace house_rels_binary =1 if household_relations== "1|2|8"
replace house_rels_binary =1 if household_relations== "1|3"
replace house_rels_binary =1 if household_relations== "1|3|4"
replace house_rels_binary =1 if household_relations== "1|3|4|7"
replace house_rels_binary =1 if household_relations== "1|3|6"
replace house_rels_binary =1 if household_relations== "1|3|7"
replace house_rels_binary =1 if household_relations== "1|3|8"
replace house_rels_binary =1 if household_relations== "1|4"
replace house_rels_binary =1 if household_relations== "1|4|8"
replace house_rels_binary =1 if household_relations== "1|5"
replace house_rels_binary =1 if household_relations== "1|6"
replace house_rels_binary =1 if household_relations== "1|6|7"
replace house_rels_binary =1 if household_relations== "1|6|8"
replace house_rels_binary =1 if household_relations== "1|7"
replace house_rels_binary =1 if household_relations== "1|7|8"
replace house_rels_binary =1 if household_relations== "1|8"

tab house_rels_binary, missing

*Label house_rels_binary variablew
label variable house_rels_binary "Live with spouse/partner (yes/no)"

		*Create value labels for house_rels_binary

label define house_rels_binary_lb 1 "Yes" 0"No"
label values house_rels_binary house_rels_binary_lb
tab house_rels_binary, missing



*********************************************************************************

*Explore continuous/discrete variables treated as continuous
***********************************************************


**Continuous

*depriv
summarize depriv
histogram depriv //Not normally distributed. (right/positive skew = tail to the right)
inspect depriv
summarize depriv, detail // Median: 13.59. 25% 7.85. 75% 23.85.

*bmi
summarize bmi
histogram bmi // Not normally distributed. (slight right/positive skew)
inspect bmi
summarize bmi, detail // Median: 26.83. 25% 24.22. 75% 30.00


**Discrete 

*age_assess
rename age_asess age_assess
summarize age_assess
histogram age_assess // Not normally distributed. (left/negative skew = tail to the left)
inspect age_assess
summarize age_assess, detail // Median: 58. 25%: 50. 75%: 63.


*sleep_dur
tab sleep_dur, missing
recode sleep_dur (-3 -1 =.)
tab sleep_dur, missing
summarize sleep_dur //Min = 1 hour. Max = 23 hours!
histogram sleep_dur // Not normally distributed. (right/positive skew = tail to the right) 
inspect sleep_dur
summarize sleep_dur, detail
	*Remove extreme values of sleep duration (>18 hours & <3) as per this paper https://link.springer.com/article/10.1007/s10654-023-00981-x which says "Extreme responses of less than 3 h or more than 18 h were excluded to avoid improbable short or long sleep durations confounded by poor health."
replace sleep_dur =. if sleep_dur >18
replace sleep_dur =. if sleep_dur <3
tab sleep_dur, missing

*household no
tab household_no, missing
recode household_no (-3 -1 =.)
tab household_no, missing
summarize household_no // min 1. max 57!
histogram household_no // not normally distributed (right/positive skew)
inspect household_no
summarize household_no, detail // Median:2. 25%:2. 75%:3.

*met_mins
summarize met_mins
histogram met_mins //not normally distributed (right/positive skew)
inspect met_mins
summarize met_mins, detail // Median: 1815. 25%: 813. 75%:3679.

*coffee
tab coffee
recode coffee (-3 -1 =.)
recode coffee (-10 =0) //-10 is less than 1 cup.
tab coffee
summarize coffee // min:0. max: 60.
histogram coffee // not normally distributed (right/positive skew)
inspect coffee
summarize coffee, detail //Median: 3. 25%:0. 75%:3.

*tea
tab tea
label variable tea "tea intake (cups per day)"
recode tea (-3 -1 =.)
recode tea (-10 =0) //-10 is less than 1 cup.
tab tea
summarize tea // min: 0. Max:81.
histogram tea // not normally distributed (right/positive skew)
inspect tea
summarize tea, detail // Median: 3. 25%:1. 75%5. 

*Check dataset looks ok
describe
*obs: 164,184. vars: 36.


*Save & Upload
save pheno_primarycare2.dta, replace
!dx upload pheno_primarycare2.dta


*****************************************************************************

*Add snoring variable to dataset
************************************


*Import snoring csv file
import delimited /mnt/project/snoring.csv, clear
describe
list in 1/5

*rename & label snoring variable
rename v2 snoring
tab snoring, missing
recode snoring (-3 -1 =.)
label variable snoring "Snore (1210)"
label define snoring_lb 1 "Yes" 2 "No"
label values snoring snoring_lb
tab snoring, missing


*Save phenotype data as stata .dta file
save snoring

*Upload saved .dta file to project in DNA Nexus
!dx upload snoring.dta


********************************************************************************
***Need to go out of JupyterLab and then back in again to use .dta file saved in DNA Nexus project

**Merge snoring data with main dataset
*Open primary/phenotype main dataset (use as master)
set more off
use /mnt/project/pheno_primarycare2.dta, clear
describe


*Merge main dataset (master) with snoring data (using)

merge 1:1 eid using /mnt/project/snoring.dta
*Result                           # of obs.
*    -----------------------------------------
*    not matched                       338,203
*        from master                         0  (_merge==1)
*        from using                    338,203  (_merge==2)
*
*    matched                           164,184  (_merge==3)
*    -----------------------------------------


rename _merge _merge_snoring
describe


*Just keep those in registration dataset (master)
drop if _merge_snoring ==2 //drop if observation appeared in snoring (using) dataset only.
describe //164,184 obs. 38 vars
drop _merge_snoring
describe //164,184 obs. 37 vars.

*Save & upload
save pheno_primarycare3.dta, replace
!dx upload pheno_primarycare3.dta
