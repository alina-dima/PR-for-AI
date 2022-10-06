import pandas as pd
import numpy as np

from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.naive_bayes import GaussianNB
from sklearn.semi_supervised import LabelPropagation, LabelSpreading
from sklearn.metrics import accuracy_score, f1_score

from sklearn.metrics import accuracy_score, f1_score
from sklearn.model_selection import train_test_split
# TODO: Add imblearn to requirements
from imblearn.over_sampling import SMOTE  # smote is designed to minimize overfitting due to upsampling,
                                          # and training + testing on the same samples.

def read_data(data_path):
    df = pd.read_csv(data_path)
    df = df.drop(columns=["Amount", "Time"])
    labels = df["Class"]
    data = df.drop(columns=["Class"])

    sm = SMOTE(random_state=42, k_neighbors=5)

    data_res, labels_res = sm.fit_resample(data, labels)
    data_train, data_test, labels_train, labels_test = train_test_split(data_res, labels_res, test_size=0.2,
                                                                        random_state=4, stratify=labels_res)
    data_train_unlabeled, data_train_labeled, labels_train_unlabeled, labels_train_labeled = \
        train_test_split(data_train, labels_train, test_size=0.3, random_state=4, stratify=labels_train)

    return data_train_unlabeled, labels_train_unlabeled, data_train_labeled, labels_train_labeled, data_test, labels_test

def run_model(model, train_data, train_labels, test_data, test_labels):
    model.fit(train_data, train_labels)
    pred = model.predict(test_data)
    print(pred)
    pred = [int(i) for i in pred]
    accuracy = accuracy_score(test_labels, pred)
    f_1 = f1_score(test_labels, pred)
    return [accuracy, f_1]


def main():
    data_path = './creditcard.csv'
    data_train_unlabeled, labels_train_unlabeled, data_train_labeled, labels_train_labeled, \
        data_test, labels_test = read_data(data_path)
    models = [SVC(kernel='linear', decision_function_shape='ovr')]
            #   SVC(kernel='rbf', decision_function_shape='ovr'), 
            #   SVC(kernel='sigmoid', decision_function_shape='ovr'), 
            #   GaussianNB(), 
            #   LogisticRegression()]
    model_names = ["Linear SVM", "Rbf SVM", "Sigmoid SVM", "Naive Bayes", "Logisitic Reg"]

    idx = 0
    for model in models:
        results = run_model(model, data_train_labeled, labels_train_labeled, data_test, labels_test)
        print("Model: " + model_names[idx] + " \t Accuracy: %.4f \t F1: %.4f" % (results[0], results[1]))
        idx += 1

    ssl_models = [LabelPropagation('knn')]
                #   LabelPropagation('rbf'),
                #   LabelSpreading('knn'),
                #   LabelSpreading('rbf')]
    ssl_model_names = ["KNN Label Propagation", "RBF Label Propagation", "KNN Label Spreading", "RBF Label Spreading"]
    ssl_train_data = pd.concat([data_train_labeled, data_train_unlabeled], axis=0)
    ssl_labels = pd.concat([labels_train_labeled, labels_train_unlabeled], axis=0)

    idx = 0
    for model in ssl_models:
        results = run_model(model, ssl_train_data, ssl_labels, data_test, labels_test)
        print("Model: " + ssl_model_names[idx] + " \t Accuracy: %.4f \t F1: %.4f" % (results[0], results[1]))
        idx += 1


if __name__ == "__main__":
    main()