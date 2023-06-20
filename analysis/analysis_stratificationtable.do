*Create stratification table

*Open dataset
set more off
use /mnt/project/pheno_primarycare7.dta, clear

*Stratify by self-report insomnia case
***************************************

*Set up variables we want (mean, SE, variable name)
gen mean=.
gen se=.
gen var=""
order var mean se

*For sex
********
tabstat  sr_insomniacase, by(sex) stats(mean semean) save
return list

replace var=r(name1) in 1
replace mean=r(Stat1)[1,1] in 1
replace se=r(Stat1)[2,1] in 1

replace var=r(name2) in 2
replace mean=r(Stat2)[1,1] in 2
replace se=r(Stat2)[2,1] in 2

*Check looks ok.
list var mean se in 1/5


*For age
********
tabstat  sr_insomniacase, by(age_assess_cat) stats(mean semean) save
return list

replace var=r(name1) in 3
replace mean=r(Stat1)[1,1] in 3
replace se=r(Stat1)[2,1] in 3

replace var=r(name2) in 4
replace mean=r(Stat2)[1,1] in 4
replace se=r(Stat2)[2,1] in 4

replace var=r(name3) in 5
replace mean=r(Stat3)[1,1] in 5
replace se=r(Stat3)[2,1] in 5

replace var=r(name4) in 6
replace mean=r(Stat4)[1,1] in 6
replace se=r(Stat4)[2,1] in 6


list var mean se in 3/6

*For ethnic group
*****************

tabstat  sr_insomniacase, by(ethnicity) stats(mean semean) save
return list

replace var=r(name1) in 7
replace mean=r(Stat1)[1,1] in 7
replace se=r(Stat1)[2,1] in 7

replace var=r(name2) in 8
replace mean=r(Stat2)[1,1] in 8
replace se=r(Stat2)[2,1] in 8

replace var=r(name3) in 9
replace mean=r(Stat3)[1,1] in 9
replace se=r(Stat3)[2,1] in 9

replace var=r(name4) in 10
replace mean=r(Stat4)[1,1] in 10
replace se=r(Stat4)[2,1] in 10

replace var=r(name5) in 11
replace mean=r(Stat5)[1,1] in 11
replace se=r(Stat5)[2,1] in 11

replace var=r(name6) in 12
replace mean=r(Stat6)[1,1] in 12
replace se=r(Stat6)[2,1] in 12

*By income
**********
tabstat  sr_insomniacase, by(income) stats(mean semean) save
return list

replace var=r(name1) in 13
replace mean=r(Stat1)[1,1] in 13
replace se=r(Stat1)[2,1] in 13

replace var=r(name2) in 14
replace mean=r(Stat2)[1,1] in 14
replace se=r(Stat2)[2,1] in 14

replace var=r(name3) in 15
replace mean=r(Stat3)[1,1] in 15
replace se=r(Stat3)[2,1] in 15

replace var=r(name4) in 16
replace mean=r(Stat4)[1,1] in 16
replace se=r(Stat4)[2,1] in 16

replace var=r(name5) in 17
replace mean=r(Stat5)[1,1] in 17
replace se=r(Stat5)[2,1] in 17


*By deprivation
******************
tabstat  sr_insomniacase, by(depriv_quart) stats(mean semean) save
return list

replace var=r(name1) in 18
replace mean=r(Stat1)[1,1] in 18
replace se=r(Stat1)[2,1] in 18

replace var=r(name2) in 19
replace mean=r(Stat2)[1,1] in 19
replace se=r(Stat2)[2,1] in 19

replace var=r(name3) in 20
replace mean=r(Stat3)[1,1] in 20
replace se=r(Stat3)[2,1] in 20

replace var=r(name4) in 21
replace mean=r(Stat4)[1,1] in 21
replace se=r(Stat4)[2,1] in 21

*By employment
***************
tabstat  sr_insomniacase, by(employ_3cats) stats(mean semean) save
return list

replace var=r(name1) in 22
replace mean=r(Stat1)[1,1] in 22
replace se=r(Stat1)[2,1] in 22

replace var=r(name2) in 23
replace mean=r(Stat2)[1,1] in 23
replace se=r(Stat2)[2,1] in 23

replace var=r(name3) in 24
replace mean=r(Stat3)[1,1] in 24
replace se=r(Stat3)[2,1] in 24

*By qualifications
******************
tabstat  sr_insomniacase, by(qual_highest) stats(mean semean) save
return list

replace var=r(name1) in 25
replace mean=r(Stat1)[1,1] in 25
replace se=r(Stat1)[2,1] in 25

replace var=r(name2) in 26
replace mean=r(Stat2)[1,1] in 26
replace se=r(Stat2)[2,1] in 26

