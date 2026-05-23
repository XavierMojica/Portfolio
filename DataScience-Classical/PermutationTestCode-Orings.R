library(dplyr)

# Permutation Test
# Alternative to a t-test when unsure about t-test assumptions
# Takes all possible combinations

Failures = c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,2,1,1,1,3)
Temp = c('Warm','Warm','Warm','Warm','Warm','Warm','Warm','Warm','Warm','Warm','Warm','Warm','Warm','Warm','Warm','Warm','Warm','Warm','Warm','Warm','Cold','Cold','Cold','Cold')

Orings = data.frame(Failures = Failures, Temp = Temp)


#THE T TEST is not Appropriate for this type of examples !!!


numberofPermutations = 10000
xbarholder = c()
counter = 0 
# Observed difference: Warm mean - Cold mean
observed_diff = mean(subset(Orings, Temp == "Warm")$Failures) -
  mean(subset(Orings, Temp == "Cold")$Failures)

observed_diff

for(i in 1:numberofPermutations){
  
  scramble = sample(Orings$Failures, 24)
  
  warm = scramble[1:20]
  cold = scramble[21:24]
  
  diff = mean(warm) - mean(cold)
  
  xbarholder[i] = diff
  
  # Two-sided permutation p-value
  if(abs(diff) >= abs(observed_diff)){
    counter = counter + 1
  }
}


hist(xbarholder, col = 'orange', main = "Differences Means Under Null Hypothesis", 
     xlab = 'Difference of Means')
abline(v = observed_diff, col = 'black', lwd = 4)
pvalue = counter / numberofPermutations
pvalue


#Ho: Mwarm - Mcold = 0 
#Ha: Mwarm - Mcold != 0 
#Critical Value: NA
#Test statistic: xbar warm - xbar cold = observed_diff = -1.3
#pvalue = .0089
# Reject Ho 

#Conclusion: THere is overwhelming evidence to suggest that hte mean of O-ring failures during codl weather 
# is greater than during warm weather. Our best estimate of the difference is 1.3 more filures during cold 
#weather (p-value = .009 from a permutation test)



