
% Task 11
% Alina, Lisa, Ömer and Nikolai

clear all;
load task_11.mat;

data = lab3_2;
nr_of_classes = 4;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

error_rates = zeros(1, length(1:2:25));
idx = 0;
for K = 1:2:25
    idx = idx + 1;
    correct = 0;
    wrong = 0;
    for r_idx = 1:length(data)
        copy_data = data;
        copy_class_labels = class_labels;
    
        copy_data(r_idx, :) = [];
        copy_class_labels(r_idx) = [];
        
        test_point = data(r_idx, :);
        test_label = class_labels(r_idx);
    
        class = KNN(test_point, K, copy_data, copy_class_labels);
        if class == test_label 
            correct = correct + 1; 
        else 
            wrong = wrong + 1; 
        end
    end
    
    error_rates(idx) = wrong / length(copy_data);
end
disp(error_rates);

