# IRIS DATASET

# from __future__ import division
import numpy as numpy # a numeric library for working with numbers (matrices, vectors)
from sklearn import datasets # from my package, use datasets which has the iris dataset
from sklearn.neighbors import KNeighborsClassifier # use the function that's already set-up to run KNN classifier

iris = datasets.load_iris() 
iris_x = iris.data # I can't figure out what this is. Giving me an attribute error:AttributeError: 'Bunch' object has no attribute 'datasets' -- fixed. Had to change to "data"
iris_y = iris.target
np.unique(iris_y)

np.random.seed(0)
indices = np.random.permutation(len(iris_X)) #len(iris_x) = 150
iris_x_train = iris_x[indices[:-10]]
iris_y_train = iris_y[indices[:-10]]
iris_x_test = iris_x[indices[-10:]]
iris_y_test = iris_y[indices[-10:]]

knn = KNeighborsClassifier()
knn.fit(iris_x_train, iris_y_train)
prediction = knn.predict(iris_x_test)




# TESTING FOR ACCURACY
def accuracy(prediction, iris_y_test):
    diff_count = 0
    for i, j in zip(prediction, iris_y_test):
        if i != j:
            diff_count +=1
    return diff_count
print "Only " + str(accuracy(prediction, iris_y_test)) + " data point was classified incorrectly"

print "In other words, there was " + str(int((1 - accuracy(prediction, iris_y_test)/len(prediction))*100))+"%" + " accuracy"

#knn.score(iris_X_train, iris_y_train)
knn.score(iris_X_test, iris_y_test)








# VISUALIZATION
import pylab as pl
from matplotlib.colors import ListedColormap

n_neighbors = 15

X = iris.data[:, :2] #for visualization, we are only grabbing the first two features
Y = iris.target

h = .02  # step size in the mesh

# create color maps
cmap_light = ListedColormap(['#FFAAAA', '#AAFFAA', '#AAAAFF']) #color for the boundaries
cmap_bold = ListedColormap(['#FF0000', '#00FF00', '#0000FF']) #color for the points

for weights in ['uniform', 'distance']:
    # create an instance of Neighbours Classifier and fit the data
    clf = neighbors.KNeighborsClassifier(n_neighbors, weights=weights)
    clf.fit(X, y)

    # plot the decision boundary: assign a color to each point in the mesh [x_min, m_max]x[y_min, y_max]
    x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
    y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
    
    xx, yy = np.meshgrid(np.arange(x_min, x_max, h),
                         np.arange(y_min, y_max, h))

    Z = clf.predict(np.c_[xx.ravel(), yy.ravel()])

    # put the result into a color plot
    Z = Z.reshape(xx.shape)

    pl.figure()
    pl.pcolormesh(xx, yy, Z, cmap=cmap_light)

    # plot also the training points
    pl.scatter(X[:, 0], X[:, 1], c=y, cmap=cmap_bold)
    pl.xlim(xx.min(), xx.max())
    pl.ylim(yy.min(), yy.max())
    pl.title("3-Class classification (k = %i, weights = '%s')"
             % (n_neighbors, weights))
pl.show()


from sklean.cross.validation import KFold
X = np.array([[0., 0.], [1., 1.], [-1, -1.], [2., 2.]])
Y = np.array([0, 1, 0, 1])
kf = KFold(len(Y), n_folds=2, indices=False)
print(kf)


for train, test in kf:
     print("%s %s" % (train, test))


X_train, X_test, y_train, y_test = X[train], X[test], Y[train], Y[test]


X = np.array([[0., 0.], [1., 1.], [-1., -1.], [2., 2.]])
Y = np.array([0, 1, 0, 1])

kf = KFold(len(Y), n_folds=2, indices=True)
for train, test in kf:
     print("%s %s" % (train, test))     



# to run my code: python hw1.py
# to install package: easy_install package_name
