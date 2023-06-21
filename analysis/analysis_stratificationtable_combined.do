*Create stratification table

*Open dataset
set more off
use /mnt/project/pheno_primarycare7.dta, clear

*Stratify by self-report insomnia case
***************************************

*Set up variables we want (self-report mean, self-report SE, primary care mean, primary care SE, variable name)
gen sr_mean=.
gen sr_se=.
gen pc_mean=.
gen pc_se =.
gen var=""
order var sr_mean sr_se pc_mean pc_se 

*For sex
********
tabstat  sr_insomniacase, by(sex) stats(mean semean) save
return list

replace var=r(name1) in 1
replace sr_mean=r(Stat1)[1,1] in 1
replace sr_se=r(Stat1)[2,1] in 1

replace var=r(name2) in 2
replace sr_mean=r(Stat2)[1,1] in 2
replace sr_se=r(Stat2)[2,1] in 2

*Check looks ok.
list var sr_mean sr_se in 1/5


*For age
********
tabstat  sr_insomniacase, by(age_assess_cat) stats(mean semean) save
return list

replace var=r(name1) in 3
replace sr_mean=r(Stat1)[1,1] in 3
replace sr_se=r(Stat1)[2,1] in 3

replace var=r(name2) in 4
replace sr_mean=r(Stat2)[1,1] in 4
replace sr_se=r(Stat2)[2,1] in 4

replace var=r(name3) in 5
replace sr_mean=r(Stat3)[1,1] in 5
replace sr_se=r(Stat3)[2,1] in 5

replace var=r(name4) in 6
replace sr_mean=r(Stat4)[1,1] in 6
replace sr_se=r(Stat4)[2,1] in 6


list var sr_mean sr_se in 3/6

*For ethnic group
*****************

tabstat  sr_insomniacase, by(ethnicity) stats(mean semean) save
return list

replace var=r(name1) in 7
replace sr_mean=r(Stat1)[1,1] in 7
replace sr_se=r(Stat1)[2,1] in 7

replace var=r(name2) in 8
replace sr_mean=r(Stat2)[1,1] in 8
replace sr_se=r(Stat2)[2,1] in 8

replace var=r(name3) in 9
replace sr_mean=r(Stat3)[1,1] in 9
replace sr_se=r(Stat3)[2,1] in 9

replace var=r(name4) in 10
replace sr_mean=r(Stat4)[1,1] in 10
replace sr_se=r(Stat4)[2,1] in 10

replace var=r(name5) in 11
replace sr_mean=r(Stat5)[1,1] in 11
replace sr_se=r(Stat5)[2,1] in 11

replace var=r(name6) in 12
replace sr_mean=r(Stat6)[1,1] in 12
replace sr_se=r(Stat6)[2,1] in 12

*By income
**********
tabstat  sr_insomniacase, by(income) stats(mean semean) save
return list

replace var=r(name1) in 13
replace sr_mean=r(Stat1)[1,1] in 13
replace sr_se=r(Stat1)[2,1] in 13

replace var=r(name2) in 14
replace sr_mean=r(Stat2)[1,1] in 14
replace sr_se=r(Stat2)[2,1] in 14

replace var=r(name3) in 15
replace sr_mean=r(Stat3)[1,1] in 15
replace sr_se=r(Stat3)[2,1] in 15

replace var=r(name4) in 16
replace sr_mean=r(Stat4)[1,1] in 16
replace sr_se=r(Stat4)[2,1] in 16

replace var=r(name5) in 17
replace sr_mean=r(Stat5)[1,1] in 17
replace sr_se=r(Stat5)[2,1] in 17


*By deprivation
******************
tabstat  sr_insomniacase, by(depriv_quart) stats(mean semean) save
return list

replace var=r(name1) in 18
replace sr_mean=r(Stat1)[1,1] in 18
replace sr_se=r(Stat1)[2,1] in 18

replace var=r(name2) in 19
replace sr_mean=r(Stat2)[1,1] in 19
replace sr_se=r(Stat2)[2,1] in 19

replace var=r(name3) in 20
replace sr_mean=r(Stat3)[1,1] in 20
replace sr_se=r(Stat3)[2,1] in 20

replace var=r(name4) in 21
replace sr_mean=r(Stat4)[1,1] in 21
replace sr_se=r(Stat4)[2,1] in 21

