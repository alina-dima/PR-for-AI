import pandas as pd

from sklearn.svm import SVC
from sklearn.semi_supervised import LabelPropagation
from sklearn.metrics import accuracy_score, f1_score

from sklearn.metrics import accuracy_score, f1_score
from sklearn.model_selection import train_test_split
# TODO: Add imblearn to requirements
from imblearn.over_sampling import SMOTE  # SMOTE is designed to minimize overfitting due to upsampling,
                                          # and training + testing on the same samples.

def vis_data(data, labels):
    ## I copied this code from internet
    pca = PCA(n_components=3)
    pca.fit(data) 
    X_pca = pca.transform(data) 

    ex_variance=np.var(X_pca,axis=0)
    ex_variance_ratio = ex_variance/np.sum(ex_variance)
    ex_variance_ratio


    Xax = X_pca[:,0]
    Yax = X_pca[:,1]
    Zax = X_pca[:,2]

    cdict = {0:'red',1:'green'}
    labl = {0:'0',1:'1'}
    marker = {0:'*',1:'o'}
    alpha = {0:.3, 1:.5}

    fig = plt.figure(figsize=(7,5))
    ax = fig.add_subplot(111, projection='3d')

    fig.patch.set_facecolor('white')
    for l in np.unique(labels):
        ix=np.where(labels==l)
        ax.scatter(Xax[ix], Yax[ix], Zax[ix], c=cdict[l], s=40,
                label=labl[l], marker=marker[l], alpha=alpha[l])
    # for loop ends
    ax.set_xlabel("First Principal Component", fontsize=14)
    ax.set_ylabel("Second Principal Component", fontsize=14)
    ax.set_zlabel("Third Principal Component", fontsize=14)

    ax.legend()
    plt.show()

def read_data(data_path):
    df = pd.read_csv(data_path)
    df = df.drop(columns=["Amount", "Time"])
    labels = df["Class"]
    data = df.drop(columns=["Class"])

    sm = SMOTE(random_state=42, k_neighbors=5)

    data_res, labels_res = sm.fit_resample(data, labels)
    vis_data(data_res, labels_res)
    x_train, x_test, y_train, y_test = train_test_split(data_res, labels_res, test_size=0.2,
                                                                        random_state=4, stratify=labels_res)
    x_train_unlab, x_train_lab, y_train_unlab, y_train_lab = \
        train_test_split(x_train, y_train, test_size=0.3, random_state=4, stratify=y_train)

    return x_train_unlab, y_train_unlab, x_train_lab, y_train_lab, x_test, y_test

def run_model(model, train_data, train_labels, test_data, test_labels):
    model.fit(train_data, train_labels)
    yhat = model.predict(test_data)
    yhat = [int(i) for i in yhat]
    accuracy = accuracy_score(test_labels, yhat)
    f_1 = f1_score(test_labels, yhat)
    return [accuracy, f_1], model

class Model:
  def __init__(self, model, name):
    self.model = model
    self.name = name

def main():
    data_path = './creditcard.csv'
    x_train_unlab, y_train_unlab, x_train_lab, y_train_lab, x_test, y_test = read_data(data_path)

    # Selects the baseline classification and SSL models
    baseline = Model(SVC(kernel='linear', decision_function_shape='ovr'), "Linear SVC")
    ssl = Model(LabelPropagation('knn'), "KNN Label Propagation")

    # Runs classification model on lab train data and tests it
    results, _ = run_model(baseline.model, x_train_lab, y_train_lab, x_test, y_test)
    print("Running baseline model on labeled data...")
    print("Model: " + baseline.name + " \t Accuracy: %.4f \t F1: %.4f\n" % (results[0], results[1]))

    # Runs SSL model on all training data and tests it
    x_train = pd.concat([x_train_lab, x_train_unlab], axis=0)
    y_ssl = pd.concat([y_train_lab, y_train_unlab], axis=0)
    results, ssl_model = run_model(ssl.model, x_train, y_ssl, x_test, y_test)
    print("Running SSL model...")
    print("Model: " + ssl.name + " \t Accuracy: %.4f \t F1: %.4f\n" % (results[0], results[1]))

    # Runs baseline model on all training data using the labels obtained from SSL and tests it
    y_train_ssl = ssl_model.transduction_
    results, _ = run_model(baseline.model, x_train, y_train_ssl, x_test, y_test)
    print("Running baseline model with SSL labels on all data...")
    print("Model: " + baseline.name + " \t Accuracy: %.4f \t F1: %.4f" % (results[0], results[1]))
    


if __name__ == "__main__":
    main()