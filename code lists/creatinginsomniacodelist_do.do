************************************************************************

*Creating insomnia GP event (diagnosis/symptom) code list using Flo's scripts
*Date started 16/01/23
*Date finalised
*Author: Mel de Lange 

************************************************************************

* Questions for clinician

	* Search terms are a rationalised version of list from Hollie et al (2019) https://doi.org/10.1080/13607863.2019.1695737
	* Have all the relevant codes been captured by the search terms?
	* Are there any irrelavent codes in the lists produced by the current search terms that need removing?

***********************************************************************************

* Start logging


	log using "$logdir\creatinginsomniacodelist_log.log", replace

* Prepare environment
	
		clear
		set more off
		set linesize 100
		
* Load packages
		
		ssc install distinct
		


*Load data (UK Biobank Read 3 codes using the global macro I have created: "readcodesdir" 
use "$readcodesdir\ukb_read3.dta", clear

browse

** Make all descriptions lower case	
		
		gen Z=lower(desc)
		drop desc
		rename Z desc
		label variable desc "Read term description"
		
browse		


*************************************************************************
*****NEED TO RUN STEP 1 AND 2 TOGETHER FOR IT TO WORK!

*Step 1 - defining search terms using list of indications searching Read codes and descriptions

	*Define search terms for the local macro "insomnia"
	local insomnia " "*insomn*" "*sleep*" "wak*" "
	
**************************************************************************

* Step 2 - Word search of UK Biobank Read3 Codes from: Lookups & Mapping Files Version 3 – May 2021
	
	* Create a variable for identifying descriptions in each class
	
foreach x in insomnia {
		
		gen `x'=.
	
	}
	
	* Update marker where description matches search terms
	
		foreach x in insomnia {
			foreach term in desc {
				foreach word in ``x''{
           
		   replace `x' = 1 if strmatch(`term', "`word'")
          
				}
			}
		}	
		

tab insomnia
*Gives us 385 codes for insomnia.

