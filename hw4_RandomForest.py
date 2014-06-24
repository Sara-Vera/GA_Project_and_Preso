# First, I ran a K-means partitioning cluster analysis on 300K rows of user data to find clusters. Once I had clusters, 
# I wanted to know which variables were most predictive of which cluster a user belongs to, so I chose a Random Forest model.


import pandas as pd
import numpy as np
import pandas.rpy.common as com
from sklearn.ensemble import RandomForestClassifier
from sklearn import metrics

data = pd.read_csv('fit_cluster.csv') # Load Data

data.head() # To see variables

fit_cluster = pd.Categorical.from_array(data['fit_cluster'])

X = data[['gender', 'age', 'follows_count', 'action_count', 'post_count', 'activity_count', 'campaign_count', 'getting_connected',
'has_fb', 'invites_received', 'invites_sent', 'messages_received', 'messages_sent', 'pers_campaigns', 'recruits_count', 'sticker_count',
'animal', 'env', 'human_rights', 'vet', 'politics', 'health', 'child']]
y = fit_cluster

clf = RandomForestClassifier(n_estimators=500, oob_score=True).fit(X, y)

# predict on training data just for testing
y_predict = clf.predict(X)

# OOB score (how to interpret?)
print 'OOB score: %.2f\n' % clf.oob_score_

# confusion matrix on training data
print 'Confusion matrix:'
print metrics.confusion_matrix(y, y)

# print 'feature_importances: '
print 'feature_importances: ' + str(len(clf.feature_importances_)) # Check the number of variables just to see. 23 is correct!
print 'feature_importances: ' + str(clf.feature_importances_) # Actual importance numbers. The larger, the more important. Not easy to interpret other than that. 