replace var=r(name3) in 27
replace mean=r(Stat3)[1,1] in 27
replace se=r(Stat3)[2,1] in 27

replace var=r(name4) in 28
replace mean=r(Stat4)[1,1] in 28
replace se=r(Stat4)[2,1] in 28

replace var=r(name5) in 29
replace mean=r(Stat5)[1,1] in 29
replace se=r(Stat5)[2,1] in 29

replace var=r(name6) in 30
replace mean=r(Stat6)[1,1] in 30
replace se=r(Stat6)[2,1] in 30

replace var=r(name7) in 31
replace mean=r(Stat7)[1,1] in 31
replace se=r(Stat7)[2,1] in 31


*By household size
tabstat  sr_insomniacase, by(household_no_cat) stats(mean semean) save
return list

replace var=r(name1) in 32
replace mean=r(Stat1)[1,1] in 32
replace se=r(Stat1)[2,1] in 32

replace var=r(name2) in 33
replace mean=r(Stat2)[1,1] in 33
replace se=r(Stat2)[2,1] in 33

replace var=r(name3) in 34
replace mean=r(Stat3)[1,1] in 34
replace se=r(Stat3)[2,1] in 34

replace var=r(name4) in 35
replace mean=r(Stat4)[1,1] in 35
replace se=r(Stat4)[2,1] in 35

*By household relations
tabstat  sr_insomniacase, by(house_rels_binary) stats(mean semean) save
return list

replace var=r(name1) in 36
replace mean=r(Stat1)[1,1] in 36
replace se=r(Stat1)[2,1] in 36

replace var=r(name2) in 37
replace mean=r(Stat2)[1,1] in 37
replace se=r(Stat2)[2,1] in 37

*By population density
tabstat  sr_insomniacase, by(pop_dens) stats(mean semean) save
return list

replace var=r(name1) in 38
replace mean=r(Stat1)[1,1] in 38
replace se=r(Stat1)[2,1] in 38

replace var=r(name2) in 39
replace mean=r(Stat2)[1,1] in 39
replace se=r(Stat2)[2,1] in 39

replace var=r(name3) in 40
replace mean=r(Stat3)[1,1] in 40
replace se=r(Stat3)[2,1] in 40

*By primary insomnia case
tabstat  sr_insomniacase, by(pc_insomniacase) stats(mean semean) save
return list

replace var=r(name1) in 41
replace mean=r(Stat1)[1,1] in 41
replace se=r(Stat1)[2,1] in 41

replace var=r(name2) in 42
replace mean=r(Stat2)[1,1] in 42
replace se=r(Stat2)[2,1] in 42

*By self-report insomnia case
tabstat  sr_insomniacase, by(sr_insomniacase) stats(mean semean) save
return list

replace var=r(name1) in 43
replace mean=r(Stat1)[1,1] in 43
replace se=r(Stat1)[2,1] in 43

replace var=r(name2) in 44
replace mean=r(Stat2)[1,1] in 44
replace se=r(Stat2)[2,1] in 44

*By sleep duration
tabstat  sr_insomniacase, by(sleep_dur_cats) stats(mean semean) save
return list

replace var=r(name1) in 45
replace mean=r(Stat1)[1,1] in 45
replace se=r(Stat1)[2,1] in 45

replace var=r(name2) in 46
replace mean=r(Stat2)[1,1] in 46
replace se=r(Stat2)[2,1] in 46

replace var=r(name3) in 47
replace mean=r(Stat3)[1,1] in 47
replace se=r(Stat3)[2,1] in 47

replace var=r(name4) in 48
replace mean=r(Stat4)[1,1] in 48
replace se=r(Stat4)[2,1] in 48

*By chronotype
***************
tabstat  sr_insomniacase, by(chrono) stats(mean semean) save
return list

replace var=r(name1) in 49
replace mean=r(Stat1)[1,1] in 49
replace se=r(Stat1)[2,1] in 49

replace var=r(name2) in 50
replace mean=r(Stat2)[1,1] in 50
replace se=r(Stat2)[2,1] in 50

replace var=r(name3) in 51
replace mean=r(Stat3)[1,1] in 51
replace se=r(Stat3)[2,1] in 51

replace var=r(name4) in 52
replace mean=r(Stat4)[1,1] in 52
replace se=r(Stat4)[2,1] in 52

replace var=r(name5) in 53
replace mean=r(Stat5)[1,1] in 53
replace se=r(Stat5)[2,1] in 53

*By snoring
***********
tabstat  sr_insomniacase, by(snoring) stats(mean semean) save
return list

