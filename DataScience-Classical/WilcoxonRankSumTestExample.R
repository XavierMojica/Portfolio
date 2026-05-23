library(stats)

#DF, testMethod using new or traditional and scores from individual subjects 
scores = c(37, 49, 55, 77, 23, 31, 46)
testMethod = c("New", "New", "New", "New", "Trad", "Trad", "Trad")


# making a dataframe from 2 vectors
mydata = data.frame(nums = scores,vars = testMethod)

print(mydata)

#Wilcoxon Rank Sum Test 
wilcox.test(scores~testMethod, alternative = "greater") #two.sided, less, greater
#wilcoxon rank sum test with exact 
wilcox.test(scores~testMethod, exact = TRUE, alternative = 'greater') #careful with EXACT bc can crash with more Ns


#Ho: The median of New Method Scores = The median of the Traditional Method Scores 
#H1: The median of New Method Scores > The median of the Traditional Method Scores 

#There is sufficient evidence at the alpha = 0.1 level of significance (p-value = .0571 for the exact test for the Wilcoxon Rank Sum Test) 
#to suggest that the median of IBM employees that were given the New Method is greater than the median of those who took the test having had 
#the Traditional Method of instruction. 