*By employment
***************
tabstat  sr_insomniacase, by(employ_3cats) stats(mean semean) save
return list

replace var=r(name1) in 22
replace sr_mean=r(Stat1)[1,1] in 22
replace sr_se=r(Stat1)[2,1] in 22

replace var=r(name2) in 23
replace sr_mean=r(Stat2)[1,1] in 23
replace sr_se=r(Stat2)[2,1] in 23

replace var=r(name3) in 24
replace sr_mean=r(Stat3)[1,1] in 24
replace sr_se=r(Stat3)[2,1] in 24

*By qualifications
******************
tabstat  sr_insomniacase, by(qual_highest) stats(mean semean) save
return list

replace var=r(name1) in 25
replace sr_mean=r(Stat1)[1,1] in 25
replace sr_se=r(Stat1)[2,1] in 25

replace var=r(name2) in 26
replace sr_mean=r(Stat2)[1,1] in 26
replace sr_se=r(Stat2)[2,1] in 26

replace var=r(name3) in 27
replace sr_mean=r(Stat3)[1,1] in 27
replace sr_se=r(Stat3)[2,1] in 27

replace var=r(name4) in 28
replace sr_mean=r(Stat4)[1,1] in 28
replace sr_se=r(Stat4)[2,1] in 28

replace var=r(name5) in 29
replace sr_mean=r(Stat5)[1,1] in 29
replace sr_se=r(Stat5)[2,1] in 29

replace var=r(name6) in 30
replace sr_mean=r(Stat6)[1,1] in 30
replace sr_se=r(Stat6)[2,1] in 30

replace var=r(name7) in 31
replace sr_mean=r(Stat7)[1,1] in 31
replace sr_se=r(Stat7)[2,1] in 31


*By household size
tabstat  sr_insomniacase, by(household_no_cat) stats(mean semean) save
return list

replace var=r(name1) in 32
replace sr_mean=r(Stat1)[1,1] in 32
replace sr_se=r(Stat1)[2,1] in 32

replace var=r(name2) in 33
replace sr_mean=r(Stat2)[1,1] in 33
replace sr_se=r(Stat2)[2,1] in 33

replace var=r(name3) in 34
replace sr_mean=r(Stat3)[1,1] in 34
replace sr_se=r(Stat3)[2,1] in 34

replace var=r(name4) in 35
replace sr_mean=r(Stat4)[1,1] in 35
replace sr_se=r(Stat4)[2,1] in 35

*By household relations
tabstat  sr_insomniacase, by(house_rels_binary) stats(mean semean) save
return list

replace var=r(name1) in 36
replace sr_mean=r(Stat1)[1,1] in 36
replace sr_se=r(Stat1)[2,1] in 36

replace var=r(name2) in 37
replace sr_mean=r(Stat2)[1,1] in 37
replace sr_se=r(Stat2)[2,1] in 37

*By population density
tabstat  sr_insomniacase, by(pop_dens) stats(mean semean) save
return list

replace var=r(name1) in 38
replace sr_mean=r(Stat1)[1,1] in 38
replace sr_se=r(Stat1)[2,1] in 38

replace var=r(name2) in 39
replace sr_mean=r(Stat2)[1,1] in 39
replace sr_se=r(Stat2)[2,1] in 39

replace var=r(name3) in 40
replace sr_mean=r(Stat3)[1,1] in 40
replace sr_se=r(Stat3)[2,1] in 40

*By primary insomnia case
tabstat  sr_insomniacase, by(pc_insomniacase) stats(mean semean) save
return list

replace var=r(name1) in 41
replace sr_mean=r(Stat1)[1,1] in 41
replace sr_se=r(Stat1)[2,1] in 41

replace var=r(name2) in 42
replace sr_mean=r(Stat2)[1,1] in 42
replace sr_se=r(Stat2)[2,1] in 42

*By self-report insomnia case
tabstat  sr_insomniacase, by(sr_insomniacase) stats(mean semean) save
return list

replace var=r(name1) in 43
replace sr_mean=r(Stat1)[1,1] in 43
replace sr_se=r(Stat1)[2,1] in 43

replace var=r(name2) in 44
replace sr_mean=r(Stat2)[1,1] in 44
replace sr_se=r(Stat2)[2,1] in 44

*By sleep duration
tabstat  sr_insomniacase, by(sleep_dur_cats) stats(mean semean) save
return list