replace var=r(name1) in 54
replace mean=r(Stat1)[1,1] in 54
replace se=r(Stat1)[2,1] in 54

replace var=r(name2) in 55
replace mean=r(Stat2)[1,1] in 55
replace se=r(Stat2)[2,1] in 55


*By day dozing
tabstat  sr_insomniacase, by(day_dozing) stats(mean semean) save
return list

replace var=r(name1) in 56
replace mean=r(Stat1)[1,1] in 56
replace se=r(Stat1)[2,1] in 56

replace var=r(name2) in 57
replace mean=r(Stat2)[1,1] in 57
replace se=r(Stat2)[2,1] in 57

replace var=r(name3) in 58
replace mean=r(Stat3)[1,1] in 58
replace se=r(Stat3)[2,1] in 58

replace var=r(name4) in 59
replace mean=r(Stat4)[1,1] in 59
replace se=r(Stat4)[2,1] in 59

*By napping
tabstat  sr_insomniacase, by(nap) stats(mean semean) save
return list

replace var=r(name1) in 60
replace mean=r(Stat1)[1,1] in 60
replace se=r(Stat1)[2,1] in 60

replace var=r(name2) in 61
replace mean=r(Stat2)[1,1] in 61
replace se=r(Stat2)[2,1] in 61

replace var=r(name3) in 62
replace mean=r(Stat3)[1,1] in 62
replace se=r(Stat3)[2,1] in 62

*By getting up in the morning
tabstat  sr_insomniacase, by(getting_up) stats(mean semean) save
return list

replace var=r(name1) in 63
replace mean=r(Stat1)[1,1] in 63
replace se=r(Stat1)[2,1] in 63

replace var=r(name2) in 64
replace mean=r(Stat2)[1,1] in 64
replace se=r(Stat2)[2,1] in 64

replace var=r(name3) in 65
replace mean=r(Stat3)[1,1] in 65
replace se=r(Stat3)[2,1] in 65

replace var=r(name4) in 66
replace mean=r(Stat4)[1,1] in 66
replace se=r(Stat4)[2,1] in 66

*Night shift
tabstat  sr_insomniacase, by(night_shift) stats(mean semean) save
return list

replace var=r(name1) in 67
replace mean=r(Stat1)[1,1] in 67
replace se=r(Stat1)[2,1] in 67

replace var=r(name2) in 68
replace mean=r(Stat2)[1,1] in 68
replace se=r(Stat2)[2,1] in 68

replace var=r(name3) in 69
replace mean=r(Stat3)[1,1] in 69
replace se=r(Stat3)[2,1] in 69

replace var=r(name4) in 70
replace mean=r(Stat4)[1,1] in 70
replace se=r(Stat4)[2,1] in 70

*By met mins per week
tabstat  sr_insomniacase, by(met_mins_quart) stats(mean semean) save
return list

replace var=r(name1) in 71
replace mean=r(Stat1)[1,1] in 71
replace se=r(Stat1)[2,1] in 71

replace var=r(name2) in 72
replace mean=r(Stat2)[1,1] in 72
replace se=r(Stat2)[2,1] in 72

replace var=r(name3) in 73
replace mean=r(Stat3)[1,1] in 73
replace se=r(Stat3)[2,1] in 73

replace var=r(name4) in 74
replace mean=r(Stat4)[1,1] in 74
replace se=r(Stat4)[2,1] in 74

*By coffee intake
tabstat  sr_insomniacase, by(coffee_cat) stats(mean semean) save
return list

replace var=r(name1) in 75
replace mean=r(Stat1)[1,1] in 75
replace se=r(Stat1)[2,1] in 75

replace var=r(name2) in 76
replace mean=r(Stat2)[1,1] in 76
replace se=r(Stat2)[2,1] in 76

replace var=r(name3) in 77
replace mean=r(Stat3)[1,1] in 77
replace se=r(Stat3)[2,1] in 77

replace var=r(name4) in 78
replace mean=r(Stat4)[1,1] in 78
replace se=r(Stat4)[2,1] in 78

*By tea intake
tabstat  sr_insomniacase, by(tea_cat) stats(mean semean) save
return list

replace var=r(name1) in 79
replace mean=r(Stat1)[1,1] in 79
replace se=r(Stat1)[2,1] in 79

replace var=r(name2) in 80
replace mean=r(Stat2)[1,1] in 80
replace se=r(Stat2)[2,1] in 80

replace var=r(name3) in 81
replace mean=r(Stat3)[1,1] in 81
replace se=r(Stat3)[2,1] in 81

replace var=r(name4) in 82
replace mean=r(Stat4)[1,1] in 82
replace se=r(Stat4)[2,1] in 82


*By BMI category
*****************

