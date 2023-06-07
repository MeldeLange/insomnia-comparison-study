*Graphs of people who self report "usually" and "sometimes & usually" having trouble getting to sleep/waking up, by age and sex.
**********************************************************************************************************************************

*1. Set up data
**************

*Open dataset
set more off
use /mnt/project/pheno_primarycare6.dta, clear

*Check format of self report insomnia variable
tab sr_insomniacase

*Create new insomnia variable where both usually & sometimes count as a case. 0 if never/rarely. 1 if sometimes or ususally.
tab insomnia
gen insomniacase_someus = insomnia 
recode insomniacase_someus  (1=0) (2=1) (3=1)
label define insomniacase_someus_lab 1"Yes" 0 "No"
label values insomniacase_someus  insomniacase_someus_lab
tab insomniacase_someus 

*Save & upload
save pheno_primarycare7.dta, replace
!dx upload pheno_primarycare7.dta


**************************************************************************************************************

*2. Pie charts of insomnia frequency	
*********************************

*Open dataset
set more off
use /mnt/project/pheno_primarycare7.dta, clear

**Case as only those who say 'usually' have symptoms
*******************************************************
*Total % in each insomnia category
graph pie, over(sr_insomniacase) plabel(_all percent, size(*1.2) format(%4.1f)) graphregion(color(white)) bgcolor(white) subtitle("Case = usually")
*This specifies that the percentages appear on the pie chart, that the font size of the percentages is slightly bigger than normal, that the percentages appear with 1 decimal place & that the graph region & background is white rather than stata blue.

*If need black & white version code is:
*graph pie, over(insomnia) plabel(_all percent, size(*1.2) format(%4.1f)) graphregion(color(white)) bgcolor(white) scheme(s2mono)

*Save as normal graph
	graph save "usually_insomnia_pie", replace
	*Upload 
	!dx upload usually_insomnia_pie.gph

**NB can't save as a high quality metafile in DNA Nexus: Error: "Stata for Unix cannot create wmf files" but can do this in normal stata once graph has been downloaded.	
	
	
**Case as those who say 'usually or sometimes' have symptoms.
*************************************************************

*Total % in each insomnia category
graph pie, over(insomniacase_someus) plabel(_all percent, size(*1.2) format(%4.1f)) graphregion(color(white)) bgcolor(white) subtitle("Case = usually/sometimes")


*Save as normal graph
	graph save "sometimesusually_insomnia_pie", replace
	*Upload 
	!dx upload sometimesusually_insomnia_pie.gph
	

*Combine insomnia pie graphs
graph combine usually_insomnia_pie.gph sometimesusually_insomnia_pie.gph, graphregion(color(white))

*Save & upload combined graph
graph save "combined_piecharts", replace
!dx upload combined_piecharts.gph

	
*************************************************************************************************************************


*3. Stacked bar charts percentages of insomnia cases by age & sex
*****************************************************************


*Percentage in each insomnia group by age

*Insomnia case = usually
graph bar (count) eid, over(sr_insomniacase) over(age_assess_cat) asyvars stack percentages graphregion(color(white)) bgcolor(white) ytitle(Percent) yscale(titlegap(1)) blabel(bar, color(white) position(inside) format(%4.1f)) ylabel(, nogrid) subtitle("Case = usually")
*Save as normal graph & upload
	graph save "usually_insomnia_by_age", replace
	!dx upload usually_insomnia_by_age.gph
	
		*NB: ylabel(, nogrid) gets rid of horizontal graph lines.

*Insomnia case = usually and sometimes
graph bar (count) eid, over(insomniacase_someus) over(age_assess_cat) asyvars stack percentages graphregion(color(white)) bgcolor(white) ytitle(Percent) yscale(titlegap(1)) blabel(bar, color(white) position(inside) format(%4.1f)) ylabel(, nogrid) subtitle("Case = usually/sometimes")
*Save as normal graph & upload
	graph save "sometimesusually_insomnia_by_age", replace
	!dx upload sometimesusually_insomnia_by_age.gph
	
		*NB: ylabel(, nogrid) gets rid of horizontal graph lines.
		

*Combine graphs
graph combine usually_insomnia_by_age.gph sometimesusually_insomnia_by_age.gph, graphregion(color(white))

*Save & upload combined graph
graph save "combined_insomnia_by_age", replace
!dx upload combined_insomnia_by_age.gph

		
*************************		
		
*Percentage in each insomnia group by sex

*Insomnia case = usually
graph bar (count) eid, over(sr_insomniacase) over(sex) asyvars stack percentages graphregion(color(white)) bgcolor(white) ytitle(Percent) yscale(titlegap(1)) blabel(bar, color(white) position(inside) format(%4.1f)) ylabel(, nogrid) subtitle("Case = usually")
*Save as normal graph & upload
	graph save "usually_insomnia_by_sex", replace
	!dx upload usually_insomnia_by_sex.gph
	
*Insomnia case = usually and sometimes
graph bar (count) eid, over(insomniacase_someus) over(sex) asyvars stack percentages graphregion(color(white)) bgcolor(white) ytitle(Percent) yscale(titlegap(1)) blabel(bar, color(white) position(inside) format(%4.1f)) ylabel(, nogrid) subtitle("Case = usually/sometimes")
*Save as normal graph & upload
	graph save "sometimesusually_insomnia_by_sex", replace
	!dx upload sometimesusually_insomnia_by_sex.gph
	
*Combine graphs
graph combine usually_insomnia_by_sex.gph sometimesusually_insomnia_by_sex.gph, graphregion(color(white))

**Save & upload combined graph
graph save "combined_insomnia_by_sex", replace
!dx upload combined_insomnia_by_sex.gph
