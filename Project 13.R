# import the data 

df <- read.csv("Project #12 sales data.csv")

head(df)

#create dummy variables for each quarter

df <- df %>% 
  mutate(Q1 = ifelse(Quarter %in% c(1,5,9,13,17), 1, 0), # create dummy variable for Q1
         Q2 = ifelse(Quarter %in% c(2,6,10,14,18), 1, 0), # create dummy variable for Q2
         Q3 = ifelse(Quarter %in% c(3,7,11,15,19), 1, 0)) # create dummy variable for Q3

# preform a linear regression and visuals QQ, K.S etc..

model <- lm(Sales~ t + Q1 + Q2 +Q3, data = df)

summary(model)

r <- model$residuals

standard_r <- r/sd(r)

qqnorm(r)
qqline(r)
# does not appear to be normally distributed

ks.test(standard_r,'pnorm')



# preform a linear regression and visuals QQ, K.S etc this time with Q1 removed..

model.2 <- lm(Sales~ t + Q2 +Q3, data = df)

summary(model.2)

r.2 <- model.2$residuals

standard_r.2 <- r.2/sd(r.2)

qqnorm(r.2)
qqline(r.2)

ks.test(standard_r.2,'pnorm')




# here we gett a high K.S p-value of 0.92
# this would mean there is strong evidence that the distrubtions are from the
# same population. Fail to reject the null hypo, no sign diff.


# perfrom a Durbin_Watson test
library(car)

durbinWatsonTest(model)
# looks like we have 0.794 for the p-value
# a high p-vale indicates there is little evidence for autocorrelation


#d.	Compute forecasts for t = 21, 22,23, 24.  Include a 95% confidence for each forecast.  
#Make sure for each time you input the dummy variables correctly.
newdata <- data.frame(t = c(21,22,23,24),
                     Q1 = c(1,0,0,0),
                     Q2 = c(0,1,0,0),
                     Q3 = c(0,0,1,0))


pred <- predict(model, newdata, interval = 'confidence', level = 0.95)

result <- cbind(newdata, pred)
colnames(result)[5:7] <- c("Forecast", "Lower CI", "Upper CI")
print(result)