replace var=r(name1) in 45
replace sr_mean=r(Stat1)[1,1] in 45
replace sr_se=r(Stat1)[2,1] in 45

replace var=r(name2) in 46
replace sr_mean=r(Stat2)[1,1] in 46
replace sr_se=r(Stat2)[2,1] in 46

replace var=r(name3) in 47
replace sr_mean=r(Stat3)[1,1] in 47
replace sr_se=r(Stat3)[2,1] in 47

replace var=r(name4) in 48
replace sr_mean=r(Stat4)[1,1] in 48
replace sr_se=r(Stat4)[2,1] in 48

*By chronotype
***************
tabstat  sr_insomniacase, by(chrono) stats(mean semean) save
return list

replace var=r(name1) in 49
replace sr_mean=r(Stat1)[1,1] in 49
replace sr_se=r(Stat1)[2,1] in 49

replace var=r(name2) in 50
replace sr_mean=r(Stat2)[1,1] in 50
replace sr_se=r(Stat2)[2,1] in 50

replace var=r(name3) in 51
replace sr_mean=r(Stat3)[1,1] in 51
replace sr_se=r(Stat3)[2,1] in 51

replace var=r(name4) in 52
replace sr_mean=r(Stat4)[1,1] in 52
replace sr_se=r(Stat4)[2,1] in 52

replace var=r(name5) in 53
replace sr_mean=r(Stat5)[1,1] in 53
replace sr_se=r(Stat5)[2,1] in 53

*By snoring
***********
tabstat  sr_insomniacase, by(snoring) stats(mean semean) save
return list

replace var=r(name1) in 54
replace sr_mean=r(Stat1)[1,1] in 54
replace sr_se=r(Stat1)[2,1] in 54

replace var=r(name2) in 55
replace sr_mean=r(Stat2)[1,1] in 55
replace sr_se=r(Stat2)[2,1] in 55


*By day dozing
tabstat  sr_insomniacase, by(day_dozing) stats(mean semean) save
return list

replace var=r(name1) in 56
replace sr_mean=r(Stat1)[1,1] in 56
replace sr_se=r(Stat1)[2,1] in 56

replace var=r(name2) in 57
replace sr_mean=r(Stat2)[1,1] in 57
replace sr_se=r(Stat2)[2,1] in 57

replace var=r(name3) in 58
replace sr_mean=r(Stat3)[1,1] in 58
replace sr_se=r(Stat3)[2,1] in 58

replace var=r(name4) in 59
replace sr_mean=r(Stat4)[1,1] in 59
replace sr_se=r(Stat4)[2,1] in 59

*By napping
tabstat  sr_insomniacase, by(nap) stats(mean semean) save
return list

replace var=r(name1) in 60
replace sr_mean=r(Stat1)[1,1] in 60
replace sr_se=r(Stat1)[2,1] in 60

replace var=r(name2) in 61
replace sr_mean=r(Stat2)[1,1] in 61
replace sr_se=r(Stat2)[2,1] in 61

replace var=r(name3) in 62
replace sr_mean=r(Stat3)[1,1] in 62
replace sr_se=r(Stat3)[2,1] in 62

*By getting up in the morning
tabstat  sr_insomniacase, by(getting_up) stats(mean semean) save
return list

replace var=r(name1) in 63
replace sr_mean=r(Stat1)[1,1] in 63
replace sr_se=r(Stat1)[2,1] in 63

replace var=r(name2) in 64
replace sr_mean=r(Stat2)[1,1] in 64
replace sr_se=r(Stat2)[2,1] in 64

replace var=r(name3) in 65
replace sr_mean=r(Stat3)[1,1] in 65
replace sr_se=r(Stat3)[2,1] in 65

replace var=r(name4) in 66
replace sr_mean=r(Stat4)[1,1] in 66
replace sr_se=r(Stat4)[2,1] in 66

*Night shift
tabstat  sr_insomniacase, by(night_shift) stats(mean semean) save
return list

replace var=r(name1) in 67
replace sr_mean=r(Stat1)[1,1] in 67
replace sr_se=r(Stat1)[2,1] in 67

replace var=r(name2) in 68
replace sr_mean=r(Stat2)[1,1] in 68
replace sr_se=r(Stat2)[2,1] in 68

replace var=r(name3) in 69
replace sr_mean=r(Stat3)[1,1] in 69
replace sr_se=r(Stat3)[2,1] in 69

