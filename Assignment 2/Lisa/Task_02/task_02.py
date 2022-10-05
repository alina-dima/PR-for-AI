import pandas as pd
import numpy as np
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score, f1_score

from sklearn.model_selection import train_test_split
from imblearn.over_sampling import SMOTE # install pip3 install imbalanced-learn. smote is designed to minimize overfitting due to upsampling, and training + testing on the same samples.

def read_data(data_path):
    df = pd.read_csv(data_path)
    df = df.drop(columns=["Amount", "Time"])
    labels = df["Class"]
    data = df.drop(columns=["Class"])

    sm = SMOTE(random_state=42, k_neighbors=5)

    data_res, labels_res = sm.fit_resample(data, labels)
    data_train, data_test, labels_train, labels_test = train_test_split(data_res, labels_res, test_size=0.2, random_state=4, stratify=labels_res)
    data_train_unlabeled, data_train_labeled, labels_train_unlabeled, labels_train_labeled = train_test_split(data_train, labels_train, test_size=0.3, random_state=4, stratify=labels_train)

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
    data_train_unlabeled, labels_train_unlabeled, data_train_labeled, labels_train_labeled, data_test, labels_test = read_data(data_path)
    results = run_model(SVC(kernel='linear', decision_function_shape='ovr'), data_train_labeled, labels_train_labeled, data_test, labels_test)
    print(results)

if __name__ == "__main__":
    main()