tabstat  sr_insomniacase, by(bmi_cat) stats(mean semean) save
return list

replace var=r(name1) in 83
replace mean=r(Stat1)[1,1] in 83
replace se=r(Stat1)[2,1] in 83

replace var=r(name2) in 84
replace mean=r(Stat2)[1,1] in 84
replace se=r(Stat2)[2,1] in 84

replace var=r(name3) in 85
replace mean=r(Stat3)[1,1] in 85
replace se=r(Stat3)[2,1] in 85

replace var=r(name4) in 86
replace mean=r(Stat4)[1,1] in 86
replace se=r(Stat4)[2,1] in 86

*By risk
********
tabstat  sr_insomniacase, by(risk) stats(mean semean) save
return list

replace var=r(name1) in 87
replace mean=r(Stat1)[1,1] in 87
replace se=r(Stat1)[2,1] in 87

replace var=r(name2) in 88
replace mean=r(Stat2)[1,1] in 88
replace se=r(Stat2)[2,1] in 88


*By smoking
********
tabstat  sr_insomniacase, by(smoking) stats(mean semean) save
return list

replace var=r(name1) in 89
replace mean=r(Stat1)[1,1] in 89
replace se=r(Stat1)[2,1] in 89

replace var=r(name2) in 90
replace mean=r(Stat2)[1,1] in 90
replace se=r(Stat2)[2,1] in 90

replace var=r(name3) in 91
replace mean=r(Stat3)[1,1] in 91
replace se=r(Stat3)[2,1] in 91

*By alcohol intake
tabstat  sr_insomniacase, by(alcohol) stats(mean semean) save
return list

replace var=r(name1) in 92
replace mean=r(Stat1)[1,1] in 92
replace se=r(Stat1)[2,1] in 92

replace var=r(name2) in 93
replace mean=r(Stat2)[1,1] in 93
replace se=r(Stat2)[2,1] in 93

replace var=r(name3) in 94
replace mean=r(Stat3)[1,1] in 94
replace se=r(Stat3)[2,1] in 94

replace var=r(name4) in 95
replace mean=r(Stat4)[1,1] in 95
replace se=r(Stat4)[2,1] in 95

replace var=r(name5) in 96
replace mean=r(Stat5)[1,1] in 96
replace se=r(Stat5)[2,1] in 96

replace var=r(name6) in 97
replace mean=r(Stat6)[1,1] in 97
replace se=r(Stat6)[2,1] in 97

*By menopause
**************
tabstat  sr_insomniacase, by(menopause) stats(mean semean) save
return list

replace var=r(name1) in 98
replace mean=r(Stat1)[1,1] in 98
replace se=r(Stat1)[2,1] in 98

replace var=r(name2) in 99
replace mean=r(Stat2)[1,1] in 99
replace se=r(Stat2)[2,1] in 99


*Depression
***********
tabstat  sr_insomniacase, by(depress) stats(mean semean) save
return list

replace var=r(name1) in 100
replace mean=r(Stat1)[1,1] in 100
replace se=r(Stat1)[2,1] in 100

replace var=r(name2) in 101
replace mean=r(Stat2)[1,1] in 101
replace se=r(Stat2)[2,1] in 101

replace var=r(name3) in 102
replace mean=r(Stat3)[1,1] in 102
replace se=r(Stat3)[2,1] in 102

replace var=r(name4) in 103
replace mean=r(Stat4)[1,1] in 103
replace se=r(Stat4)[2,1] in 103

*By worrier
***********
tabstat  sr_insomniacase, by(worrier) stats(mean semean) save
return list

replace var=r(name1) in 104
replace mean=r(Stat1)[1,1] in 104
replace se=r(Stat1)[2,1] in 104

replace var=r(name2) in 105
replace mean=r(Stat2)[1,1] in 105
replace se=r(Stat2)[2,1] in 105

*By overall health
***********
tabstat  sr_insomniacase, by(overall_health) stats(mean semean) save
return list

replace var=r(name1) in 106
replace mean=r(Stat1)[1,1] in 106
replace se=r(Stat1)[2,1] in 106

replace var=r(name2) in 107
replace mean=r(Stat2)[1,1] in 107
replace se=r(Stat2)[2,1] in 107

replace var=r(name3) in 108
replace mean=r(Stat3)[1,1] in 108
replace se=r(Stat3)[2,1] in 108

replace var=r(name4) in 109
replace mean=r(Stat4)[1,1] in 109
replace se=r(Stat4)[2,1] in 109



*Just keep variables we need for stratification table

keep var mean se

*Save as excel spreadsheet
export excel strat_table.xlsx, firstrow(varlabels) replace
!dx upload strat_table.xlsx

