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
label variable risk "tea intake (cups per day) (1488)"

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


*****************************************************************************************
	
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