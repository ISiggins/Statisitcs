# Statisitcs
These are some projects I worked on in my Masters program. 
Show caseing various regression skills from PCA to Forecasting with auto-Arima.

Project 8:
Introduction:
	The data set has the salary of social workers and how many years of service they have completed. 
  The goal of the experiment is to be able to build a model, that can accurately predict the salary of a person based on the number of years they have worked. 
  With over 50 observations the dataset is large enough that there is no need to manipulate the data in any way. 
Summary:
	The experiment was done with four regression models; linear, quadratic, log of one variable, and Log-Log. 
  After running each model, they would be compared based on their respective R^2 values to see which model would account for the most variance in the dataset. 
  Then K.S. test would be conducted to determine if the models would show a normal distribution. 
  Based on the two results, a decision would be made on which model to choose that would predict the best result within a confidence interval of 95%.


Project 9:
Introduction:
 Principal Component Analysis (PCA) is a standard unsupervised machine learning algorithm. 
 It can be used in exploratory data analysis, reducing dimensionality, and information compression. 
 In this particular dataset, we are reducing it to a few components to increase our model’s accuracy in prediction.

Summary: 
In this particular model, it was the first two components that already accounted for 92% and 96% variance of the respective components. 
Based on cumulative proportions, it was determined that only two components needed to be used for the predicted model. 
From there the models used were a log model because the K.S test for the second component was less than >.2. 
Then after an appropriate model was determined, it was to be tested on a prediction model dataset.



Project 10:
Introduction:
Data was collected from the Cleveland hospital to help create a model to predict the likelihood of heart disease, based on various lab values. 
Heart disease is one of the leading causes of death in the United States. 
With an ever-increasing awareness of the side effects of medications, it will be imperative to understand alternative ways to decrease the likelihood of heart disease. 

Summary:
The statistical test that was run was a general linear model(GLM), used for continuous responses variable given continuous and/or categorical predictions.
This was used to understand the 14 fields observed, and which ones were actually significant to the prediction model. 
The results in the 6 fields being significantly high in the model; cholesterol(chol), exercise induce angina(exang), amount of major vessels clogged(ca), and if they have reversible thalassemia(thal).
Cholesterol is needed to build healthy cells, but high levels of cholesterol can develop fatty deposits around your blood vessels and arteries. 
This will increase overall blood pressure and increase the patient's likelihood of a heart attack or stroke.
Exercise-induced angina happens when oxygen demand increases, for example running or spriting.
But when in a state of rest and this happens it is a cause for concern. 
The variable ca is the number of major vessels that are calcified, resulting in less blood getting to the heart. 
Thal is for thalassemia, which is an inherited blood disorder that is caused when the body doesn't make enough hemoglobin.


Project 13:
Introduction:
This data set is about quarterly sales and predicting future sales to see if there is any correlation between the quarters.  
Summary:
The test mainly used in this experiment is the Durbin-Watson test, which checks for autocorrelation in the residuals of the statistical regression analysis.
If there does appear to be autocorrelation, it will undervalue the standard error and present predictors that seem significant when they are not. 
The two values for inspection would be the p-value and the D-Wvalue. The results of that presented a p-value of .768, with a D-W statistic being 2.17.
The high p-value indicates there is little evidence of autocorrelation. The D-W testing also shows there is little chance of autocorrelation.  
The statistical analysis test was a simple regression with the independent variables being; t(time), Q1, Q2, and Q3, for the quarters. 
The dependent variable is the Sales observation. 
Based on the results we can see that all the independent variables are significant, but Q1 has the least influence on the model.
But the results also have a very high R^2 value of 98%. 
A Kolmogrov-Smirnov test also has a p-value of 91%, showing that this data does not present a normal distribution.  
Just for a sake of completion, I removed the Q1 to see how it would affect our QQ plots and other metrics. 
The QQ plot does seem more normally distributed, but upon looking closer at the shifting of the y -values, it is actually less normally distributed. 
This is further supported with an even higher K.S p-value of 98%.
Putting back Q1, a prediction was made for the future quarters of 21,22,23, and 24.
This was done with a confidence interval of 95%, and upon surface level appearance it falls in the current trend of increasing sales over time. 