replace var=r(name4) in 70
replace sr_mean=r(Stat4)[1,1] in 70
replace sr_se=r(Stat4)[2,1] in 70

*By met mins per week
tabstat  sr_insomniacase, by(met_mins_quart) stats(mean semean) save
return list

replace var=r(name1) in 71
replace sr_mean=r(Stat1)[1,1] in 71
replace sr_se=r(Stat1)[2,1] in 71

replace var=r(name2) in 72
replace sr_mean=r(Stat2)[1,1] in 72
replace sr_se=r(Stat2)[2,1] in 72

replace var=r(name3) in 73
replace sr_mean=r(Stat3)[1,1] in 73
replace sr_se=r(Stat3)[2,1] in 73

replace var=r(name4) in 74
replace sr_mean=r(Stat4)[1,1] in 74
replace sr_se=r(Stat4)[2,1] in 74

*By coffee intake
tabstat  sr_insomniacase, by(coffee_cat) stats(mean semean) save
return list

replace var=r(name1) in 75
replace sr_mean=r(Stat1)[1,1] in 75
replace sr_se=r(Stat1)[2,1] in 75

replace var=r(name2) in 76
replace sr_mean=r(Stat2)[1,1] in 76
replace sr_se=r(Stat2)[2,1] in 76

replace var=r(name3) in 77
replace sr_mean=r(Stat3)[1,1] in 77
replace sr_se=r(Stat3)[2,1] in 77

replace var=r(name4) in 78
replace sr_mean=r(Stat4)[1,1] in 78
replace sr_se=r(Stat4)[2,1] in 78

*By tea intake
tabstat  sr_insomniacase, by(tea_cat) stats(mean semean) save
return list

replace var=r(name1) in 79
replace sr_mean=r(Stat1)[1,1] in 79
replace sr_se=r(Stat1)[2,1] in 79

replace var=r(name2) in 80
replace sr_mean=r(Stat2)[1,1] in 80
replace sr_se=r(Stat2)[2,1] in 80

replace var=r(name3) in 81
replace sr_mean=r(Stat3)[1,1] in 81
replace sr_se=r(Stat3)[2,1] in 81

replace var=r(name4) in 82
replace sr_mean=r(Stat4)[1,1] in 82
replace sr_se=r(Stat4)[2,1] in 82


*By BMI category
*****************

tabstat  sr_insomniacase, by(bmi_cat) stats(mean semean) save
return list

replace var=r(name1) in 83
replace sr_mean=r(Stat1)[1,1] in 83
replace sr_se=r(Stat1)[2,1] in 83

replace var=r(name2) in 84
replace sr_mean=r(Stat2)[1,1] in 84
replace sr_se=r(Stat2)[2,1] in 84

replace var=r(name3) in 85
replace sr_mean=r(Stat3)[1,1] in 85
replace sr_se=r(Stat3)[2,1] in 85

replace var=r(name4) in 86
replace sr_mean=r(Stat4)[1,1] in 86
replace sr_se=r(Stat4)[2,1] in 86

*By risk
********
tabstat  sr_insomniacase, by(risk) stats(mean semean) save
return list

replace var=r(name1) in 87
replace sr_mean=r(Stat1)[1,1] in 87
replace sr_se=r(Stat1)[2,1] in 87

replace var=r(name2) in 88
replace sr_mean=r(Stat2)[1,1] in 88
replace sr_se=r(Stat2)[2,1] in 88


*By smoking
********
tabstat  sr_insomniacase, by(smoking) stats(mean semean) save
return list

replace var=r(name1) in 89
replace sr_mean=r(Stat1)[1,1] in 89
replace sr_se=r(Stat1)[2,1] in 89

replace var=r(name2) in 90
replace sr_mean=r(Stat2)[1,1] in 90
replace sr_se=r(Stat2)[2,1] in 90

replace var=r(name3) in 91
replace sr_mean=r(Stat3)[1,1] in 91
replace sr_se=r(Stat3)[2,1] in 91

*By alcohol intake
tabstat  sr_insomniacase, by(alcohol) stats(mean semean) save
return list

replace var=r(name1) in 92
replace sr_mean=r(Stat1)[1,1] in 92
replace sr_se=r(Stat1)[2,1] in 92

