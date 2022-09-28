function [test_error, test_err_folds] = kfold_cv(k, data_A, data_B, n_class_A, n_class_B, learn_rate)
    test_err_folds = zeros(1, k);
    for fold = 1:k
        if fold == 1
            test_data_A = data_A(1:fold*k,:);
            test_data_B = data_B(1:fold*k,:);
            train_data_A = data_A(fold*k + 1:length(data_A), :);
            train_data_B = data_B(fold*k + 1:length(data_B), :);
        elseif fold == k
            test_data_A = data_A((fold - 1)*k + 1:fold*k,:);
            test_data_B = data_B((fold - 1)*k + 1:fold*k,:);
            train_data_A = data_A(1:(fold - 1), :);
            train_data_B = data_B(1:(fold - 1), :);
        else
            test_data_A = data_A((fold - 1)*k + 1:fold*k,:);
            test_data_B = data_B((fold - 1)*k + 1:fold*k,:);
            train_data_A = [data_A(1:(fold - 1)*k, :); data_A(fold*k + 1:length(data_A), :)];
            train_data_B = [data_B(1:(fold - 1)*k, :); data_B(fold*k + 1:length(data_B), :)];
        end
        % train labels
        train_labels = zeros(1, length(train_data_A) + length(train_data_B));
        train_labels(length(train_data_A) + 1:length(train_labels)) = 1;
        % test labels
        test_labels  = zeros(1, length(test_data_A) + length(test_data_B));
        test_labels(length(test_data_A) + 1: length(test_labels)) = 1;

        train_data = [train_data_A; train_data_B];
        test_data = [test_data_A; test_data_B];

        [prototypes, proto_labels] = init(n_class_A, n_class_B, train_data_A, train_data_B);
        [prototypes, train_error] = LVQ(train_data, train_labels, prototypes, proto_labels, learn_rate);
        test_err_folds(fold) = train_err(test_data, test_labels, prototypes, proto_labels, length(prototypes), length(test_data)); 
    end
    test_error = mean(test_err_folds);
end