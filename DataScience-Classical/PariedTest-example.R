#Paired Data

#Data points taken on the same subjects ie. exams/medical 
#Ho: Mafter-before = 0 
#Ha: Mafter-before !=0

#Princeton Review and SAT, BeforePR is baseline exam without preperation, AfterPR is with princton review preperation

BeforePR = c(490,490,500,500,510,510,510,520,530,530,530,540,540,540,550,550,570,570,580,590,590,590,600,600,610,614,620,610,620,630,640)
AfterPR = c(560,550,560,550,580,560,560,590,570,580,590,590,580,590,610,620,620,620,620,610,620,620,640,630,630,640,630,640,630,630,610)

scores = data.frame(BeforePR = BeforePR, AfterPR = AfterPR)

t.test(x =scores$AfterPR , y = scores$BeforePR , paired = TRUE)

#Conclusion: There is overwhelming evidence to suggest that the Princeton Review has a positivie effect on students'
#SAT grades. There is overwhelming evidence that the mean increase in score is positive (p-value < 0.00000000006). We
#are 95% confident that hte mean increase in SAT score after taking the Princeton Review is contained in the interval (32.13, 48.90 points). This
#increase can nly be assumed to apply to students at WT White High School. 