replace var=r(name2) in 93
replace sr_mean=r(Stat2)[1,1] in 93
replace sr_se=r(Stat2)[2,1] in 93

replace var=r(name3) in 94
replace sr_mean=r(Stat3)[1,1] in 94
replace sr_se=r(Stat3)[2,1] in 94

replace var=r(name4) in 95
replace sr_mean=r(Stat4)[1,1] in 95
replace sr_se=r(Stat4)[2,1] in 95

replace var=r(name5) in 96
replace sr_mean=r(Stat5)[1,1] in 96
replace sr_se=r(Stat5)[2,1] in 96

replace var=r(name6) in 97
replace sr_mean=r(Stat6)[1,1] in 97
replace sr_se=r(Stat6)[2,1] in 97

*By menopause
**************
tabstat  sr_insomniacase, by(menopause) stats(mean semean) save
return list

replace var=r(name1) in 98
replace sr_mean=r(Stat1)[1,1] in 98
replace sr_se=r(Stat1)[2,1] in 98

replace var=r(name2) in 99
replace sr_mean=r(Stat2)[1,1] in 99
replace sr_se=r(Stat2)[2,1] in 99


*Depression
***********
tabstat  sr_insomniacase, by(depress) stats(mean semean) save
return list

replace var=r(name1) in 100
replace sr_mean=r(Stat1)[1,1] in 100
replace sr_se=r(Stat1)[2,1] in 100

replace var=r(name2) in 101
replace sr_mean=r(Stat2)[1,1] in 101
replace sr_se=r(Stat2)[2,1] in 101

replace var=r(name3) in 102
replace sr_mean=r(Stat3)[1,1] in 102
replace sr_se=r(Stat3)[2,1] in 102

replace var=r(name4) in 103
replace sr_mean=r(Stat4)[1,1] in 103
replace sr_se=r(Stat4)[2,1] in 103

*By worrier
***********
tabstat  sr_insomniacase, by(worrier) stats(mean semean) save
return list

replace var=r(name1) in 104
replace sr_mean=r(Stat1)[1,1] in 104
replace sr_se=r(Stat1)[2,1] in 104

replace var=r(name2) in 105
replace sr_mean=r(Stat2)[1,1] in 105
replace sr_se=r(Stat2)[2,1] in 105

*By overall health
***********
tabstat  sr_insomniacase, by(overall_health) stats(mean semean) save
return list

replace var=r(name1) in 106
replace sr_mean=r(Stat1)[1,1] in 106
replace sr_se=r(Stat1)[2,1] in 106

replace var=r(name2) in 107
replace sr_mean=r(Stat2)[1,1] in 107
replace sr_se=r(Stat2)[2,1] in 107

replace var=r(name3) in 108
replace sr_mean=r(Stat3)[1,1] in 108
replace sr_se=r(Stat3)[2,1] in 108

replace var=r(name4) in 109
replace sr_mean=r(Stat4)[1,1] in 109
replace sr_se=r(Stat4)[2,1] in 109


*Check looks ok.
list var sr_mean sr_se in 1/50
list var sr_mean sr_se in 51/109


****************************************************************************

*Stratify by primary care insomnia case
***************************************


*For sex
********
tabstat  pc_insomniacase, by(sex) stats(mean semean) save
return list


replace pc_mean=r(Stat1)[1,1] in 1
replace pc_se=r(Stat1)[2,1] in 1


replace pc_mean=r(Stat2)[1,1] in 2
replace pc_se=r(Stat2)[2,1] in 2

*Check looks ok.
list var sr_mean sr_se pc_mean pc_se in 1/5


*For age
********
tabstat  pc_insomniacase, by(age_assess_cat) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 3
replace pc_se=r(Stat1)[2,1] in 3

replace pc_mean=r(Stat2)[1,1] in 4
replace pc_se=r(Stat2)[2,1] in 4

replace pc_mean=r(Stat3)[1,1] in 5
replace pc_se=r(Stat3)[2,1] in 5

replace pc_mean=r(Stat4)[1,1] in 6
replace pc_se=r(Stat4)[2,1] in 6


list var sr_mean sr_se pc_mean pc_se in 3/6

*For ethnic group
*****************

tabstat  pc_insomniacase, by(ethnicity) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 7
replace pc_se=r(Stat1)[2,1] in 7

replace pc_mean=r(Stat2)[1,1] in 8
replace pc_se=r(Stat2)[2,1] in 8

