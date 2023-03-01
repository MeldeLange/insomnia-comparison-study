*****************************************************************************************************************

* Amending updated codelist for insomnia GP event (diagnosis/symptom read codes) with Dr Sophie Eastwood's changes 
* Date started: 24/02/2022

* Author: Mel de Lange (amended using PREPArE script)

*****************************************************************************************************************

* Codelist created

	* The codelist created by this do-file is the checked insomnia event codelist (implementing SE changes)

*****************************************************************************************************************


* Start logging

	log using "$logdir\amendinginsomniacodelist_log.log", replace

	
*****************************************************************************************************************
*Load & explore checked code list


* Load in the Excel spreadsheet checked by SE
	import excel "$insomniacodesdir\insomnia_to_check_SVE.xlsx", firstrow clear
	
	count if insomnia==1 //385
	count if keep==1  //148
	count if keep_broader==1 //255
	
	drop if keep_broader!=1
	drop keep_broader
	count //255
	
	* Investigate duplicates and delete if genuine duplicates
	ssc install unique
		unique readcode //n unique values = 181. n records = 255. 
*UK Biobank data dictionary has duplicate read codes with different
*descriptions for the same code. 
*First occurence of code incorporates subsequent descriptions. e.g:
*1st occurence of code: insomnia & somnolesence.
*2nd occurence: insomnia. 
*3rd occurence: somnolesence. 
*Therefore we will remove all duplicates except the first occurence. 

	browse
	
	duplicates list readcode
	duplicates drop readcode, force //74 observations deleted
	count //181
	browse
	
**********************************************************
**Save broader codelist ready to use in data cleaning
rename Readtermdescription desc


save "$insomniacodesdir\insomnia_checkedcodelists.dta", replace

preserve

keep readcode desc


save "$insomniacodesdir\insomniabroad_finalcodelist.dta", replace



*Save narrower codelist ready to use in data cleaning

restore


preserve
drop if keep!=1
count
unique readcode //n unique values = 107. n records = 107.

keep readcode desc

save "$insomniacodesdir\insomnianarrow_finalcodelist.dta", replace

restore

*****************************************************************************************************************

* Stop logging
	
	log close
	
*****************************************************************************************************************