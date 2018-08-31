# Easy Machine Learning with Python on WSL and VS Code
This tutorial is a simple machine learning classification tutorial using Python, scikit-learn, and pandas. The steps are based on [this](https://blog.paperspace.com/getting-started-with-scikit-learn/) blog post.

## Story
This demo will showcase how students can build a predictive model for machine learning classification using Python and the Windows Subsystem for Linux. They can use the popular scikit-learn toolset to build a model that uses flower iris data to classify the species type. Students can easily get started with machine learning in Linux on Windows using the Windows Subsystem for Linux with Ubuntu's command line Python interpreter.

## Prerequisites
You can install the tools you'll need for this tutorial with one click by using the [Machine Learning Linux for Windows setup script](http://boxstarter.org/package/url?https://raw.githubusercontent.com/Microsoft/Dev-Advocacy-Samples/master/dev_setup.ps1) based on the [Windows Dev Box Setup Scripts](https://github.com/Microsoft/windows-dev-box-setup-scripts) project. 

Alternatively, follow the steps below to install prerequisites.

1. [Enable the Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install-win10). You'll be prommpted to restart your machine. Go ahead with that, and proceed to step 2.
2. Install "Ubuntu" from the Microsoft Store. Initialize WSL by typing:

        $ sudo apt-get update

3. [Install Visual Studio Code for Windows](https://code.visualstudio.com/Download).
4. Install Python and pip.
    - In your Ubuntu terminal type:
    
            $ sudo apt install python3

    - Verify you have python3 instaled by typing:

            $ python3 --version
    
    - Install pip (a Python package manager) by typing:

            $ sudo apt install python-pip
    
5. Install scikit-learn and its dependencies.
    - Install NumPy by typing:

            $ sudo apt-get install python-numpy
    
    - Install SciPy by typing:

            $ sudo apt-get install python-scipy

    - Install pandas (a visualization tool) by typing:

            $ sudo pip install pandas

## Tutorial
### Create a User
Create a user called 'ubuntu' that you will use throughout this tutorial. In you Ubuntu 18.04 terminal type the following:

        $ sudo adduser ubuntu
        # Add 'ubuntu' to the sudo user group
        $ sudo adduser ubuntu sudo
        $ su - ubuntu

### Download and Navigate to the scikit-learn datasets
First, you'll want to begin working with the scikit-learn sample data sets. Install scikit-learn by typing the following into your Ubuntu 18.04 terminal:
        
        $ sudo pip install scikit-learn

To navigate your dataset in WSL you'll need to be in the proper directory. You can do this with something similar to the following:

        $ cd /home

        $ cd ubuntu

        $ cd .local/lib/python2.7/site-packages/sklearn/datasets/data

<Ubuntu username> will be the username that you set up when you initially installed Ubuntu.

### Working with the Python interpreter 

Now, within your data libraries you'll see many options such as boston house prices, iris, and digits.

You can start a Python interpreter from the shell by doing the following:

        $ python

To know you're in the Python interpreter your shell will indicate a ">>>".

### Load the Iris Dataset

Given various measurements of an iris flower, we can determine the species. We are going to train our model with 150 samples. There are 4 meanturements by which we use to classify the flower. And, ultimately, there are 3 species types: setosa, versicolor, and virginica.

Let's start by loading the sample dataset. In your Ubuntu app, endusre you have the python interpreter loaded as explained above. Check for the ">>>" to ensure you're in the interpreter. If you aren't smiply type 'python' to do so.

Now in the interpreter do the following:

        from sklearn.datasets import load_iris
        from sklearn.model_selection import train_test_split

        iris_dataset = load_iris()
        X, y = iris_dataset.data, iris_dataset.target
        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=31)

The test_size of 0.25 means that 25% of the dataset is used for testing and the rest will be used for training.

The random_state is the degree by which the data is randomized.

### View the Data
We can view the iris data in a variety of ways ultimately building on numpy which scikit-learn is built on top of. We will use pandas for a cleaner visualization.

        import numpy as np
        import pandas as pd

        df = pd.DataFrame(
            data=np.c_[X,y], 
            columns=iris_dataset['feature_names'] + ['target'])
        df.sample(frac=0.1)

The printed table shows us sepal length, sepal width, petal lenght, and petal width. These are the 4 feature measurements. The last column is the target which is the classification of the species as 0, 1, or 2.

### Pre-Processing
Now that we have the raw dataset, we'll need to perform some pre-processing to be able to use the dataset to train our model. We're working with a farily simple dataset, so we will only need to perform standardization on it.

In the Python interpreter type the following:

        from sklearn import preprocessing
    
        scaler = preprocessing.StandardScaler().fit(X_train)
        X_train = scaler.transform(X_train)
        X_test = scaler.transform(X_test)

The scaler sets all the iris measurement data to have zero mean and unit variance. That standardization will ensure our machine learning algorithm works well.

### Training and Generalization
We are now going to train the model. Using scikit-learn we will train and test the model. We will train a Support Vector Machine (SVM) to classify the data using the accuracy_score.

        from sklearn import svm
        from sklearn.metrics import accuracy_score

        clf = svm.SVC(gamma=0.001, C=100.)
        clf.fit(X_train, y_train)
        
        y_pred_train = clf.predict(X_train)
        y_pred_test = clf.predict(X_test)
        
        acc_train = accuracy_score(y_train, y_pred_train) 
        acc_test = accuracy_score(y_test, y_pred_test)

In the above code snippet, we trained a SVM with a set of fixed hyper parameters gamma and C. Based on that, we will have about 97% accuracy for the training as test set. We can use scikit-learn to calculate the matrix for us using the following: 

        from sklearn.metrics import confusion_matrix

        confusion_matrix = confusion_matrix(y_test,y_pred_test)

And you'll see an array output as such:


    array([[11,  0,  0],
           [ 0, 15,  1],
           [ 0,  0, 11]])

What does this mean? Well, if we visualized this as a table you'd read it as:

| Species | Setosa | Versicolor | Virginica |
|---|---|---|---|
| Setosa | 11 | 0 | 0 |
| Versicolor | 0 | 15 | 1 |
| Virginica | 0 | 0 | 11 |

The rows (y-axis) indicate the correct iris flowers based on our test case. They columns (x-axis) indicate what our model predicted. So in the Setosa-Setosa cell tells us our prediction was corret. 

Based on our model, 1 versicolor was mistaken as a virginica iris.

And with that we are done! You have successfully used Python with the Windows Subsystem for Linux to build a machine learning classification model.

## Next Steps
You can learn more about using scikit-learn for machine learning on the [scikit-learn documentation page](http://scikit-learn.org/stable/index.html). There are many tutorials there.

Learn more about the Windows Subsystem for Linux on the [Windows Subsystem for Linux documentation page](https://docs.microsoft.com/en-us/windows/wsl/about) and the [Command Line Blog](https://blogs.msdn.microsoft.com/commandline/).