replace pc_mean=r(Stat3)[1,1] in 9
replace pc_se=r(Stat3)[2,1] in 9

replace pc_mean=r(Stat4)[1,1] in 10
replace pc_se=r(Stat4)[2,1] in 10

replace pc_mean=r(Stat5)[1,1] in 11
replace pc_se=r(Stat5)[2,1] in 11

replace pc_mean=r(Stat6)[1,1] in 12
replace pc_se=r(Stat6)[2,1] in 12

*By income
**********
tabstat  pc_insomniacase, by(income) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 13
replace pc_se=r(Stat1)[2,1] in 13

replace pc_mean=r(Stat2)[1,1] in 14
replace pc_se=r(Stat2)[2,1] in 14

replace pc_mean=r(Stat3)[1,1] in 15
replace pc_se=r(Stat3)[2,1] in 15

replace pc_mean=r(Stat4)[1,1] in 16
replace pc_se=r(Stat4)[2,1] in 16

replace pc_mean=r(Stat5)[1,1] in 17
replace pc_se=r(Stat5)[2,1] in 17


*By deprivation
******************
tabstat  pc_insomniacase, by(depriv_quart) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 18
replace pc_se=r(Stat1)[2,1] in 18

replace pc_mean=r(Stat2)[1,1] in 19
replace pc_se=r(Stat2)[2,1] in 19

replace pc_mean=r(Stat3)[1,1] in 20
replace pc_se=r(Stat3)[2,1] in 20

replace pc_mean=r(Stat4)[1,1] in 21
replace pc_se=r(Stat4)[2,1] in 21

*By employment
***************
tabstat  pc_insomniacase, by(employ_3cats) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 22
replace pc_se=r(Stat1)[2,1] in 22

replace pc_mean=r(Stat2)[1,1] in 23
replace pc_se=r(Stat2)[2,1] in 23

replace pc_mean=r(Stat3)[1,1] in 24
replace pc_se=r(Stat3)[2,1] in 24

*By qualifications
******************
tabstat  pc_insomniacase, by(qual_highest) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 25
replace pc_se=r(Stat1)[2,1] in 25

replace pc_mean=r(Stat2)[1,1] in 26
replace pc_se=r(Stat2)[2,1] in 26

replace pc_mean=r(Stat3)[1,1] in 27
replace pc_se=r(Stat3)[2,1] in 27

replace pc_mean=r(Stat4)[1,1] in 28
replace pc_se=r(Stat4)[2,1] in 28

replace pc_mean=r(Stat5)[1,1] in 29
replace pc_se=r(Stat5)[2,1] in 29

replace pc_mean=r(Stat6)[1,1] in 30
replace pc_se=r(Stat6)[2,1] in 30

replace pc_mean=r(Stat7)[1,1] in 31
replace pc_se=r(Stat7)[2,1] in 31


*By household size
tabstat  pc_insomniacase, by(household_no_cat) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 32
replace pc_se=r(Stat1)[2,1] in 32

replace pc_mean=r(Stat2)[1,1] in 33
replace pc_se=r(Stat2)[2,1] in 33

replace pc_mean=r(Stat3)[1,1] in 34
replace pc_se=r(Stat3)[2,1] in 34

replace pc_mean=r(Stat4)[1,1] in 35
replace pc_se=r(Stat4)[2,1] in 35

*By household relations
tabstat  pc_insomniacase, by(house_rels_binary) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 36
replace pc_se=r(Stat1)[2,1] in 36

replace pc_mean=r(Stat2)[1,1] in 37
replace pc_se=r(Stat2)[2,1] in 37

*By population density
tabstat  pc_insomniacase, by(pop_dens) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 38
replace pc_se=r(Stat1)[2,1] in 38

replace pc_mean=r(Stat2)[1,1] in 39
replace pc_se=r(Stat2)[2,1] in 39

replace pc_mean=r(Stat3)[1,1] in 40
replace pc_se=r(Stat3)[2,1] in 40

*By primary insomnia case
tabstat  pc_insomniacase, by(pc_insomniacase) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 41
replace pc_se=r(Stat1)[2,1] in 41

replace pc_mean=r(Stat2)[1,1] in 42
replace pc_se=r(Stat2)[2,1] in 42

*By self-report insomnia case
tabstat  pc_insomniacase, by(sr_insomniacase) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 43
replace pc_se=r(Stat1)[2,1] in 43

