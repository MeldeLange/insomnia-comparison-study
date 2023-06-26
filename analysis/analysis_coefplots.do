*Create coefficient plots of our stratification table
******************************************************
*Excel spreadsheet downloaded from DNA Nexus & opened in Stata 17.


*Set working directory
cd "$analysisdir"

*Install coefplot package
ssc install coefplot

* Load in the Excel spreadsheet of self-reported & primary care insomnia cases stratified by sociodemographics
import excel "strat_table_combined.xlsx", firstrow clear

browse
describe

*Drop empty observation rows
drop if sr_mean==.
describe //now have 109 obs

*Save as .dta file
save "strat_table_combined.dta", replace


*****************************************************************************************


*Split data into 3 different matrices so that we have 4 separate graphs (105 categories is too much for one graph)

*Graph 1
*********

use "strat_table_combined.dta", clear

keep in 1/24

*Create Matrices

*Turn self-reported prevalence into a matrix
mkmat sr_mean sr_se , matrix(self_prev) rownames(var)
matrix list self_prev
	*Transpose self_prev matrix
	matrix self_prev=self_prev'
	matrix li self_prev
	
*Turn primary care prevalence into a matrix
mkmat pc_mean pc_se , matrix(pc_prev) rownames(var)
matrix list pc_prev
	*Transpose pc_prev matrix
	matrix pc_prev=pc_prev'
	matrix list pc_prev
	
*Create combined plot with self-report & primary care prevalence offset.
coefplot (matrix(self_prev) ,  se(2) msize(tiny) mc(edkblue) ciopts(lc(edkblue) lwidth(vthin)) offset(+0.15)) ///
(matrix(pc_prev) ,  se(2) msize(tiny) ciopts(lwidth(vthin))), graphregion(color(white))  plotregion(lc(white)) grid(none) ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) xtitle ("Insomnia prevalence", size(vsmall)) rescale(100) legend(order (4 2) label (2 "Self-reported") label (4 "Primary care") size(vsmall)) headings(Sex_Female = "{bf:Sex}" Age_Under_45 ="{bf:Age}" Ethnicity_White ="{bf:Ethnicity}" Household_Income_Under_18000 = "{bf:Household Income}"IMD_Quartile_1 ="{bf:Index of Multiple Deprivation}" Emp_Stat_Paid_Self = "{bf:Employment Status}", labsize(vsmall)) coeflabels(Sex_Female="Female" Sex_Male="Male" Age_Under_45="<45" Age_45-54="45-54" Age_55-64="55-64" Age_65_or_Over="65+" Ethnicity_White="White" Ethnicity_Mixed="Mixed" Ethnicity_Asian_Or_Asian_British="Asian/Asian British" Ethnicity_Black_Or_Black_British="Black/Black British" Ethnicity_Chinese="Chinese" Ethnicity_Other="Other" Household_Income_Under_18000="<£18,000" Household_Income_18000_30999="£18,000-£30,999" Household_Income_31000_51999="£31,000-£51,999" Household_Income_52000_100000="£52,000-£100,000" Household_Income_Over_100000=">£100,000" IMD_Quartile_1="Quartile 1" IMD_Quartile_2="Quartile 2" IMD_Quartile_3="Quartile 3" IMD_Quartile_4="Quartile 4" Emp_Stat_Paid_Self="Paid/Self Employment" Emp_Stat_Retired="Retired" Emp_Stat_Other="Other", labsize(vsmall)) 

*Save as stata graph, pdf & windows metafile
graph save "coefplot_1", replace
graph export "coefplot_1.pdf", as(pdf) replace 
graph export "coefplot_1.wmf", replace
graph export "coefplot_1.eps", replace


******************************************************************************************

*Graph 2
**************

use "strat_table_combined.dta", clear

*Keep just observations 25-51.
keep if _n >= 25 & _n <= 51

*Create Matrices

*Turn self-reported prevalence into a matrix
mkmat sr_mean sr_se , matrix(self_prev) rownames(var)
matrix list self_prev
	*Transpose self_prev matrix
	matrix self_prev=self_prev'
	matrix li self_prev
	
*Turn primary care prevalence into a matrix
mkmat pc_mean pc_se , matrix(pc_prev) rownames(var)
matrix list pc_prev
	*Transpose pc_prev matrix
	matrix pc_prev=pc_prev'
	matrix list pc_prev
	
