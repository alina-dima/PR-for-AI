
% Task 3
% Alina, Lisa, Ömer and Nikolai

feat_vectors = [4 5 6; 6 3 9; 8 7 3; 7 4 8; 4 6 5];

means = mean(feat_vectors);
cov_matrix = zeros(3,3);

for i = 1:length(cov_matrix)
    for j = 1:length(cov_matrix)
        cov_matrix(i,j) = get_cov(feat_vectors(:,i), feat_vectors(:,j));
    end
end

fprintf("Mean:");
disp(means);
fprintf("Covariance matrix:\n");
disp(cov_matrix);

eval_points = [5 5 6; 3 5 7; 4 6.5 1];
y = mvnpdf(eval_points, means, cov_matrix);
fprintf("Probabilities:\n");
disp(y);

function cov = get_cov(X,Y)
    cov = sum((X - mean(X)).*(Y - mean(Y))) / (length(X) - 1);
end
