
***************************************************************************

* Creating a codelist for insomnia drugs for Dr Sophie Eastwood to check.

* Date started: 18/01/2023

* Date checked:

* Author: Mel de Lange

***************************************************************************

* Questions for clinician

	* Search terms (drug substances) were taken from Hollie et al (2019) https://doi.org/10.1080/13607863.2019.1695737 https://github.com/zurfarosa/demres/blob/v1.0/common/druglists.py
	* Have all the relevant codes been captured by the search terms?
	* Are there any irrelavent codes in the lists produced by the current search terms that need removing?
	

***********************************************************************************

* Start logging


	log using "$logdir\creatinginsomniaprescriptionscodelist_log.log", replace
	
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
	

*****************************************************************************	
* Step 2 - Word search of UK Biobank BNF Codes from: Lookups & Mapping Files Version 3 – May 2021
	
	* Create a variable for identifying descriptions in each class
	
foreach x in chloralhydrate clomethiazole diazepam flurazepam flunitrazepam loprazolam lorazepam lormetazepam melatonin nitrazepam oxazepam temazepam triclofossodium zaleplon zolpidem zopiclone{
		
		gen `x'=.
	
	}	
	
	
	* Update marker where productname matches search terms
		
		foreach x in chloralhydrate clomethiazole diazepam flurazepam flunitrazepam loprazolam lorazepam lormetazepam melatonin nitrazepam oxazepam temazepam triclofossodium zaleplon zolpidem zopiclone {
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
	
	
*************************************************************************************	
* Step 3 - drop all terms not captured by the search terms

	keep if chloralhydrate==1 | clomethiazole==1 | diazepam==1 | flurazepam==1 | flunitrazepam==1 | loprazolam==1 | lorazepam==1 | lormetazepam==1 | melatonin==1 | nitrazepam==1 | oxazepam==1 | temazepam==1 | triclofossodium==1 | zaleplon==1 | zolpidem==1 | zopiclone==1
	
	
*Gives us a total of 485 codes.	
		
**************************************************************************

*Save codelists as excel & stata files for checking

	
export excel "$insomniacodesdir\insomniaprescriptions_to_check.xlsx", firstrow(varlabels) replace

save "$insomniacodesdir\insomniaprescriptions_to_check.dta", replace	

********************************************************************************

* Stop logging

	log close
	
***************************************************************************


	