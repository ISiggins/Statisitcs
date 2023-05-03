df <- Project_8_Social_Worker_Salary_data

#initial calculation; mean, std

mean_salary <- mean(df$Salary)
std_salary <- sd(df$Salary)

mean_years <- mean(df$Years)
std_years <- sd(df$Years)

#Preform the following regression analysis

#Linear Regression of Social Worker Salary vs Years of Service

fit1 <- lm(Salary~ Years, data = df)
summary(fit1)

ggplot(df, aes(Years, Salary))+
  geom_point()+
  geom_smooth(method = 'lm',se = T)+
  theme_bw()


#Quadratic Regression of Social Worker Salary vs Years squared

fit2 <- lm(Salary ~poly(Years, 2), data = df) 
summary(fit2)

ggplot(df, aes(Years, Salary))+
  geom_point()+
  geom_smooth(method = 'lm',se = F)+
  geom_smooth(method = 'lm', se = T,
             formula = 'y~ poly(x, 2)', color = 'red')

# log regression where dependent variable is log(Salary)
fit3 <- lm(log(Salary)~ Years , data = df)
summary(fit3)

df <- df %>% 
  mutate(yhat = predict(fit3))

ggplot(df, aes(Years, Salary))+
  geom_point()+
  geom_line(aes(Years, exp(yhat)), color = 'orange', size = 1.5)

#d.	Log-Log model where the dependent variable is Log(Salary) and the independent variable is Log(Years of Service)
fit4 <- lm(log(Salary)~ log(Years), data = df)
summary(fit4)
df_log <- data.frame(x=log(df$Years),
                     y = log(df$Salary))
ggplot(df_log, aes(x=x, y=y))+
  geom_point()+
  geom_smooth(method = 'lm', se = T)+
  labs(title='Log-Log Plot', x='Log(Years)', y='Log(Salary)') +
  theme_minimal()


# Q-Q plot for Years
qqnorm(df$Years)
qqline(df$Years, col = 'blue')


# Q-Q for Salary
qqnorm(df$Salary)
qqline(df$Salary, col = 'green')

# K.S. test for fit 1

fit <- lm(Salary~ Years, data = df)
r <- residuals(fit)

hist(r)

qqnorm(r)
qqline(r)
standres <- r/sd(r)

ks.test(standres,'pnorm')


#K.S test for fit2

r_2 <- residuals(fit2)
hist(r_2)
qqnorm(r_2)
qqline(r_2)

standres_2 <- r_2/sd(r_2)
ks.test(standres_2,'pnorm')

#K.S test for fit3

r_3 <- residuals(fit3)
hist(r_3)
qqnorm(r_3)
qqline(r_3)

standres_3 <- r_3/sd(r_3)
ks.test(standres_3,'pnorm')


#K.S test for fit4

r_4 <- residuals(fit4)
hist(r_4)
qqnorm(r_4)
qqline(r_4)

standres_4 <- r_4/sd(r_4)
ks.test(standres_4,'pnorm')

#Using the model you chose from 2h., estimate the salary for someone with years of service = 19 years
# I picked the log model

# Fit the linear regression model log
fit3 <- lm(log(Salary) ~ Years, data = df)

# Predict the salary for someone who has 19 years of service
new_data <- data.frame(Years = 19)
salary_pred <- exp(predict(fit3, new_data))

# Print the predicted salary
salary_pred

# determine the confidence interval 95% for age
n <- 50
a <- 50170.54
s <- 18530.09
error <- qnorm(0.975)*s/sqrt(n)
lower_bound <- a - error
upper_bound <- a + error



