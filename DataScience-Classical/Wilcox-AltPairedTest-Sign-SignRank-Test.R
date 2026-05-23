#Alternative to Pair Test 
# Sign and Sign Rank Test 

#Hypohtesis Tset will be on Medians insteads of Means
#Ho: The median difference in nerve cell count between 'site1' and 'site2' is Zero 
#Ha: The median difference in nerve cell count between 'site1' and 'site2' is Not Zero (2 sided)
    #alt possibilty Ha: The median difference in nerve cell count 
    #between 'site1' and 'site2' is greater than Zero (one sided)


horse = c(6,4,8,5,7,9,3,1,2)
site1 = c(14.2,17,37.4,11.2,24.2,35.2,35.2,50.6,39.2)
site2 = c(16.4,19,37.6,6.6,14.4,24.4,23.2,38,18.6)

#making it a DF
df = data.frame(horse = horse, site1 = site1, site2 = site2)
df


#paired differences col 
df$difference = df$site1 - df$site2
df

#at alpha = .05, getting the critical value 
alpha = .05
critical_value = qnorm(1 - alpha)
critical_value


#wilcox signed rank test 
wilcox.test(df$site1, df$site2, paired = TRUE, alternative = "greater")

#Stat Conclusion: There is strong evidence that the median difference of nerve density between site1 and site2
# is greater than 0 (wilcox sign rank test one sided p-value = 0.027). In other words, there is strong 
#evidence to suggest the median density of nerve cells is greater at site 1 than at site 2. 

##signed rank test has more power than the sign test (compare both p values, 0.254 v 0.027). both tests make few assumptions about distributions. 
