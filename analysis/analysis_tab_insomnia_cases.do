*Tabulation of primary care and self-reported insomnia cases
************************************************************

*Open dataset
set more off
use /mnt/project/pheno_primarycare7.dta, clear

*Tabulate primary care insomnia cases by self-reported insomnia cases
tab pc_insomniacase sr_insomniacase, row col




