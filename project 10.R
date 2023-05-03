df <- Project_N10_logit_cleveland
# data cleaning making some variables factors

df[df=='?'] <- NA
df$Sex <- ifelse(df$Sex == 0, "F", df$Sex)
df$Sex <- ifelse(df$Sex == 1, "M", df$Sex)
df$Sex <- as.factor(df$Sex)


df$CP <- as.factor(df$CP)
df$fbs <- as.factor(df$fbs)
df$restecg <- as.factor(df$restecg)
df$exang <- as.factor(df$exang)
df$slope <- as.factor(df$slope)

df$thal <- as.integer(df$thal)
df$thal <- as.factor(df$thal)

df$ca <- as.integer(df$ca)
df$ca <- as.factor(df$ca)

df$hd <- ifelse(test =df$hd==0,
                yes= 'healthy',
                no = 'unhealthy')

df$hd <- as.factor(df$hd)

str(df)
nrow(df[is.na(df$ca)| is.na(df$thal),]) # no rows of NAs


xtabs(~ hd +Sex, data= df) # want a table with heart disease and sex
# both samples have a good amount of observations in each

# now to verify all the levels of CP

xtabs(~ hd +CP, data= df)

xtabs(~ hd +fbs, data= df)

xtabs(~ hd +restecg, data= df) # only 4 patients represent a level 1, might need to be removed later

xtabs(~ hd +exang, data= df)
xtabs(~ hd +slope, data= df)
xtabs(~ hd +ca, data= df)
xtabs(~ hd +thal, data= df)


# logistic regression
heart_disease <- glm(hd ~., data= df, family = 'binomial')
summary(heart_disease)
#chol,exang1,slope2,ca1,ca2,thal7 #

model.glm <- glm(hd~chol+exang+slope+ca+thal, data = df, family= 'binomial')
summary(model.glm)

# MCFadden's Pseudo R^2

ll.null <- heart_disease$null.deviance/-2
ll.proposed <- heart_disease$deviance/-2

pseudo_R <- (ll.null-ll.proposed)/ll.null
pseudo_R

#perform an odds-ratio (ORS)
exp(coef(model.glm))

#c.	Estimate the probability of having heart disease for a person with the following characteristics: Sex = M,Trestbps = 120,Slope = 2, Ca = 0, Thal = 3,CP = 2

#calculate it 'manually'
#-.3673668 + 0.002123*(chol) + 1.439016*(exang1)+ 1.357262(slope = 2)+
#1.160986(slope = 3) +1.818029(ca = 1) +
# 2.856888( ca = 2) +2.642351(ca = 3)+
#1.068293(thal = 6) +2.030995(thal = 7)

(exp(-.3673668 + 0.002123 + 1.439016 + 1.357262+
     1.160986 + 1.818029+
     2.856888 + 2.642351+
       1.068293 + 2.030995))

# make the prediction data frame
new.data<- as.data.frame(matrix(c(Sex = 'M',Trestbps = 120,Slope = 2, 
                                  Ca = 0, Thal = 3,CP = 2), nrow = 1))

# give it column names
colnames(new.data) <- c('Sex',"trestbps",'slope','ca','thal','CP')

# change the data to the same type as og

new.data[,1] <- as.factor(new.data[,1])# Sex
new.data[,2] <- as.numeric(new.data[,2])# trestbps
new.data[,3] <- as.factor(new.data[,3])#slope
new.data[,4] <- as.factor(new.data[,4])#Ca
new.data[,5] <- as.factor(new.data[,5])#thal
new.data[,6] <- as.factor(new.data[,6])#CP


model.glm_2 <- glm(hd~Sex+trestbps+ca+thal+CP, data = df, family= 'binomial')

predict.glm(model.glm_2, newdata= new.data,
            type = 'response')

# graph
predicted.data <- data.frame(probability.of.hd= model.glm$fitted.values,hd=df$hd)

predicted.data <- predicted.data[order(predicted.data$probability.of.hd, decreasing= F),]
predicted.data$rank <- 1:nrow(predicted.data)

ggplot(data = predicted.data, aes(x = rank, y = probability.of.hd))+
  geom_point(aes(color=hd), alpha = 1, shape = 4, stroke = 2)+
  ggtitle("Logisitc curve for the Probability of Heart Disease")+
  xlab('Index')+
  ylab("predicted probability of getting heart disease")





















































