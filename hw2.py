import pylab 
import numpy
import pandas
from sklearn.linear_model import LinearRegression

read_file = pandas.read_csv('hw2_data.csv') 
 

file_len = len(read_file)           # if file_len == 100

data = read_file.drop(['campaign_id', 'created_at'], axis = 1)
y = read_file['num_actions']

# My data is organized from most actions to fewest actions. How do I scramble it for testing? 


test_index = file_len*0.3           # test_index = 30

X_train = data[0:-test_index]       # X_train = data[0:70]
X_test = data[-test_index:]         # X_test = data[70:100]

y_train = y[:-test_index]           # Y_train = data[0:70]
y_test = y[-test_index:]            # Y_test = data[70:100]

# create linear regression object
model = LinearRegression()

# train the model using the training data set
model.fit(X_train, y_train)


print '\n The coefficients are: \n', model.coef_

# The coefficients are:
# [  3.94129174e-15   2.67450091e-15   1.69395627e-16   1.00000000e+00]

print '\n The intercept is: \n', model.intercept_

# The intercept is:
# -2.91038304567e-10

#score(X y) returns the R^2 of the prediction, or 1-u/v, u = ((y_true-y_predicted)**2).sum(), v = ((y_true-y_true.mean())**2).sum()
#best score is 1.0, lower scores are worse
print ('\n Residual sum of squares: %.2f \n' % numpy.mean((model.predict(X_test) - y_test) **2))

# Residual sum of squares: 0.00

#explained variance score: 1 is perfect prediction
print ('\n Variance score: %.2f \n' % model.score(X_test, y_test))

#Variance score: 1.00