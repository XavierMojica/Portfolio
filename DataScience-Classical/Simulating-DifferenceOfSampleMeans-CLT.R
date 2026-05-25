# 2 Samples: The Differences of Sample Means 

#Simulation 

n1 = 50 #sample size
n2 = 50 
simulations = 10000 #number of of xbars to be generated 
#mu = 0 ; mean parameter for use with normal distribution 
#sigma = 1, standard deviation parameter for use with normal distributions 

population = rnorm(10000000, 10,1)
hist(population, col = 'brown', mani = 'Population 1 Histogram')
mean(population)
sd(population)

population2 = rnorm(10000000, 10,1)
hist(population2, col = 'darkgreen', main ='Population 2 Histogram')
mean(population2)
sd(population2)

#Data holder to view 
xbar_holder1 = numeric(simulations)
xbar_holder2 = numeric(simulations)
DiffOfxbars = numeric(simulations)

#Simulation
#Generate 1000 samples each of ssize 10 and find the mean of each sample. 
#Store each mean in the xbar_holder vector 
for (i in 1:simulations){
  sample1 = sample(population, n1)
  sample2 = sample(population2, n2)
  
  xbar1 = mean(sample1)
  xbar2 = mean(sample2)
  xbar_holder1[i] = xbar1
  xbar_holder2[i] = xbar2 
  DiffOfxbars[i] = xbar1 - xbar2 
}


#View the distribution of sample means 
par(mfrow = c(3,1), mar = c(4,4,2,1))
hist(xbar_holder1, col = 'gold', main = paste("Distribution of the Sample Means: n =", n1), xlab = 'Dist 1 Sample Means')
hist(xbar_holder2, col = 'navyblue', main = paste("Distribution of Sample Means: n =", n2), xlab = 'Dist 2 Sample Means')
hist(DiffOfxbars, col = 'beige', main = 'Distribution of the Difference of Sample Means', xlab = 'Difference of Sample Means') 
#for the diffofxbars, thats what we look when we do a 2 sample test, it is centered at mu1 - mu2
#if the 2 means we are trying to look at the difference are the same, then the sample means usually will be centered at 0 or close to 0
#Step 2: in a 2 sample hypothesis test, we look at Distribution of Xbar1 - Xbar2 


#Summary Statistics of the Distribution of the Simulated Sample Means 
summary(xbar_holder1) #summary and the mean 
summary(xbar_holder2)
sd(xbar_holder1) #standard deviation of distribution 
sd(xbar_holder2) #standard deviation of distribution 2 

mean(DiffOfxbars)
sd(DiffOfxbars)