****************************************************************************

*Stratify by primary care insomnia case
***************************************


*Open dataset
set more off
use /mnt/project/pheno_primarycare7.dta, clear


*Set up variables we want (mean, SE, variable name)
gen mean=.
gen se=.
gen var=""
order var mean se

*For sex
********
tabstat  pc_insomniacase, by(sex) stats(mean semean) save
return list

replace var=r(name1) in 1
replace mean=r(Stat1)[1,1] in 1
replace se=r(Stat1)[2,1] in 1

replace var=r(name2) in 2
replace mean=r(Stat2)[1,1] in 2
replace se=r(Stat2)[2,1] in 2

*Check looks ok.
list var mean se in 1/5


*For age
********
tabstat  pc_insomniacase, by(age_assess_cat) stats(mean semean) save
return list

replace var=r(name1) in 3
replace mean=r(Stat1)[1,1] in 3
replace se=r(Stat1)[2,1] in 3

replace var=r(name2) in 4
replace mean=r(Stat2)[1,1] in 4
replace se=r(Stat2)[2,1] in 4

replace var=r(name3) in 5
replace mean=r(Stat3)[1,1] in 5
replace se=r(Stat3)[2,1] in 5

replace var=r(name4) in 6
replace mean=r(Stat4)[1,1] in 6
replace se=r(Stat4)[2,1] in 6


list var mean se in 3/6

*For ethnic group
*****************

tabstat  pc_insomniacase, by(ethnicity) stats(mean semean) save
return list

replace var=r(name1) in 7
replace mean=r(Stat1)[1,1] in 7
replace se=r(Stat1)[2,1] in 7

replace var=r(name2) in 8
replace mean=r(Stat2)[1,1] in 8
replace se=r(Stat2)[2,1] in 8

replace var=r(name3) in 9
replace mean=r(Stat3)[1,1] in 9
replace se=r(Stat3)[2,1] in 9

replace var=r(name4) in 10
replace mean=r(Stat4)[1,1] in 10
replace se=r(Stat4)[2,1] in 10

replace var=r(name5) in 11
replace mean=r(Stat5)[1,1] in 11
replace se=r(Stat5)[2,1] in 11

replace var=r(name6) in 12
replace mean=r(Stat6)[1,1] in 12
replace se=r(Stat6)[2,1] in 12

*By income
**********
tabstat  pc_insomniacase, by(income) stats(mean semean) save
return list

replace var=r(name1) in 13
replace mean=r(Stat1)[1,1] in 13
replace se=r(Stat1)[2,1] in 13

replace var=r(name2) in 14
replace mean=r(Stat2)[1,1] in 14
replace se=r(Stat2)[2,1] in 14

replace var=r(name3) in 15
replace mean=r(Stat3)[1,1] in 15
replace se=r(Stat3)[2,1] in 15

replace var=r(name4) in 16
replace mean=r(Stat4)[1,1] in 16
replace se=r(Stat4)[2,1] in 16

replace var=r(name5) in 17
replace mean=r(Stat5)[1,1] in 17
replace se=r(Stat5)[2,1] in 17


*By deprivation
******************
tabstat  pc_insomniacase, by(depriv_quart) stats(mean semean) save
return list

replace var=r(name1) in 18
replace mean=r(Stat1)[1,1] in 18
replace se=r(Stat1)[2,1] in 18

replace var=r(name2) in 19
replace mean=r(Stat2)[1,1] in 19
replace se=r(Stat2)[2,1] in 19

replace var=r(name3) in 20
replace mean=r(Stat3)[1,1] in 20
replace se=r(Stat3)[2,1] in 20

replace var=r(name4) in 21
replace mean=r(Stat4)[1,1] in 21
replace se=r(Stat4)[2,1] in 21

*By employment
***************
tabstat  pc_insomniacase, by(employ_3cats) stats(mean semean) save
return list

replace var=r(name1) in 22
replace mean=r(Stat1)[1,1] in 22
replace se=r(Stat1)[2,1] in 22

replace var=r(name2) in 23
replace mean=r(Stat2)[1,1] in 23
replace se=r(Stat2)[2,1] in 23

replace var=r(name3) in 24
replace mean=r(Stat3)[1,1] in 24
replace se=r(Stat3)[2,1] in 24

*By qualifications
******************
tabstat  pc_insomniacase, by(qual_highest) stats(mean semean) save
return list

replace var=r(name1) in 25
replace mean=r(Stat1)[1,1] in 25
replace se=r(Stat1)[2,1] in 25

replace var=r(name2) in 26
replace mean=r(Stat2)[1,1] in 26
replace se=r(Stat2)[2,1] in 26

