# 1 Sample Hypothesis Test 

# T Testing : 2 Sided
#Ho: mu = 128
#Ha: mu != 128 
# alpha = .05
#xbar = 130 
#s = 15
#n = 120 

#critical values 
#t(.975, 119) = +/- 1.9801
qt(.05/2, 119)
qt((1-.05/2), 119)

#pvalue 
#use the  the Test statistics t = (130-128)/(15/sqrt(120)) = 1.46
pt(1.46,119, lower.tail = FALSE)
numb= (0.0734*2)
numb

#Conclusion: There is not enough evidence to suggest the mean emotional score is different from 128 (pvalue = .1470)




#1 Sample: 1 Sided Test
#Ho: mu = 128
#Ha: mu > 128  , right side 
# alpha = .05
#xbar = 130 
#s = 15
#n = 120 


#critial value 
qt(.95, 119)


#Test statistic 
# t = (130-128)/(15/sqrt(120)) = 1.46 

pt(1.46, 119, lower.tail = FALSE)

#Fail to reject Ho : There is not enough evidence to suggest hte man emotional score is diff from
#(greater than) 128 (p-value = .0735)




#Example 
#The folloing are ages of 7 randomly chosen patrons seen leaving a bar at 7pm. We assume the data come from a normal distribution adn would 
#like to test the claim that the mean age of the distribution of patrons is different than 21. 


ages = c(25, 19, 37, 29, 40, 28, 31)


#Step 1: Ho: mu = 21 , Ha: mu =! 21 
#Step 2: Draw and shade and Find Critical Value 
#alpha = .05 , df = 7 so 7-1=6 
qt(0.05/2, 7-1)
qt(.975, 6)

#Step3: Test statistic 
#t = (xbar - mu)/ (s/sqrt(n))
#t = 29.86-21 / (7.08/ sqrt(7)) = 3.31  which is the t from the t.test in this case t = 3.3093

#Step 4: Find the p-value: The probability of observing by random chance something as extreme or more extreme than what was observed
#under the assumption that the null hypothesis is true. The red shaded region above is 0.0162 (sum of both red areas)
#Pvalue = 0.0162 and is less than alpha = .05

t.test(ages, mu =21, alternative = 'two.sided')

#Step5: The sample mean we found is very unusual under the assumption that the true mean age is 21. We Reject the 
#assumption that the true mean age is 21. We Reject Ho. 

#Step6: There is sufficient evidence to conclude tha tthe true mean age of patrons at the bar at 7pm is not equal to 21 (pvalue = 0.0162 from a t-test). We could 
# say that there is sufficient evidence to conclude that the true mean age is great than 21. We are 95% confident that the true mean age at the bar at this time is contained 
# in the interval (23.3, 36.4) years. This was nota. random ssample of all times only at 7pm; thus, the result cannot be applied to the bar at all times. 
#The results are nevetheless intriguing. 