replace pc_mean=r(Stat2)[1,1] in 44
replace pc_se=r(Stat2)[2,1] in 44

*By sleep duration
tabstat  pc_insomniacase, by(sleep_dur_cats) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 45
replace pc_se=r(Stat1)[2,1] in 45

replace pc_mean=r(Stat2)[1,1] in 46
replace pc_se=r(Stat2)[2,1] in 46

replace pc_mean=r(Stat3)[1,1] in 47
replace pc_se=r(Stat3)[2,1] in 47

replace pc_mean=r(Stat4)[1,1] in 48
replace pc_se=r(Stat4)[2,1] in 48

*By chronotype
***************
tabstat  pc_insomniacase, by(chrono) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 49
replace pc_se=r(Stat1)[2,1] in 49

replace pc_mean=r(Stat2)[1,1] in 50
replace pc_se=r(Stat2)[2,1] in 50

replace pc_mean=r(Stat3)[1,1] in 51
replace pc_se=r(Stat3)[2,1] in 51

replace pc_mean=r(Stat4)[1,1] in 52
replace pc_se=r(Stat4)[2,1] in 52

replace pc_mean=r(Stat5)[1,1] in 53
replace pc_se=r(Stat5)[2,1] in 53

*By snoring
***********
tabstat  pc_insomniacase, by(snoring) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 54
replace pc_se=r(Stat1)[2,1] in 54

replace pc_mean=r(Stat2)[1,1] in 55
replace pc_se=r(Stat2)[2,1] in 55


*By day dozing
tabstat  pc_insomniacase, by(day_dozing) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 56
replace pc_se=r(Stat1)[2,1] in 56

replace pc_mean=r(Stat2)[1,1] in 57
replace pc_se=r(Stat2)[2,1] in 57

replace pc_mean=r(Stat3)[1,1] in 58
replace pc_se=r(Stat3)[2,1] in 58

replace pc_mean=r(Stat4)[1,1] in 59
replace pc_se=r(Stat4)[2,1] in 59

*By napping
tabstat  pc_insomniacase, by(nap) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 60
replace pc_se=r(Stat1)[2,1] in 60

replace pc_mean=r(Stat2)[1,1] in 61
replace pc_se=r(Stat2)[2,1] in 61

replace pc_mean=r(Stat3)[1,1] in 62
replace pc_se=r(Stat3)[2,1] in 62

*By getting up in the morning
tabstat  pc_insomniacase, by(getting_up) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 63
replace pc_se=r(Stat1)[2,1] in 63

replace pc_mean=r(Stat2)[1,1] in 64
replace pc_se=r(Stat2)[2,1] in 64

replace pc_mean=r(Stat3)[1,1] in 65
replace pc_se=r(Stat3)[2,1] in 65

replace pc_mean=r(Stat4)[1,1] in 66
replace pc_se=r(Stat4)[2,1] in 66

*Night shift
tabstat  pc_insomniacase, by(night_shift) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 67
replace pc_se=r(Stat1)[2,1] in 67

replace pc_mean=r(Stat2)[1,1] in 68
replace pc_se=r(Stat2)[2,1] in 68

replace pc_mean=r(Stat3)[1,1] in 69
replace pc_se=r(Stat3)[2,1] in 69

replace pc_mean=r(Stat4)[1,1] in 70
replace pc_se=r(Stat4)[2,1] in 70

*By met mins per week
tabstat  pc_insomniacase, by(met_mins_quart) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 71
replace pc_se=r(Stat1)[2,1] in 71

replace pc_mean=r(Stat2)[1,1] in 72
replace pc_se=r(Stat2)[2,1] in 72

replace pc_mean=r(Stat3)[1,1] in 73
replace pc_se=r(Stat3)[2,1] in 73

replace pc_mean=r(Stat4)[1,1] in 74
replace pc_se=r(Stat4)[2,1] in 74

*By coffee intake
tabstat  pc_insomniacase, by(coffee_cat) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 75
replace pc_se=r(Stat1)[2,1] in 75

replace pc_mean=r(Stat2)[1,1] in 76
replace pc_se=r(Stat2)[2,1] in 76

replace pc_mean=r(Stat3)[1,1] in 77
replace pc_se=r(Stat3)[2,1] in 77

replace pc_mean=r(Stat4)[1,1] in 78
replace pc_se=r(Stat4)[2,1] in 78

