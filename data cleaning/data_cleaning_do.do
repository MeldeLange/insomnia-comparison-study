*Data cleaning phenotype data
**************************************

*Open phenotype data
use "insomnia_pheno.dta"
describe

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
label variable household_relations "how others in household are related to participant (can choose >1) category (6141)"
label variable pop_dens "home area population density category (20118)"
label variable night_shift "job involves night shift work category (3426)"
label variable sleep_dur "sleep duration in hours (inc naps) category (1160)"
label variable getting_up "how easy find getting up in morning category (1170)"
label variable nap "nap during the day category (1190)"
label variable day_dozing "daytime dozing/sleeping when don't mean to category (1220)"
label variable household_no "number of people in household category (709)"

