#Researches look at effectiveness of conventional textbhook examples to modified ones. 28 9th yr students participated. 
#Randomly assigned to one of the 2 groups 
#After instruction they were given a test and the time to compelte one of the problems was recorded 

#Rank Sum Test is useful when we have Censored Data , ie. the cutoff time for a timed test the last ones past the deadline are all marked as +++ w.o actual time


#creating DF 
scores = c(68,70,73,75,77,80,80,130,132,139,146,148,150,155,161,177,183,197,206,210,228,242,265,300,300,300,300,300)
testMethod = c("M","M","M","M","M","M","M","C","M","C","C","M","C","M","C","C","M","M","M","M","C","C","C","C","C","C","C","C")

mydata = data.frame(nums = scores, vars = testMethod)


#visualize dataframe 
print(mydata)

#average and sample standard deviation of the ranks from the combined sample

# Create ranks from the combined sample
mydata$ranks= rank(mydata$nums)
# Visualize dataframe
print(mydata)

# Average rank from the combined sample
mean_rank = mean(mydata$ranks)
# Sample standard deviation of the ranks
sd_rank = sd(mydata$ranks)

mean_rank
sd_rank


#Compute the theoretical 'null hypothesis' mean and STD of T using R bar = 14.5 and STD = 8.2023
#Mean(T) = 14x14.5 = 203 
#SD(T) = 8.2023 sqrt((14x14)/(14+14)) = 21.7013
# Given values
R_bar = mean_rank
R_sd = sd_rank

# Group sizes
n_M = sum(mydata$vars == "M")
n_C = sum(mydata$vars == "C")
N = nrow(mydata)

# Theoretical null mean of T
mu_T = n_M * R_bar

# Theoretical null standard deviation of T
sd_T = sqrt((n_M * n_C) / N) * R_sd

mu_T
sd_T


#Calculate Z score with continuity correction 
#add the ranks form all observatiosn in one group (M) 
#Sum of ranks for group M
T_M = sum(mydata$ranks[mydata$vars == "M"])
T_M
#now add the continuity correct 
T_M_continuity = T_M +.5  #bc test stat is less than 203  if greater then -.5

Z = ((T_M_continuity - mu_T)/sd_T)
Z

##wilcoxon rank sum test 
# setting M as the first factor level :. M - C 
mydata$vars =factor(mydata$vars, levels = c("M", "C"))

#R automatically adjusts and warns about ties
wilcox.test(nums~vars, data = mydata, alternative = 'less', exact = FALSE, correct = TRUE)
#using exact method 
wilcox.test(nums~vars, data = mydata, exact = TRUE, alternative = 'less', correct = TRUE)

#Statistical conclusion: 
# The data provide convincing evidence that a student could solve the problem faster after 
#the modified rather than the conventional method (one-sided, normal approximation with 
#continuity correction p-value = 0.00127, from a rank-sum test)


#Hodges-Lehmann Estimation if you want Confidence LEvels 
wilcox.test(nums~vars, data = mydata, alternative = "two.sided", 
            exact = FALSE, correct = TRUE,conf.int = TRUE) #use two.sided bc avoids inf issue
#then get the interval midpoint 
midpoint = wilcox.test(nums~vars, data = mydata, alternative = "two.sided", 
                       exact = FALSE, correct = TRUE,conf.int = TRUE)
mean(midpoint$conf.int)

#CI with Exact 
wilcox.test(nums~vars, data = mydata, alternative = "two.sided", 
            exact = TRUE, correct = TRUE,conf.int = TRUE) #use two.sided bc avoids inf issue

#Stat Conclusion Continuation: 
# We are 95% confident that the median of the times of the modified group is between 57 and 159.99 seconds less than
# that of the conventional group. Our best estimate is that the modified group is 108.5 seconds faster. 



#Ho: Median of Modified and Conventional Scores are equal 
#Ha: Median of Modified scores is less than that of Conventional 

#Critical value (left-side): -1.645 (alpha = .05)
qnorm(0.05)
#Test Statistic: t-stat (Z) = -3.0183
#p-value (left-sided): = .0013 
#Reject Ho 



#Statistical Conclusion: The data provide convincing evidence that a student could solve the problem faster
#after the modified rather than the conventional method (1-sided, normal approximation with continuity correction p-value = 0.0013, from rank sum test).
#We are 95% confident that the median of the times of the modified group is between 57 and 160 seconds less than that
#of the conventional group. Our best estimate is that the median of the modified group is 108.5 seconds faster. 









#Extra Thought 
#to deal with ties, it employs exact conditional inference, seamlessly accommodating ties in permutations
#and if you require an exact p-value
#install.packages("coin")
library(coin)

wilcox_test(scores ~ as.factor(testMethod), data = mydata, 
            alternative = "greater", distribution = "exact")