*By tea intake
tabstat  pc_insomniacase, by(tea_cat) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 79
replace pc_se=r(Stat1)[2,1] in 79

replace pc_mean=r(Stat2)[1,1] in 80
replace pc_se=r(Stat2)[2,1] in 80

replace pc_mean=r(Stat3)[1,1] in 81
replace pc_se=r(Stat3)[2,1] in 81

replace pc_mean=r(Stat4)[1,1] in 82
replace pc_se=r(Stat4)[2,1] in 82


*By BMI category
*****************

tabstat  pc_insomniacase, by(bmi_cat) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 83
replace pc_se=r(Stat1)[2,1] in 83

replace pc_mean=r(Stat2)[1,1] in 84
replace pc_se=r(Stat2)[2,1] in 84

replace pc_mean=r(Stat3)[1,1] in 85
replace pc_se=r(Stat3)[2,1] in 85

replace pc_mean=r(Stat4)[1,1] in 86
replace pc_se=r(Stat4)[2,1] in 86

*By risk
********
tabstat  pc_insomniacase, by(risk) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 87
replace pc_se=r(Stat1)[2,1] in 87

replace pc_mean=r(Stat2)[1,1] in 88
replace pc_se=r(Stat2)[2,1] in 88


*By smoking
********
tabstat  pc_insomniacase, by(smoking) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 89
replace pc_se=r(Stat1)[2,1] in 89

replace pc_mean=r(Stat2)[1,1] in 90
replace pc_se=r(Stat2)[2,1] in 90

replace pc_mean=r(Stat3)[1,1] in 91
replace pc_se=r(Stat3)[2,1] in 91

*By alcohol intake
tabstat  pc_insomniacase, by(alcohol) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 92
replace pc_se=r(Stat1)[2,1] in 92

replace pc_mean=r(Stat2)[1,1] in 93
replace pc_se=r(Stat2)[2,1] in 93

replace pc_mean=r(Stat3)[1,1] in 94
replace pc_se=r(Stat3)[2,1] in 94

replace pc_mean=r(Stat4)[1,1] in 95
replace pc_se=r(Stat4)[2,1] in 95

replace pc_mean=r(Stat5)[1,1] in 96
replace pc_se=r(Stat5)[2,1] in 96

replace pc_mean=r(Stat6)[1,1] in 97
replace pc_se=r(Stat6)[2,1] in 97

*By menopause
**************
tabstat  pc_insomniacase, by(menopause) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 98
replace pc_se=r(Stat1)[2,1] in 98

replace pc_mean=r(Stat2)[1,1] in 99
replace pc_se=r(Stat2)[2,1] in 99


*Depression
***********
tabstat  pc_insomniacase, by(depress) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 100
replace pc_se=r(Stat1)[2,1] in 100

replace pc_mean=r(Stat2)[1,1] in 101
replace pc_se=r(Stat2)[2,1] in 101

replace pc_mean=r(Stat3)[1,1] in 102
replace pc_se=r(Stat3)[2,1] in 102

replace pc_mean=r(Stat4)[1,1] in 103
replace pc_se=r(Stat4)[2,1] in 103

*By worrier
***********
tabstat  pc_insomniacase, by(worrier) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 104
replace pc_se=r(Stat1)[2,1] in 104

replace pc_mean=r(Stat2)[1,1] in 105
replace pc_se=r(Stat2)[2,1] in 105

*By overall health
***********
tabstat  pc_insomniacase, by(overall_health) stats(mean semean) save
return list

replace pc_mean=r(Stat1)[1,1] in 106
replace pc_se=r(Stat1)[2,1] in 106

replace pc_mean=r(Stat2)[1,1] in 107
replace pc_se=r(Stat2)[2,1] in 107

replace pc_mean=r(Stat3)[1,1] in 108
replace pc_se=r(Stat3)[2,1] in 108

replace pc_mean=r(Stat4)[1,1] in 109
replace pc_se=r(Stat4)[2,1] in 109

**Check looks ok.
list var sr_mean sr_se pc_mean pc_se in 1/109


*Just keep variables we need for stratification table

keep var sr_mean sr_se pc_mean pc_se

*Save as excel spreadsheet
export excel strat_table_combined.xlsx, firstrow(varlabels) replace
!dx upload strat_table_combined.xlsx


