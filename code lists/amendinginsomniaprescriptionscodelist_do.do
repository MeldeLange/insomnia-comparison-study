
***************************************************************************

* Amending creation of a codelist for insomnia drugs after Dr Sophie Eastwood has checked original

* Date started: 24/02/2023

* Date run:27/02/2023

* Author: Mel de Lange

***************************************************************************

* Changes from original codelist created following feedback from GP:


	* Add sedating antihystamines: chlorphenamine, diphenhydramine, promethazine). 
	* Remove drugs using rectal preparations (e.g. rectal diazepam used to treat acute epilepsy not insomnia)
	

***********************************************************************************

* Start logging


	log using "$logdir\amendinginsomniaprescriptionscodelist_log.log", replace
	
*************************************************************************************	
	
* Prepare environment
	
		clear
		set more off
		set linesize 100

	* Load packages
		
		ssc install distinct



*Load data (UK Biobank BNF codes using the global macro I have created: "readcodesdir" 
use "$readcodesdir\ukb_bnf.dta", clear

browse

** Make all descriptions lower case	
		
foreach var of varlist BNF_Presentation BNF_Product BNF_Chemical_Substance  {
		
		gen Z=lower(`var')
		drop `var'
		rename Z `var'
		
	}
	
order BNF_Presentation_Code BNF_Presentation BNF_Product BNF_Chemical_Substance

*Drop variables we don't need
drop BNF_Subparagraph-BNF_Chapter
	
	
*************************************************************************
*****NEED TO RUN STEP 1 AND 2 TOGETHER FOR IT TO WORK!

*Step 1 - defining search terms (16 drug substances)

	*Define search terms for the local macro "insomnia"
	local chloralhydrate " "*chloral hydrate*" "
	local clomethiazole " "*clomethiazole*" "
	local diazepam " "*diazepam*" "
	local flurazepam " "*flurazepam*" "
	local flunitrazepam " "*flunitrazepam*" "
	local loprazolam " "*loprazolam*" "
	local lorazepam " "*lorazepam*" "
	local lormetazepam" "*lormetazepam*" "
	local melatonin" "*melatonin*" "
	local nitrazepam" "nitrazepam*" "
	local oxazepam" "*oxazepam*" "
	local temazepam" "*temazepam*" "
	local triclofossodium" "*triclofos sodium*" "
	local zaleplon" "*zaleplon*" "
	local zolpidem" "*zolpidem*" "
	local zopiclone" "*zopiclone*" "
	local chlorphenamine" "*chlorphenamine*" "
	local diphenhydramine" "*diphenhydramine*" "
	local promethazine" "*promethazine*" "

*****************************************************************************	
* Step 2 - Word search of UK Biobank BNF Codes from: Lookups & Mapping Files Version 3 – May 2021
	
	* Create a variable for identifying descriptions in each class
	
foreach x in chloralhydrate clomethiazole diazepam flurazepam flunitrazepam loprazolam lorazepam lormetazepam melatonin nitrazepam oxazepam temazepam triclofossodium zaleplon zolpidem zopiclone chlorphenamine diphenhydramine promethazine{
		
		gen `x'=.
	
	}	
	
	
	* Update marker where productname matches search terms
		
		foreach x in chloralhydrate clomethiazole diazepam flurazepam flunitrazepam loprazolam lorazepam lormetazepam melatonin nitrazepam oxazepam temazepam triclofossodium zaleplon zolpidem zopiclone chlorphenamine diphenhydramine promethazine {
			foreach term in BNF_Presentation BNF_Product BNF_Chemical_Substance {
				foreach word in ``x''{
           
		   replace `x' = 1 if strmatch(`term', "`word'")
          
				}
			}
		}
		
	*See how many codes we have for each drug substance
	count if chloralhydrate==1
	*49
	count if clomethiazole==1
	*8
	count if diazepam==1 
	*106
	count if flurazepam==1 
	*6
	count if flunitrazepam==1 
	*2
	count if loprazolam==1
	*2
	count if lorazepam==1
	*77
	count if lormetazepam==1
	*8
	count if melatonin==1
	*123
	count if nitrazepam==1
	*30
	count if oxazepam==1
	*17
	count if temazepam==1
	*30
	count if triclofossodium==1==1
	*1
	count if zaleplon==1
	*4
	count if zolpidem==1
	*5
	count if zopiclone==1
	*17
	count if chlorphenamine==1
	*43
	count if diphenhydramine==1
	*86
	count if promethazine==1
	*42
	
	*Check codes have the correct drug substance (Doing this showed that I needed to remove star from in front of *nitrazepam* in local macro otherwise it picked up flunitrazepam codes)
	tab BNF_Chemical_Substance if chloralhydrate==1 
	tab BNF_Chemical_Substance if clomethiazole==1
	tab BNF_Chemical_Substance if diazepam==1 
	tab BNF_Chemical_Substance if flurazepam==1 
	tab BNF_Chemical_Substance if flunitrazepam==1 
	tab BNF_Chemical_Substance if loprazolam==1
	tab BNF_Chemical_Substance if lorazepam==1
	tab BNF_Chemical_Substance if lormetazepam==1
	tab BNF_Chemical_Substance if melatonin==1
	tab BNF_Chemical_Substance if nitrazepam==1
	tab BNF_Chemical_Substance if oxazepam==1
	tab BNF_Chemical_Substance if temazepam==1
	tab BNF_Chemical_Substance if triclofossodium==1==1
	tab BNF_Chemical_Substance if zaleplon==1
	tab BNF_Chemical_Substance if zolpidem==1
	tab BNF_Chemical_Substance if zopiclone==1
	tab BNF_Chemical_Substance if chlorphenamine==1
	tab BNF_Chemical_Substance if diphenhydramine==1
	tab BNF_Chemical_Substance if promethazine==1
	
	
*************************************************************************************	
* Step 3 - drop all terms not captured by the search terms

	keep if chloralhydrate==1 | clomethiazole==1 | diazepam==1 | flurazepam==1 | flunitrazepam==1 | loprazolam==1 | lorazepam==1 | lormetazepam==1 | melatonin==1 | nitrazepam==1 | oxazepam==1 | temazepam==1 | triclofossodium==1 | zaleplon==1 | zolpidem==1 | zopiclone==1 | chlorphenamine==1 | diphenhydramine==1 | promethazine==1
	
	
*Gives us a total of 656 codes.	
count

*Drop drugs using rectal preparations

gen marker =.
replace marker = 1 if regexm(BNF_Presentation, "suppos")
replace marker = 1 if regexm(BNF_Presentation, "rect")

browse if marker==.
browse if marker==1
drop if marker ==1
*37 codes dropped

*Gives us a total of 619 codes
count
		
**************************************************************************

*investigate duplicates
ssc install unique
unique BNF_Presentation_Code //n unique values = 619. n records = 619. 


***************************************************************************

*Save codelists ready to use in data cleaning
rename BNF_Presentation_Code BNFcode
keep BNFcode BNF_Presentation BNF_Product BNF_Chemical_Substance

	

save "$insomniacodesdir\insomniaprescriptions_finalcodelist.dta", replace	

********************************************************************************

* Stop logging

	log close
	
***************************************************************************


	