*Create combined plot with self-report & primary care prevalence offset.
coefplot (matrix(self_prev) ,  se(2) msize(tiny) mc(edkblue) ciopts(lc(edkblue) lwidth(vthin)) offset(+0.15)) ///
(matrix(pc_prev) ,  se(2) msize(tiny) ciopts(lwidth(vthin))), graphregion(color(white))  plotregion(lc(white)) grid(none) ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) xtitle ("Insomnia prevalence", size(vsmall)) rescale(100) legend(order (4 2) label (2 "Self-reported") label (4 "Primary care") size(vsmall)) headings (Highest_Qual_None ="{bf:Highest Qualification}" Household_Size_1_Person="{bf:Household Size (People)}" Live_With_Spouse_Or_Partner_No="{bf:Live with Spouse/Partner}" Pop_Dens_Urban ="{bf:Population Density}"  Sleep_Duration_3-4_Hours="{bf:Sleep Duration (Hours)}" Chrono_Def_Morn="{bf:Chronotype}" Snore_No="{bf:Snore}", labsize(vsmall)) coeflabels(Highest_Qual_None="None" Highest_Qual_College_Uni="College/Uni Degree" Highest_Qual_A_AS_Equiv="A/AS Levels" Highest_Qual_O_GCSEs_Equiv="O Levels/GCSEs" Highest_Qual_CSEs_Equiv="CSEs" Highest_Qual_NVQ_HND_HNC_Equiv="NVQ/HND/HNC" Highest_Qual_Other_Prof="Other Professional" Household_Size_1_Person="1" Household_Size_2_People="2" Household_Size_3-5_People="3-5" Household_Size_6_Or_More_People="6+" Live_With_Spouse_Or_Partner_No="No" Live_With_Spouse_Or_Partner_Yes="Yes" Pop_Dens_Urban="Urban" Pop_Dens_Town="Town" Pop_Dens_Rural="Rural"  Sleep_Duration_3-4_Hours="3-4" Sleep_Duration_5-6_Hours="5-6"Sleep_Duration_7-8_Hours="7-8" Sleep_Duration_9_Or_More_Hours="9+" Chrono_Def_Morn="Definite Morning" Chrono_Morn_More="Morning More Than Evening" Chrono_No_Pref="No Preference" Chrono_Eve_More="Evening More Than Morning" Chrono_Def_Eve="Definite Evening" Snore_No="No" Snore_Yes="Yes", labsize(vsmall)) 

*Save as stata graph, pdf, windows metafile & eps
graph save "coefplot_2", replace
graph export "coefplot_2.pdf", as(pdf) replace
graph export "coefplot_2.wmf", replace
graph export "coefplot_2.eps", replace


******************************************************************************************

*Graph 3
**************

use "strat_table_combined.dta", clear

*Keep just observations 52-78
keep if _n >= 52 & _n <= 78

*Create Matrices

*Turn self-reported prevalence into a matrix
mkmat sr_mean sr_se , matrix(self_prev) rownames(var)
matrix list self_prev
	*Transpose self_prev matrix
	matrix self_prev=self_prev'
	matrix li self_prev
	
*Turn primary care prevalence into a matrix
mkmat pc_mean pc_se , matrix(pc_prev) rownames(var)
matrix list pc_prev
	*Transpose pc_prev matrix
	matrix pc_prev=pc_prev'
	matrix list pc_prev
	
	
*Create combined plot with self-report & primary care prevalence offset.
coefplot (matrix(self_prev) ,  se(2) msize(tiny) mc(edkblue) ciopts(lc(edkblue) lwidth(vthin)) offset(+0.15)) ///
(matrix(pc_prev) ,  se(2) msize(tiny) ciopts(lwidth(vthin))), graphregion(color(white))  plotregion(lc(white)) grid(none) ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) xtitle ("Insomnia prevalence", size(vsmall)) rescale(100) legend(order (4 2) label (2 "Self-reported") label (4 "Primary care") size(vsmall)) headings (Doze_Never_Rarely="{bf:Doze/Fall Asleep During Day}" Nap_Day_Never_Rarely="{bf:Nap During The Day}" Getting_Up_Not_At_All_Easy="{bf:Getting Up In Morning}" Night_Shift_Never_Rarely="{bf:Night Shift}" MET_Mins_Q1="{bf:MET Mins/Week}" Coffee_Intake_0-1="{bf:Coffee Intake (Cups/Day)}" Tea_Intake_0-2="{bf:Tea Intake (Cups/Day)}", labsize(vsmall)) coeflabels(Doze_Never_Rarely="Never/Rarely" Doze_Sometimes="Sometimes" Doze_Often="Often" Doze_All_Of_The_Time="All Of The Time" Nap_Day_Never_Rarely="Never/Rarely" Nap_Day_Sometimes="Sometimes" Nap_Day_Usually="Usually" Getting_Up_Not_At_All_Easy="Not At All Easy" Getting_Up_Not_Very_Easy="Not Very Easy" Getting_Up_Fairly_Easy="Fairly Easy" Getting_Up_Very_Easy="Very Easy" Night_Shift_Never_Rarely="Never/Rarely" Night_Shift_Sometimes="Sometimes" Night_Shift_Usually="Usually" Night_Shift_Always="Always" MET_Mins_Q1="Quartile 1" MET_Mins_Q2="Quartile 2" MET_Mins_Q3="Quartile 3" MET_Mins_Q4="Quartile 4" Coffee_Intake_0-1="0-1" Coffee_Intake_2-3="2-3" Coffee_Intake__4-5="4-5" Coffee_Intake__6_Or_More="6+" Tea_Intake_0-2="0-2" Tea_Intake_3-5="3-5" Tea_Intake_6-8="6-8" Tea_Intake_9_Or_More="9+", labsize(vsmall)) 


