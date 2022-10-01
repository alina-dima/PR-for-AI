data_A = load('data_lvq_A.mat').('matA');
data_B = load('data_lvq_B.mat').('matB');

data_A_f1 = data_A(:,1);
data_A_f2 = data_A(:,2);
data_B_f1 = data_B(:,1);
data_B_f2 = data_B(:,2);

scatter(data_A_f1,data_A_f2);
hold on
scatter(data_B_f1,data_B_f2);

xlabel('Feature 1'); 
ylabel('Feature 2');
legend('A', 'B')


%%% LVQ
learn_rate = 0.01;
data = [data_A; data_B];

% Labels for the data (0 = A, 1 = B)
data_labels = zeros(1, length(data));
data_labels(length(data_A) + 1: length(data_labels)) = 1;

% prototype initialisation
n_class_A = 2;
n_class_B = 1;
[init_protos, label_protos] = init(n_class_A, n_class_B, data_A, data_B);
% LVQ
[prototypes, train_error] = LVQ(data, data_labels, init_protos, label_protos, learn_rate);

% plot clusters over data
scatter(prototypes(:,1), prototypes(:,2), 'filled')
legend('A', 'B', 'Prototypes')

% plot train error
% close
% plot(train_error)
% xlabel('Number of eopchs'); 
% ylabel('Training error');

% kfold cv 

[test_err, test_err_folds] = kfold_cv(10, data_A, data_B, n_class_A, n_class_B, learn_rate);



