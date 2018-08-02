# Import the Data
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split

iris_dataset = load_iris()
X, y = iris_dataset.data, iris_dataset.target
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=31)

# View the Data
import numpy as np
import pandas as pd

df = pd.DataFrame(
        data=np.c_[X,y], 
        columns=iris_dataset['feature_names'] + ['target'])
df.sample(frac=0.1)

# Pre-Processing
from sklearn import preprocessing
    
scaler = preprocessing.StandardScaler().fit(X_train)
X_train = scaler.transform(X_train)
X_test = scaler.transform(X_test)

# Training and Generalization
from sklearn import svm
from sklearn.metrics import accuracy_score

clf = svm.SVC(gamma=0.001, C=100.)
clf.fit(X_train, y_train)
        
y_pred_train = clf.predict(X_train)
y_pred_test = clf.predict(X_test)
        
acc_train = accuracy_score(y_train, y_pred_train) 
acc_test = accuracy_score(y_test, y_pred_test)

from sklearn.metrics import confusion_matrix

confusion_matrix = confusion_matrix(y_test,y_pred_test)