*Save as stata graph, pdf, windows metafile & eps
graph save "coefplot_3", replace
graph export "coefplot_3.pdf", as(pdf) replace
graph export "coefplot_3.wmf", replace
graph export "coefplot_3.eps", replace

************************************************************************************

*Graph 4
**************

use "strat_table_combined.dta", clear

*Keep just observations 79-105
keep if _n >= 79

*Create Matrices

*Turn self-reported prevalence into a matrix
mkmat sr_mean sr_se , matrix(self_prev) rownames(var)
matrix list self_prev
	*Transpose self_prev matrix
	matrix self_prev=self_prev'
	matrix li self_prev
	
*Turn primary care prevalence into a matrix
mkmat pc_mean pc_se , matrix(pc_prev) rownames(var)
matrix list pc_prev
	*Transpose pc_prev matrix
	matrix pc_prev=pc_prev'
	matrix list pc_prev


*Create combined plot with self-report & primary care prevalence offset.
coefplot (matrix(self_prev) ,  se(2) msize(tiny) mc(edkblue) ciopts(lc(edkblue) lwidth(vthin)) offset(+0.15)) ///
(matrix(pc_prev) ,  se(2) msize(tiny) ciopts(lwidth(vthin))), graphregion(color(white))  plotregion(lc(white)) grid(none) ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) xtitle ("Insomnia prevalence", size(vsmall)) rescale(100) legend(order (4 2) label (2 "Self-reported") label (4 "Primary care") size(vsmall)) headings (BMI_Underweight="{bf:BMI}" Takes_Risks_No="{bf:Takes Risks}" Smoking_Status_Never="{bf:Smoking Status}" Alcohol_Daily_Almost_Daily="{bf:Alcohol Intake}" Menopause_No="{bf:Had Menopause(Women)}" Depressed_Mood_Not_At_All="{bf:Depressed (Last 2 Weeks)}" Worrier_No="{bf:Worrier}" Overall_Health_Rating_Excellent="{bf:Overall Health Rating}", labsize(vsmall)) coeflabels(BMI_Underweight="Underweight" BMI_Healthy_Weight="Healthy Weight" BMI_Overweight="Overweight" BMI_Obese="Obese" Takes_Risks_No="No" Takes_Risks_Yes="Yes" Smoking_Status_Never="Never" Smoking_Status_Previous="Previous" Smoking_Status_Current="Current" Alcohol_Daily_Almost_Daily="Daily/Almost Daily" Alcohol_3-4_Times_A_Week="3-4 Times A Week" Alcohol_Once_Or_Twice_A_Week="Once Or Twice A Week" Alcohol_1-3_Times_A_Month="1-3 Times A Month" Alcohol_Special_Occasions_Only="Special Occasions Only" Alcohol_Never="Never" Menopause_No="No" Menopause_Yes="Yes" Depressed_Mood_Not_At_All="Not At All" Depressed_Mood_Several_Days="Several Days" Depressed_Mood_More_Than_Half="More Than Half The Days" Depressed_Mood_Nearly_Every_Day="Nearly Every Day" Worrier_No="No" Worrier_Yes="Yes" Overall_Health_Rating_Excellent="Excellent" Overall_Health_Rating_Good="Good" Overall_Health_Rating_Fair="Fair" Overall_Health_Rating_Poor="Poor", labsize(vsmall)) 


*Save as stata graph, pdf, windows metafile & eps
graph save "coefplot_4", replace
graph export "coefplot_4.pdf", as(pdf) replace
graph export "coefplot_4.wmf", replace
graph export "coefplot_4.eps", replace

*******************************************************************************
