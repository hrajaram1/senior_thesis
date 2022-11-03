** ECON 560**
**Drivers of Refugee Entrepreneurship in the United States: Evidence from Utica, NY.**

* Author: Hersheena Rajaram
* Purpose: Logit and Marginal Effects Results
* Date: May 5, 2019

*** Logit Models
*** (1) Y = Does your family own a business?
*** 1a. Network/ Immigration variable only
logit selfNFam hhsize i.Bosnia i.SE_Asia i.Africa i.ME i.strong_coethnicFG i.relg_fq
estimates store m1a, title(Network)

*** 1b. Opportunity variables only
logit selfNFam i.borrow_friends i.strongLS i.lowIncome
estimates store m1b, title(Opportunity)

*** Full model
logit selfNFam YearsinUS entryage hhsize i.Bosnia i.SE_Asia i.Africa i.ME i.strong_coethnicFG i.relg_fq i.borrow_friends i.strongLS i.lowIncome
estimates store m1c, title(Full)
esttab m1a m1b m1c using LogitCoeffFV_3.rtf, star(* 0.10 ** 0.05 *** 0.01)

*** (2) Y = Would you like to start a business?
*** 2a. Network/ Immigration variable only
logit selfNIntent hhsize i.Bosnia i.SE_Asia i.Africa i.ME i.strong_coethnicFG 
estimates store m2a, title(Network)

*** 2b. Disadvantage variables only
logit selfNIntent i.HS_GED i.greaterHS i.strongLS i.lowIncome i.bank
estimates store m2b, title(Opportunity)

*** Full model
logit selfNIntent YearsinUS entryage hhsize i.Bosnia i.SE_Asia i.Africa i.ME i.strong_coethnicFG i.HS_GED i.greaterHS i.strongLS i.lowIncome i.bank
estimates store m2c, title(Full)
esttab m2a m2b m2c using LogitCoeffFV_2.rtf, star(* 0.10 ** 0.05 *** 0.01)

*** Logit Models Marginal Effects
*** (1) Y = Does your family own a business?
*** 1a. Network/ Immigration variable only
eststo raw: logit selfNFam hhsize i.Bosnia i.SE_Asia i.Africa i.ME i.strong_coethnicFG i.relg_fq
eststo margin: margins, dydx(*) post
estimates store m1aa, title(Margins 1a)

*** 1b. Opportunity variables only
eststo raw: logit selfNFam i.borrow_friends i.strongLS i.lowIncome
eststo margin: margins, dydx(*) post
estimates store m1bb, title(Margins 1b)

*** Full model
eststo raw: logit selfNFam YearsinUS entryage hhsize i.Bosnia i.SE_Asia i.Africa i.ME i.strong_coethnicFG i.relg_fq i.borrow_friends i.strongLS i.lowIncome
eststo margin: margins, dydx(*) post
estimates store m1cc, title(Model 1cc)
esttab m1aa m1bb m1cc using Margins_Model112.rtf, star(* 0.10 ** 0.05 *** 0.01)

*** (2) Y = Would you like to start a business?
*** 2a. Network/ Immigration variable only
eststo raw: logit selfNIntent hhsize i.Bosnia i.SE_Asia i.Africa i.ME i.strong_coethnicFG 
eststo margin: margins, dydx(*) post
estimates store m2aa, title(Margins 2aa)

*** 2b. Opportunity variables only
eststo raw: logit selfNIntent i.HS_GED i.greaterHS i.strongLS i.lowIncome i.borrow_friends
eststo margin: margins, dydx(*) post
estimates store m2bb, title(Margins 2bb)

*** Full model
eststo raw: logit selfNIntent YearsinUS entryage hhsize i.Bosnia i.SE_Asia i.Africa i.ME i.strong_coethnicFG i.HS_GED i.greaterHS i.strongLS i.lowIncome i.bank
eststo margin: margins, dydx(*) post
estimates store m2cc, title(Model 2cc)

esttab m2aa m2bb m2cc using Margins_Model2.rtf, star(* 0.10 ** 0.05 *** 0.01)
