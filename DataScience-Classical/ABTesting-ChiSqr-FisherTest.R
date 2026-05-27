#Load Libraries 
#install.packages(c("lubridate", 'tidyverse'))

library(tidyverse)
library(lubridate)


#read in data file 
data = read.csv("/Users/xaviermojica/Downloads/ab_data.csv", header = TRUE)

#5 top rows of data
head(data)
#data types 
str(data)

#convert variables 
data$timestamp = ymd_hms(data$timestamp)
str(data)


##Duplicate Check 
sum(duplicated(data))

#check for user ids 
sum(duplicated(data$user_id))
#so now we can see that we have duplicated entries for user ids 


# Show rows where user_id appears more than once
duplicates = data %>% group_by(user_id) %>%
  filter(n() > 1) %>% arrange(user_id)

head(duplicates, 20)


#Finding Mismatches 

mismatch = data %>% filter((group == "treatment" & landing_page == "old_page") |
                              (group == "control" & landing_page == "new_page"))

mismatchNum = nrow(mismatch)

cat( "Number of mismatches:", mismatchNum, "rows or", 
     round(mismatchNum / nrow(data) * 100, 2), "%\n")



#Clean UP Data 

data2 = data %>% filter((group == "treatment" & landing_page == "new_page") | 
  (group == 'control' & landing_page == 'old_page')) %>% distinct(user_id, .keep_all = TRUE)

#check dimensions 
dim(data2)


#Counts and Ratios 
control_data = data2 %>% filter(group == "control")
treatment_data = data2 %>% filter(group == "treatment")

df_counts = data.frame(Control_COUNT =table(control_data$converted),
  Treatment_COUNT = table(treatment_data$converted),
  Control_RATIO =table(control_data$converted) / nrow(control_data),
  Treatment_RATIO =table(treatment_data$converted) / nrow(treatment_data))

df_counts


#Visuals 
# Histogram of conversions
ggplot(data2, aes(x = factor(converted), fill = factor(converted))) +
  geom_bar() +
  labs(title = "Distribution of Total Data", x = "Converted", y = "Count") +
  scale_fill_manual(values = c("0" = "steelblue", "1" = "gold"),name = "Converted")

# Conversion by group
ggplot(data2, aes(x = factor(converted), fill = factor(converted))) +
  geom_bar(position = "dodge") +
  labs(title = "Conversion by Version", x = "Converted", y = "Count") +
  scale_fill_manual(values = c("0" = "steelblue", "1" = "gold"),name = "Converted")

# Conversion rate by group
ggplot(data2, aes(x = group, y = converted, fill = group)) +
  stat_summary(fun = mean, geom = "bar") +
  labs(
    title = "Conversion Rate by Group",x = "Group", y = "Conversion Rate") + 
  scale_fill_manual(values = c("control" = "steelblue", "treatment" = "gold"),name = "Converted")



#Table 

table_ab =table(data2$converted, data2$group)
table_ab

#Chi Square 

chisquare = chisq.test(table_ab)
chisquare 

#expected frequencies
chisquare$expected

alpha = 0.05

if(chisquare$p.value <= alpha){
  print("Dependent (Reject Ho)")
} else{
  print("Independent (Fail to Reject Ho")
}

#Fisher Test 
fisher_test = fisher.test(table_ab)
fisher_test

if (fisher_test$p.value <= alpha) {
  print("Dependent (Reject H0)")
} else {
  print("Independent (Fail to Reject H0)")
}



###AB Test FN

AB_testing = function(dataFrame, group, metric) {
  
  size=nrow(dataFrame)
  
  # Contingency table
  table_ab = table(
    dataFrame[[metric]],
    dataFrame[[group]]
  )
  
  if (size < 1000) {
    
    test = fisher.test(table_ab)
    
    test_name = "Fisher Exact Test"
    
  } else {
    
    test = chisq.test(table_ab)
    
    test_name = "Chi-Square Test"
  }
  
  result =data.frame(
    Test = test_name,
    P_value = test$p.value,
    AB_Hypothesis =
      ifelse(
        test$p.value < 0.05,
        "Reject H0",
        "Fail to Reject H0"
      ) #,
  #  Comment =
   #   ifelse(
    #    test$p.value < 0.05,
     #   "A/B groups are not similar!",
      #  "A/B groups are similar!"
      #)
  )
  
  return(result)
}


#AB Test Run 
AB_testing(
  dataFrame = data2,
  group = "group",
  metric = "converted"
)