replace var=r(name3) in 27
replace mean=r(Stat3)[1,1] in 27
replace se=r(Stat3)[2,1] in 27

replace var=r(name4) in 28
replace mean=r(Stat4)[1,1] in 28
replace se=r(Stat4)[2,1] in 28

replace var=r(name5) in 29
replace mean=r(Stat5)[1,1] in 29
replace se=r(Stat5)[2,1] in 29

replace var=r(name6) in 30
replace mean=r(Stat6)[1,1] in 30
replace se=r(Stat6)[2,1] in 30

replace var=r(name7) in 31
replace mean=r(Stat7)[1,1] in 31
replace se=r(Stat7)[2,1] in 31


*By household size
tabstat  pc_insomniacase, by(household_no_cat) stats(mean semean) save
return list

replace var=r(name1) in 32
replace mean=r(Stat1)[1,1] in 32
replace se=r(Stat1)[2,1] in 32

replace var=r(name2) in 33
replace mean=r(Stat2)[1,1] in 33
replace se=r(Stat2)[2,1] in 33

replace var=r(name3) in 34
replace mean=r(Stat3)[1,1] in 34
replace se=r(Stat3)[2,1] in 34

replace var=r(name4) in 35
replace mean=r(Stat4)[1,1] in 35
replace se=r(Stat4)[2,1] in 35

*By household relations
tabstat  pc_insomniacase, by(house_rels_binary) stats(mean semean) save
return list

replace var=r(name1) in 36
replace mean=r(Stat1)[1,1] in 36
replace se=r(Stat1)[2,1] in 36

replace var=r(name2) in 37
replace mean=r(Stat2)[1,1] in 37
replace se=r(Stat2)[2,1] in 37

*By population density
tabstat  pc_insomniacase, by(pop_dens) stats(mean semean) save
return list

replace var=r(name1) in 38
replace mean=r(Stat1)[1,1] in 38
replace se=r(Stat1)[2,1] in 38

replace var=r(name2) in 39
replace mean=r(Stat2)[1,1] in 39
replace se=r(Stat2)[2,1] in 39

replace var=r(name3) in 40
replace mean=r(Stat3)[1,1] in 40
replace se=r(Stat3)[2,1] in 40

*By primary insomnia case
tabstat  pc_insomniacase, by(pc_insomniacase) stats(mean semean) save
return list

replace var=r(name1) in 41
replace mean=r(Stat1)[1,1] in 41
replace se=r(Stat1)[2,1] in 41

replace var=r(name2) in 42
replace mean=r(Stat2)[1,1] in 42
replace se=r(Stat2)[2,1] in 42

*By self-report insomnia case
tabstat  pc_insomniacase, by(sr_insomniacase) stats(mean semean) save
return list

replace var=r(name1) in 43
replace mean=r(Stat1)[1,1] in 43
replace se=r(Stat1)[2,1] in 43

replace var=r(name2) in 44
replace mean=r(Stat2)[1,1] in 44
replace se=r(Stat2)[2,1] in 44

*By sleep duration
tabstat  pc_insomniacase, by(sleep_dur_cats) stats(mean semean) save
return list

replace var=r(name1) in 45
replace mean=r(Stat1)[1,1] in 45
replace se=r(Stat1)[2,1] in 45

replace var=r(name2) in 46
replace mean=r(Stat2)[1,1] in 46
replace se=r(Stat2)[2,1] in 46

replace var=r(name3) in 47
replace mean=r(Stat3)[1,1] in 47
replace se=r(Stat3)[2,1] in 47

replace var=r(name4) in 48
replace mean=r(Stat4)[1,1] in 48
replace se=r(Stat4)[2,1] in 48

*By chronotype
***************
tabstat  pc_insomniacase, by(chrono) stats(mean semean) save
return list

replace var=r(name1) in 49
replace mean=r(Stat1)[1,1] in 49
replace se=r(Stat1)[2,1] in 49

replace var=r(name2) in 50
replace mean=r(Stat2)[1,1] in 50
replace se=r(Stat2)[2,1] in 50

replace var=r(name3) in 51
replace mean=r(Stat3)[1,1] in 51
replace se=r(Stat3)[2,1] in 51

replace var=r(name4) in 52
replace mean=r(Stat4)[1,1] in 52
replace se=r(Stat4)[2,1] in 52

replace var=r(name5) in 53
replace mean=r(Stat5)[1,1] in 53
replace se=r(Stat5)[2,1] in 53

*By snoring
***********
tabstat  pc_insomniacase, by(snoring) stats(mean semean) save
return list

replace var=r(name1) in 54
replace mean=r(Stat1)[1,1] in 54
replace se=r(Stat1)[2,1] in 54

