
% Task 1
% Alina, Lisa, Ömer and Nikolai

data = load('task_1.mat').lab1_1;

%1
corr_matrix = zeros(3,3);

for i = 1:3
    for j = 1:3
        corr_matrix(i,j) = corr_coef(data(:,i), data(:,j));
    end
end

fprintf("Pairwaise correlation coefficients:\n");
disp(corr_matrix);

%2
feats = ["Height (cm)" "Age (years)" "Body weight (kg)"];

figure % largest correlation
[i, j, largest_val] = max_val(corr_matrix, -1);
scatter(data(:,i), data(:,j), 100, '.')
xlabel(feats(i))
ylabel(feats(j))

figure % second correlation
[i, j, mx] = max_val(corr_matrix, largest_val);
scatter(data(:,i), data(:,j), 100, '.')
xlabel(feats(i))
ylabel(feats(j))

function corr = corr_coef(X,Y)
    % calculate coorelation by covariance / product of variances 
    cov_var = sum((X - mean(X)).*(Y - mean(Y))) / (length(X) - 1);
    corr = cov_var / (std(X) * std(Y));
end

function [i, j, mx] = max_val(m, exclude)
    % find largest value in m, don't include exclude
    mx = -1;
    i = -1;
    j = -1;
    for l = 1:length(m)
        for k = 1:length(m)
            val = abs(m(l,k));
            if l ~= k && mx < val && m(l,k) ~= exclude
                mx = val;
                i = l;
                j = k;
            end
        end
    end
end
