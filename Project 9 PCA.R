df <- Project_9_Car_MPG_Princ_Comp

df

#a.	Consider Cylinders, Displacement, Horsepower, and Weight as independent variable in your analysis.
#b.	Perform a principal component analysis on these 4 variables.

independent <- df[,2:5]

X1 = independent[,1]
X2 = independent[,2]
X3 = independent[,3]
X4 = independent[,4]

myPr <- prcomp((independent), scale = T)
summary(myPr)

#just shows the cumulative proportions
cum_var <- cumsum(myPr$sdev^2 / sum(myPr$sdev^2))
cum_var

# make a matrix of PC

pc_matrix <- myPr$x
pc_matrix

# confirm matrix is diagonal ( it is)

corpc_matrix <- cor(pc_matrix)
corpc_matrix

# identify each pc in vector form for regression

pc_1 <- pc_matrix[,1]
pc_1
pc_2 <- pc_matrix[,2]
pc_3 <- pc_matrix[,3]
pc_4 <- pc_matrix[,4]

# compute PCA regression for MPG ~ pc_1

reg_pc1 <- lm(df$MPG~pc_1)
summary(reg_pc1)
# QQ Plot

r <- reg_pc1$residuals

standardize_r <- r/sd(r)

qqnorm(r)
qqline(r)

# K.S test
ks.test(standardize_r, 'pnorm')


#K.S is less than 2 so we must consider a nonlinear model
# we will first use a Log(MPG)~ pc_1

fit_log <- lm(log(MPG) ~(pc_1), data = df) 
summary(fit_log)

# QQ Plot

r_log <- fit_log$residuals

standardize_r_log <- r_log/sd(r_log)

qqnorm(r_log)
qqline(r_log)

ks.test(standardize_r_log,'pnorm')

# Compute regression for MPG~ pc_3

reg_pc2 <- lm(log(MPG) ~pc_3, data = df)
summary(reg_pc2)

# QQ Plot

r_2 <- reg_pc2$residuals

standardize_r_2 <- r_2/sd(r_2)

qqnorm(r_2)
qqline(r_2)

# K.S test
ks.test(standardize_r_2, 'pnorm')


#d.	Using your final model, estimate MPG for Cylinders = 16, Displacement = 380, Horsepower = 195, and Weight = 2950


# model
lm_model <- lm(log(MPG) ~ pc_1 + pc_3, data = df)
lm_model
pred_df <- data.frame(Cylinders= 16,Displacement = 380,Horsepower = 195,Weight = 2950)

pcr_pred <- exp(predict(lm_model, newdata = pred_df))
pcr_pred

idx <- floor(0.75* nrow(df))

train_ind <- sample(seq_len(nrow(df)), size = idx)
train <- df[train_ind, ]
test <- df[-train_ind, ]

pcr_model <- pcr(MPG ~ .,
                 data = train,
                 scale = T,
                 validation = 'CV')

summary(pcr_model)
pcr_pred <-exp(predict(pcr_model, test, ncomp = 2))
pcr_pred
rmse(actual = test$MPG, predicted = as.numeric(pcr_pred))