replace var=r(name2) in 55
replace mean=r(Stat2)[1,1] in 55
replace se=r(Stat2)[2,1] in 55


*By day dozing
tabstat  pc_insomniacase, by(day_dozing) stats(mean semean) save
return list

replace var=r(name1) in 56
replace mean=r(Stat1)[1,1] in 56
replace se=r(Stat1)[2,1] in 56

replace var=r(name2) in 57
replace mean=r(Stat2)[1,1] in 57
replace se=r(Stat2)[2,1] in 57

replace var=r(name3) in 58
replace mean=r(Stat3)[1,1] in 58
replace se=r(Stat3)[2,1] in 58

replace var=r(name4) in 59
replace mean=r(Stat4)[1,1] in 59
replace se=r(Stat4)[2,1] in 59

*By napping
tabstat  pc_insomniacase, by(nap) stats(mean semean) save
return list

replace var=r(name1) in 60
replace mean=r(Stat1)[1,1] in 60
replace se=r(Stat1)[2,1] in 60

replace var=r(name2) in 61
replace mean=r(Stat2)[1,1] in 61
replace se=r(Stat2)[2,1] in 61

replace var=r(name3) in 62
replace mean=r(Stat3)[1,1] in 62
replace se=r(Stat3)[2,1] in 62

*By getting up in the morning
tabstat  pc_insomniacase, by(getting_up) stats(mean semean) save
return list

replace var=r(name1) in 63
replace mean=r(Stat1)[1,1] in 63
replace se=r(Stat1)[2,1] in 63

replace var=r(name2) in 64
replace mean=r(Stat2)[1,1] in 64
replace se=r(Stat2)[2,1] in 64

replace var=r(name3) in 65
replace mean=r(Stat3)[1,1] in 65
replace se=r(Stat3)[2,1] in 65

replace var=r(name4) in 66
replace mean=r(Stat4)[1,1] in 66
replace se=r(Stat4)[2,1] in 66

*Night shift
tabstat  pc_insomniacase, by(night_shift) stats(mean semean) save
return list

replace var=r(name1) in 67
replace mean=r(Stat1)[1,1] in 67
replace se=r(Stat1)[2,1] in 67

replace var=r(name2) in 68
replace mean=r(Stat2)[1,1] in 68
replace se=r(Stat2)[2,1] in 68

replace var=r(name3) in 69
replace mean=r(Stat3)[1,1] in 69
replace se=r(Stat3)[2,1] in 69

replace var=r(name4) in 70
replace mean=r(Stat4)[1,1] in 70
replace se=r(Stat4)[2,1] in 70

*By met mins per week
tabstat  pc_insomniacase, by(met_mins_quart) stats(mean semean) save
return list

replace var=r(name1) in 71
replace mean=r(Stat1)[1,1] in 71
replace se=r(Stat1)[2,1] in 71

replace var=r(name2) in 72
replace mean=r(Stat2)[1,1] in 72
replace se=r(Stat2)[2,1] in 72

replace var=r(name3) in 73
replace mean=r(Stat3)[1,1] in 73
replace se=r(Stat3)[2,1] in 73

replace var=r(name4) in 74
replace mean=r(Stat4)[1,1] in 74
replace se=r(Stat4)[2,1] in 74

*By coffee intake
tabstat  pc_insomniacase, by(coffee_cat) stats(mean semean) save
return list

replace var=r(name1) in 75
replace mean=r(Stat1)[1,1] in 75
replace se=r(Stat1)[2,1] in 75

replace var=r(name2) in 76
replace mean=r(Stat2)[1,1] in 76
replace se=r(Stat2)[2,1] in 76

replace var=r(name3) in 77
replace mean=r(Stat3)[1,1] in 77
replace se=r(Stat3)[2,1] in 77

replace var=r(name4) in 78
replace mean=r(Stat4)[1,1] in 78
replace se=r(Stat4)[2,1] in 78

*By tea intake
tabstat  pc_insomniacase, by(tea_cat) stats(mean semean) save
return list

replace var=r(name1) in 79
replace mean=r(Stat1)[1,1] in 79
replace se=r(Stat1)[2,1] in 79

replace var=r(name2) in 80
replace mean=r(Stat2)[1,1] in 80
replace se=r(Stat2)[2,1] in 80

replace var=r(name3) in 81
replace mean=r(Stat3)[1,1] in 81
replace se=r(Stat3)[2,1] in 81

replace var=r(name4) in 82
replace mean=r(Stat4)[1,1] in 82
replace se=r(Stat4)[2,1] in 82


*By BMI category
*****************

