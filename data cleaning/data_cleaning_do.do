*DATA CLEANINING - PHENOTYPE DATA
**************************************
**************************************

*Open phenotype data
use insomnia_pheno.dta, clear
describe

***************************************************************
*Renaming & labelling variables

*Rename variables

rename v2 sex
rename v3 depriv
rename v4 date_assess
rename v5 age
rename v6 income
rename v7 ethnicity
rename v8 insomnia
rename v9 chrono
rename v10 bmi
rename v11 overall_health
rename v12 worrier
rename v13 depress
rename v14 employ
rename v15 quals
rename v16 household_relations
rename v17 pop_dens
rename v18 night_shift
rename v19 sleep_dur
rename v20 getting_up
rename v21 nap
rename v22 day_dozing
rename v23 household_no

describe

*Relabel variables
label variable eid "participant id"
label variable sex "sex at recruitment category (31)"
label variable depriv "townsend deprivation index at recruitment (189)"
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

*Check naming & labeling
describe

******************************************************************************************
*Clean & generate insomnia variables

*Clean insomnia variable
	*Set 'prefer not to answer' (-3) as missing & add value labels.
tab insomnia, missing
recode insomnia (-3 = .)
tab insomnia, missing 
	
*Generate 2 new insomnia variables to be used in analyses.
	*1. To be used in main analysis. 0 if never/sometimes. 1 if usually
		*Generate new variable
		gen insomnia_main = insomnia 
		tab insomnia_main, missing
		label variable insomnia_main "Insomnia for main analyses. 1= usually 0=sometimes & never/rarely"
		*Recode categories (previously 3 = usually, 2 = sometimes, 1 = never/rarely)
		recode insomnia_main (3 = 1) (2 = 0) (1 = 0)
		*Add value labels
		label define insomnia_lab 1 "Yes" 0 "No"
		label values insomnia_main insomnia_lab
		tab insomnia_main, missing
	
	
	*2. To be used in sensitivity analysis. 0 if never. 1 if usually/sometimes.
		*Generate new variable
		gen insomnia_sens = insomnia 
		tab insomnia_sens, missing
		label variable insomnia_sens "Insomnia for sensitivity analyses. 1= usually & sometimes 0=never/rarely"
		*Recode categories (previously 3 = usually, 2 = sometimes, 1 = never/rarely)
		recode insomnia_sens (3 = 1) (2 = 1) (1 = 0)
		*Add value labels
		label values insomnia_sens insomnia_lab
		tab insomnia_sens, missing
		
*Check insomnia variables look ok
describe
codebook insomnia_main
codebook insomnia_sens

*****************************************************************************************
	
*Save as different file name
save insomnia_pheno_cleaned.dta, replace

*Upload to DNA Nexus repository
!dx upload insomnia_pheno_cleaned.dta