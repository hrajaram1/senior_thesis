** ECON 560**
**Drivers of Refugee Entrepreneurship in the United States: Evidence from Utica, NY.**

* Author: Hersheena Rajaram
* Purpose: Exploring, cleaning data + descriptive stats
* Date: May 5, 2019

** Load data
use "\\Client\C$\Users\hraja\Desktop\ECON Thesis\STATA\utica_v_1_7 (1).dta"

** This dataset is the Survey of Utica Refugee Retention and Financial Inclusion (SURRFI). 
** It includes 619 observations and 2 questions of interest:
** (1) Does your family own a business?
** (2) Would you like to start a business in the near future?

** Each question will serve as my dependent variable for my two models to answer my research question:
** What are the factors influencing a refugee to start their own business in the U.S?

*** First, let's look at descriptive and summary stats

*** Age
gen age_b = 16*(q1_==1) + 20*(q1_==2) + 20*(q1_==3) + 26*(q1_==4) + 35*(q1_==5) + 45*(q1_==6) + 55*(q1_==7) + 69*(q1_==8)
gen age_imp = age
replace age_imp = age_b if age_imp==.

* (a) Years in US
tab  q4_yr_arrive_US
gen YearsinUS = 2017-q4_yr_arrive_US
replace YearsinUS=age if YearsinUS==. & q2_born_US ==2
gen YearsinUS_2 =YearsinUS^2

*(b) Entry Age
gen entryage = age_imp-YearsinUS
replace entryage = 0 if entryage<0
replace entryage = 0 if q2_born_US ==2


* (c) gender
sum gender
tab gender
gen genderN=gender
recode genderN 2=0
tab genderN

* (d) Education
tab q21_educ_completed
gen educ=q21_educ_completed
recode educ 3=2 4=3 5=3 6=3
tab q21_educ_completed
tab educ
recode educ 7=3 8=3
tab educ
*** Education levels are classified in 4 categories: <HS(1), HS+GED (2), >HS (3)
*** and Other (4)

gen lessHS = educ ==1 if educ!=.
gen HS_GED = educ ==2 if educ!=.
gen greaterHS = educ ==3 if educ!=.
sum lessHS HS_GED greaterHS

* (e) Number of people in household? 
tab q18_hh_size
gen hhsize=q18_hh_size

* (f) Group Density
tab group_density
sum group_density

* (g) Language Skills (LS)
tab LS
gen strongLS = LS>2 if LS!=.
tab strongLS

* (h) q76: My friend group is composed of people from my ethnic background.
tab q76_coethnic_friendgroup
gen coethnic_friends=q76_coethnic_friendgroup

*** I also want to create a dummy variable for coethnic friends
** 1 means that they agree or strongly agree that their friend group is composed 
** of people from the same ethnic background
** 0 includes neutral, disagree and strongly disagree
gen strong_coethnicFG = coethnic_friends
recode strong_coethnicFG 1=0 2=0 3=0 4=1 5=1
tab strong_coethnicFG

* (i)q14: How often do you attend religious services?
tab q14_relig_freq
gen relg_fq = q14_relig_freq
tab relg_fq
recode relg_fq 1=0 2=0 3=1 4=1 5=0
tab relg_fq

** I made two groups: people going frequently (at least once a week and at least twice a month)
** and people going rarely or never (never, religious holidays and once or twice a year)
** Those going frequently takes the value of 1 and those going rarely takes 0.

* (j) Region of origin
tab q3_BC_gen
gen region = q3_BC_gen
tab region
recode region 8=6 10=6

** Some of the respondents were born in the US. For these, I replace their birth country 
** with that of their parents.
tab q7_BC_par if region==6
replace region = q7_BC_par if region ==6
tab region

** I now create dummy variable for region of origin. I will omit Russia in my regression.
gen Russia = region==1 if region!=.
gen Bosnia = region==2 if region!=.
gen SE_Asia = region==3 if region!=.
gen Africa = region==4 if region!=.
gen ME = region==5 if region!=.
sum Russia Bosnia SE_Asia Africa ME

** Some additional/potential variables
**Q20: Did either your mother or father go to college?
tab q20
gen parentscoll = q20_par_go_college ==2 if q20_par_go_college !=.
tab parentscoll

** To measure access to capital
** Q39: Do you, either by yourself or with someone else, 
**currently have a savings or checking account? (N=603)
tab q39_have_savings_account
gen bank = q39_have_savings_account
tab bank
recode bank 1=0 2=1

** Q41: Do you personally have a debit card? (N = 451)
tab q41_have_debitcard
gen debitCard = q41_have_debitcard
tab debitCard
recode debitCard 1=0 2=1

** Q59: How do you prefer to borrow money?
** Options are Credit Card, Bank Loan, Friends/Fam, Sth else. 
** Takes the value of 1 if friends/fam, 0 otherwise
tab q59_Prefer_borrow
gen borrow_friends = q59_Prefer_borrow ==3 if q59_Prefer_borrow !=.
tab borrow_friends

** This one is for economic uncertainty
** Q54: In the last 12 months, have you thought that your income was less than enough?
tab q54_income_lt_costs
gen lowIncome = q54_income_lt_costs
tab lowIncome
recode lowIncome 1=0 2=1

** Q56: Thinking of last month, which of the following best describes your family's income. (N=605)
** Options are more than enough, enough and less than enough.
** Less than enough takes the value of 0 and more than enough and enough takes the value of 1.
tab q56_adequacy
gen adequacy = q56_adequacy
tab adequacy
recode adequacy 1=1 2=1 3=0

** Q72: There is little discrimination against refugees in Utica.
** 1 means that they agree or strongly agree that their friend group is composed 
** of people from the same ethnic background
** 0 includes neutral, disagree and strongly disagree
tab q72_littlediscri_refugee
gen feel_discrim = q72_littlediscri_refugee <3 if q72_littlediscri_refugee !=.
tab feel_discrim


** Dependent variables:
*(1) Does your family own a business in Utica?
tab q36_family_own_business
gen selfNFam=q36_family_own_business
tab selfNFam
recode selfNFam 1=0 2=1
tab selfNFam

* (2) Would you like to start a business in the near future?
tab q36
gen selfNIntent = q37_start_business_nearfuture
tab selfNIntent
recode selfNIntent 1=0 2=1
tab selfNIntent

*** Time for a recap - Descriptive Statistics ***
sum selfNFam selfNIntent YearsinUS entryage hhsize Russia Bosnia SE_Asia Africa ME strong_coethnicFG relg_fq lessHS HS_GED greaterHS strongLS lowIncome borrow_friends bank
estpost sum selfNFam selfNIntent YearsinUS entryage hhsize Russia Bosnia SE_Asia Africa ME strong_coethnicFG relg_fq lessHS HS_GED greaterHS strongLS lowIncome borrow_friends bank
esttab using desc_FV1.rtf, cells("count mean sd min max") nomtitle nonumber