tabstat  pc_insomniacase, by(bmi_cat) stats(mean semean) save
return list

replace var=r(name1) in 83
replace mean=r(Stat1)[1,1] in 83
replace se=r(Stat1)[2,1] in 83

replace var=r(name2) in 84
replace mean=r(Stat2)[1,1] in 84
replace se=r(Stat2)[2,1] in 84

replace var=r(name3) in 85
replace mean=r(Stat3)[1,1] in 85
replace se=r(Stat3)[2,1] in 85

replace var=r(name4) in 86
replace mean=r(Stat4)[1,1] in 86
replace se=r(Stat4)[2,1] in 86

*By risk
********
tabstat  pc_insomniacase, by(risk) stats(mean semean) save
return list

replace var=r(name1) in 87
replace mean=r(Stat1)[1,1] in 87
replace se=r(Stat1)[2,1] in 87

replace var=r(name2) in 88
replace mean=r(Stat2)[1,1] in 88
replace se=r(Stat2)[2,1] in 88


*By smoking
********
tabstat  pc_insomniacase, by(smoking) stats(mean semean) save
return list

replace var=r(name1) in 89
replace mean=r(Stat1)[1,1] in 89
replace se=r(Stat1)[2,1] in 89

replace var=r(name2) in 90
replace mean=r(Stat2)[1,1] in 90
replace se=r(Stat2)[2,1] in 90

replace var=r(name3) in 91
replace mean=r(Stat3)[1,1] in 91
replace se=r(Stat3)[2,1] in 91

*By alcohol intake
tabstat  pc_insomniacase, by(alcohol) stats(mean semean) save
return list

replace var=r(name1) in 92
replace mean=r(Stat1)[1,1] in 92
replace se=r(Stat1)[2,1] in 92

replace var=r(name2) in 93
replace mean=r(Stat2)[1,1] in 93
replace se=r(Stat2)[2,1] in 93

replace var=r(name3) in 94
replace mean=r(Stat3)[1,1] in 94
replace se=r(Stat3)[2,1] in 94

replace var=r(name4) in 95
replace mean=r(Stat4)[1,1] in 95
replace se=r(Stat4)[2,1] in 95

replace var=r(name5) in 96
replace mean=r(Stat5)[1,1] in 96
replace se=r(Stat5)[2,1] in 96

replace var=r(name6) in 97
replace mean=r(Stat6)[1,1] in 97
replace se=r(Stat6)[2,1] in 97

*By menopause
**************
tabstat  pc_insomniacase, by(menopause) stats(mean semean) save
return list

replace var=r(name1) in 98
replace mean=r(Stat1)[1,1] in 98
replace se=r(Stat1)[2,1] in 98

replace var=r(name2) in 99
replace mean=r(Stat2)[1,1] in 99
replace se=r(Stat2)[2,1] in 99


*Depression
***********
tabstat  pc_insomniacase, by(depress) stats(mean semean) save
return list

replace var=r(name1) in 100
replace mean=r(Stat1)[1,1] in 100
replace se=r(Stat1)[2,1] in 100

replace var=r(name2) in 101
replace mean=r(Stat2)[1,1] in 101
replace se=r(Stat2)[2,1] in 101

replace var=r(name3) in 102
replace mean=r(Stat3)[1,1] in 102
replace se=r(Stat3)[2,1] in 102

replace var=r(name4) in 103
replace mean=r(Stat4)[1,1] in 103
replace se=r(Stat4)[2,1] in 103

*By worrier
***********
tabstat  pc_insomniacase, by(worrier) stats(mean semean) save
return list

replace var=r(name1) in 104
replace mean=r(Stat1)[1,1] in 104
replace se=r(Stat1)[2,1] in 104

replace var=r(name2) in 105
replace mean=r(Stat2)[1,1] in 105
replace se=r(Stat2)[2,1] in 105

*By overall health
***********
tabstat  pc_insomniacase, by(overall_health) stats(mean semean) save
return list

replace var=r(name1) in 106
replace mean=r(Stat1)[1,1] in 106
replace se=r(Stat1)[2,1] in 106

replace var=r(name2) in 107
replace mean=r(Stat2)[1,1] in 107
replace se=r(Stat2)[2,1] in 107

replace var=r(name3) in 108
replace mean=r(Stat3)[1,1] in 108
replace se=r(Stat3)[2,1] in 108

replace var=r(name4) in 109
replace mean=r(Stat4)[1,1] in 109
replace se=r(Stat4)[2,1] in 109



*Just keep variables we need for stratification table

keep var mean se

*Save as excel spreadsheet
export excel strat_table_pc.xlsx, firstrow(varlabels) replace
!dx upload strat_table_pc.xlsx


