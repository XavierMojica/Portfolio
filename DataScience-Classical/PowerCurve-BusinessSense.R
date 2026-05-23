#Power Curve: 1 Sample 

#Effect Size 
powerholder = c()
effectsizes = seq(50,700, length =20)

for(i in 1:20){
  powerholder[i] = power.t.test(n = 8, delta = effectsizes[i], sd = 500, sig.level = .1, 
                                type = 'one.sample', alternative = "one.sided")$power
}
plot(effectsizes, powerholder, type = 'l', col = 'darkgreen', main = "Power Curve", 
     ylab = 'Power', lwd = 2)



#Sample Size 
#What a Business can look at to see their affordablility per unit to get the best Power possible
powerholder = c()
samplesizes = seq(3, 24, by =2)

for(i in 1:11){
  powerholder[i] = power.t.test(n = samplesizes[i], delta = 450, sd=500, sig.level = .1,
                                type = "one.sample", alternative = "one.sided")$power
}
plot(samplesizes, powerholder, type = 'l', col = 'orange', main="Power Curve", ylab = 'Power', lwd =2)






#Power Curve: 2 Sample 


#Effect Size 
powerholder = c()
effectsizes = seq(.1,5, length =20)

for(i in 1:20){
  powerholder[i] = power.t.test(n = 65, delta = effectsizes[i], sd = 4, sig.level = .01, 
                                type = 'two.sample', alternative = "one.sided")$power
}
plot(effectsizes, powerholder, type = 'l', col = 'darkgreen', main = "Power Curve", 
     ylab = 'Power', lwd = 2)


#Sample Size 
powerholder = c()
samplesizes = seq(10, 200, length =25)

for(i in 1:25){
  powerholder[i] = power.t.test(n = samplesizes[i], delta = 1.6, sd=4, sig.level = .01,
                                type = "two.sample", alternative = "one.sided")$power
}
plot(samplesizes, powerholder, type = 'l', col = 'orange', main="Power Curve", ylab = 'Power', lwd =2)


