***analysis_table1_do
**************************

*Install table1_mc
ssc install table1_mc

*help table1_mc

*Open dataset
set more off
use /mnt/project/pheno_primarycare6.dta, clear


*Table 1 with self-report insomnia as the exposure.
*Specify exposure & variables
table1_mc, by(sr_insomniacase) ///
vars( ///
sex bin %4.1f \ ///
age_assess_cat cat %4.1f \ ///
ethnicity cat %4.1f \ ///
income cat %4.1f \ ///
depriv_quart cat %4.1f \ ///
employ_3cats cat %4.1f \ ///
qual_highest cat %4.1f \ ///
household_no_cat cat %4.1f \ ///
house_rels_binary bin %4.1f \ ///
pop_dens cat %4.1f \ ///
pc_insomniacase bin %4.1f \ ///
sr_insomniacase bin %4.1f \ ///
sleep_dur_cats cat %4.1f \ ///
chrono cat %4.1f \ ///
snoring bin %4.1f \ ///
day_dozing cat %4.1f \ ///
nap cat %4.1f \ ///
getting_up cat %4.1f \ ///
night_shift cat %4.1f \ ///
met_mins_quart cat %4.1f \ ///
coffee_cat cat %4.1f \ ///
tea_cat cat %4.1f \ ///
bmi_cat cat %4.1f \ ///
risk bin %4.1f \ ///
smoking cat %4.1f \ ///
alcohol cat %4.1f \ ///
menopause bin %4.1f \ ///
depress cat %4.1f \ ///
worrier bin %4.1f \ ///
overall_health cat %4.1f \ ///
) ///
nospace percent_n onecol total(before) ///
saving("table1_selfreport.xlsx", replace)


*Upload to project
!dx upload table1_selfreport.xlsx



*********************************************

*Table 1 with primary care insomnia as the exposure.
*Use total column from this for table 1 as total sample has value for primary care insomnia case variable (no missing data).
*Specify exposure & variables
table1_mc, by(pc_insomniacase ) ///
vars( ///
sex bin %4.1f \ ///
age_assess_cat cat %4.1f \ ///
ethnicity cat %4.1f \ ///
income cat %4.1f \ ///
depriv_quart cat %4.1f \ ///
employ_3cats cat %4.1f \ ///
qual_highest cat %4.1f \ ///
household_no_cat cat %4.1f \ ///
house_rels_binary bin %4.1f \ ///
pop_dens cat %4.1f \ ///
pc_insomniacase bin %4.1f \ ///
sr_insomniacase bin %4.1f \ ///
sleep_dur_cats cat %4.1f \ ///
chrono cat %4.1f \ ///
snoring bin %4.1f \ ///
day_dozing cat %4.1f \ ///
nap cat %4.1f \ ///
getting_up cat %4.1f \ ///
night_shift cat %4.1f \ ///
met_mins_quart cat %4.1f \ ///
coffee_cat cat %4.1f \ ///
tea_cat cat %4.1f \ ///
bmi_cat cat %4.1f \ ///
risk bin %4.1f \ ///
smoking cat %4.1f \ ///
alcohol cat %4.1f \ ///
menopause bin %4.1f \ ///
depress cat %4.1f \ ///
worrier bin %4.1f \ ///
overall_health cat %4.1f \ ///
) ///
nospace percent_n onecol total(before) ///
saving("table1_primarycare.xlsx", replace)


*Upload to project
!dx upload table1_primarycare.xlsx

************************************************************

*Checking table 1 looks as expected.

*Open dataset
set more off
use /mnt/project/pheno_primarycare6.dta, clear

tab menopause, missing
tab menopause
tab menopause sr_insomniacase, column
tab menopause pc_insomniacase, column

tab pc_insomniacase sr_insomniacase, column
tab sr_insomniacase pc_insomniacase, column
tab sleep_dur_cats sr_insomniacase, column
tab sleep_dur_cats pc_insomniacase, column