* Check each of the markers against description & flag potentially irrelevant codes
	
	gen marker =.
	
	browse desc if insomnia==1
	
	* Medical codes to potentially remove: 
	*Have cut codes relating to sleep clinic/treatment as could be any sleep disorder not just insomnia.
	*Have cut does relating sleep-wake patterns cycles as that's a different disorder.
	replace marker = 1 if insomnia==1 & regexm(desc, "sleeping-car")
	replace marker = 1 if insomnia==1 & regexm(desc, "studies")
	replace marker = 1 if insomnia==1 & regexm(desc, "asthma")
	replace marker = 1 if insomnia==1 & regexm(desc, "sickness")
	replace marker = 1 if insomnia==1 & regexm(desc, "hypersomnia")
	replace marker = 1 if insomnia==1 & regexm(desc, "walking")
	replace marker = 1 if insomnia==1 & regexm(desc, "terrors")
	replace marker = 1 if insomnia==1 & regexm(desc, "drunkness")
	replace marker = 1 if insomnia==1 & regexm(desc, "rapid eye")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep wake schedule")
	replace marker = 1 if insomnia==1 & regexm(desc, "apnoea")
	replace marker = 1 if insomnia==1 & regexm(desc, "poison")
	replace marker = 1 if insomnia==1 & regexm(desc, "traffic")
	replace marker = 1 if insomnia==1 & regexm(desc, "overdose")
	replace marker = 1 if insomnia==1 & regexm(desc, "epilep")
	replace marker = 1 if insomnia==1 & regexm(desc, "study")
	replace marker = 1 if insomnia==1 & regexm(desc, "eeg")
	replace marker = 1 if insomnia==1 & regexm(desc, "language")
	replace marker = 1 if insomnia==1 & regexm(desc, "obstructive pulmonary")
	replace marker = 1 if insomnia==1 & regexm(desc, "non-organic sleep disorders")
	replace marker = 1 if insomnia==1 & regexm(desc, "unspecified non-organic")
	replace marker = 1 if insomnia==1 & regexm(desc, "drunkenness")
	replace marker = 1 if insomnia==1 & regexm(desc, "arousal dysfunction")
	replace marker = 1 if insomnia==1 & regexm(desc, "reversed")
	replace marker = 1 if insomnia==1 & regexm(desc, "inversion")
	replace marker = 1 if insomnia==1 & regexm(desc, "dreams")
	replace marker = 1 if insomnia==1 & regexm(desc, "other non-organic")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep disorder nos")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep-wake schedule")
	replace marker = 1 if insomnia==1 & regexm(desc, "other nonorganic")
	replace marker = 1 if insomnia==1 & regexm(desc, "other sleep disorders")
	replace marker = 1 if insomnia==1 & regexm(desc, "menopausal")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep disturbances")
	replace marker = 1 if insomnia==1 & regexm(desc, "rhythm")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep dysfunction")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleeping pill")
	replace marker = 1 if insomnia==1 & regexm(desc, "wake island")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleeping out")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleeping rough")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleeping in")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleeping at")
	replace marker = 1 if insomnia==1 & regexm(desc, "observations")
	replace marker = 1 if insomnia==1 & regexm(desc, "leaving")
	replace marker = 1 if insomnia==1 & regexm(desc, "waking patient")
	replace marker = 1 if insomnia==1 & regexm(desc, "positioning")
	replace marker = 1 if insomnia==1 & regexm(desc, "talking")
	replace marker = 1 if insomnia==1 & regexm(desc, "fatal")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep-wake disorder")
	replace marker = 1 if insomnia==1 & regexm(desc, "excessive")
	replace marker = 1 if insomnia==1 & regexm(desc, "too much")
	replace marker = 1 if insomnia==1 & regexm(desc, "excess")
	replace marker = 1 if insomnia==1 & regexm(desc, "hypopnoea")
	replace marker = 1 if insomnia==1 & regexm(desc, "delayed sleep phase")
	replace marker = 1 if insomnia==1 & regexm(desc, "non-24 hour")
	replace marker = 1 if insomnia==1 & regexm(desc, "head banging")
	replace marker = 1 if insomnia==1 & regexm(desc, "erections")
	replace marker = 1 if insomnia==1 & regexm(desc, "respiratory")
	replace marker = 1 if insomnia==1 & regexm(desc, "dystonia")
	replace marker = 1 if insomnia==1 & regexm(desc, "nasendoscopy")
	replace marker = 1 if insomnia==1 & regexm(desc, "accident")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep behaviour")
	replace marker = 1 if insomnia==1 & regexm(desc, "walk")
	replace marker = 1 if insomnia==1 & regexm(desc, "automatism")
	replace marker = 1 if insomnia==1 & regexm(desc, "keeps falling asleep")
	replace marker = 1 if insomnia==1 & regexm(desc, "asleep")
	replace marker = 1 if insomnia==1 & regexm(desc, "transients")
	replace marker = 1 if insomnia==1 & regexm(desc, "breathing")
	replace marker = 1 if insomnia==1 & regexm(desc, "erection")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep disturbance")
	replace marker = 1 if insomnia==1 & regexm(desc, "disturbing")
	replace marker = 1 if insomnia==1 & regexm(desc, "waking")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep disorders")
	replace marker = 1 if insomnia==1 & regexm(desc, "non-organic sleep disorder")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleepiness")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep problem")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep-wake pattern")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep-wake cycle")
	replace marker = 1 if insomnia==1 & regexm(desc, "wakefield")
	replace marker = 1 if insomnia==1 & regexm(desc, "bruxism")
	replace marker = 1 if insomnia==1 & regexm(desc, "paralysis")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep starts")
	replace marker = 1 if insomnia==1 & regexm(desc, "before sleeping")
	replace marker = 1 if insomnia==1 & regexm(desc, "temporal periods")
	replace marker = 1 if insomnia==1 & regexm(desc, "during sleep")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep pattern")
	replace marker = 1 if insomnia==1 & regexm(desc, "eating")
	replace marker = 1 if insomnia==1 & regexm(desc, "myoclonus")
	replace marker = 1 if insomnia==1 & regexm(desc, "position")
	replace marker = 1 if insomnia==1 & regexm(desc, "safe sleeping")
	replace marker = 1 if insomnia==1 & regexm(desc, "rough sleeper")
	replace marker = 1 if insomnia==1 & regexm(desc, "capsule")
	replace marker = 1 if insomnia==1 & regexm(desc, "tablet")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleepia")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep aid")
	replace marker = 1 if insomnia==1 & regexm(desc, "oversleeps")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep disorders")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleepy")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleeping pattern")
	replace marker = 1 if insomnia==1 & regexm(desc, "clinic")
	replace marker = 1 if insomnia==1 & regexm(desc, "able to sleep")
	replace marker = 1 if insomnia==1 & regexm(desc, "signposting")
	replace marker = 1 if insomnia==1 & regexm(desc, "sleep management")
	replace marker = 1 if insomnia==1 & regexm(desc, "therapy")
	replace marker = 1 if insomnia==1 & regexm(desc, "education")
	replace marker = 1 if insomnia==1 & regexm(desc, "interventions")
	replace marker = 1 if insomnia==1 & regexm(desc, "intrusions")
	replace marker = 1 if insomnia==1 & regexm(desc, "nonorganic sleep disorder, unspecified")
	replace marker = 1 if insomnia==1 & regexm(desc, "melatonin")
	replace marker = 1 if insomnia==1 & regexm(desc, "interfere")
	replace marker = 1 if insomnia==1 & regexm(desc, "advice")
	
	
	
* Codes to keep in to check
		browse desc if insomnia==1 & marker==.
		
		**Gives us 76 observations (codes) *Really 75 codes as need to get rid of general 'sleep' code.
		
		* Codes to take out to check
		browse desc if marker==1
	* 309 observations (codes) cut. *Really 310 when general 'sleep' code cut.
	
	
*Prepare as codelist 
keep if insomnia==1	

*Save codelists as excel & stata files for checking

	
export excel "$insomniacodesdir\insomnia_to_check.xlsx", firstrow(varlabels) replace

save "$insomniacodesdir\insomnia_to_check.dta", replace	
	