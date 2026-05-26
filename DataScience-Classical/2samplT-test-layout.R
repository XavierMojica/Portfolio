#2 Sample T Test 

#Let us test the claim that the mean score of the Intrinsic group is different than that of the Extrinsic group. 
#Take a sample of size nI = 24 and nE = 23 and find  the xbarI = 19.88 points, xbarE = 15.74, si = 4.44 and se = 5.25 points. 

#Step 1: Ho: muI = muE , Ha: Mi =! mE 

#Step 2: Draw and shade and find critical value 
#alpha = 0.01 
#df = 24+23 -2 = 45 
qt(0.01/2,47-2)

#Step 3: Find the Test Statistic (the t value for the data)
#t = ((xbarI - xbarE) - (mI - mE)) / Sp(sqrt((1/nI)+ (1/nE))) = 2.93 from t = num from t.test()

#Step 4: Find the p-value: the probabililty of observing by random chance something as extreme or more 
#extreme than what was observed under the assumption that he null hypothesis is true. 

df = read.csv()

#response is Score (NUMERICAL) and Treatment is Class
t.test(Score ~Treatment, data = df, conf.lev = 0.99, var.equal = TRUE)
#use pool standard variation var.equal = TRUE

#p-value = 0.0054 

#Step 5: Reject Ho 

#Step 6: There is sufficient evidence to suggest that htose who receive the Intrinsic treatment have a 
#different mean score than those who receive the Extrinsic Treatment ( p-value = 0.0054 from a t-test). 
#We can also claim that the mean intrinsic score is greater than the extrinsic one since the 
#difference in smaple means favors the Intrinsic group. 



#Complete Analysis 
#State the problem: We would like to test the claim that the mean score of the Intrinsic group is
#different than that of the Extrinsic group. 

#Check Assumptions: 
  #1) Normally Distributed Populations: look at histograms and box plots to look at distributions 
  #2) Equal Standard  Deviations: Are both consistant 
  #3) Independence 

#Run the 5 Steps: ID Ho and Ha, Critical value, test statistic aka the t value from t.test()
  # p-value, Fail to Reject or Reject Ho 
#Step 6 Conclusion and Scope 
  #Conclusion: There is suficient evidence to suggest that those who receive the Intrinsic treatment have a 
  #a higher mean score than those who receive the Extrinsic treatment ( p-value = 0.0054 from 2 sided t-test). 
  #A 99% confidence interval for this difference is (1.29, 7.00). 

  #Scope: Scince this was a randomized experiment, we can conlude that the Intrinsic treatment caused this difference. 
  #However, since the study was of volunteers, thihs inference can only be generalized to the 47 participants. 















