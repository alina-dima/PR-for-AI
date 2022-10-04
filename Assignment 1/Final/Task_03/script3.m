
% Task 3
% Alina, Lisa, Ömer and Nikolai

feat_vectors = [4 5 6; 6 3 9; 8 7 3; 7 4 8; 4 6 5];

means = zeros(1,3);
for i = 1:size(means,2)
    means(i) = sum(feat_vectors(:,i)) / length(feat_vectors(:,i));
end
fprintf("Mean:");
disp(means);

cov_matrix = zeros(3,3);
for i = 1:size(cov_matrix,1)
    for j = i:size(cov_matrix,2)
        cov_matrix(i,j) = get_cov(feat_vectors(:,i),feat_vectors(:,j),...
                                  means(i),means(j));
        cov_matrix(j,i) = get_cov(feat_vectors(:,j),feat_vectors(:,i),...
                                  means(j),means(i));
    end
end
fprintf("Covariance matrix:\n");
disp(cov_matrix);

eval_points = [5 5 6; 3 5 7; 4 6.5 1];
y = mvnpdf(eval_points, means, cov_matrix);
fprintf("Probabilities:\n");
disp(y);

function cov = get_cov(X,Y,mu_X,mu_Y)
    cov = sum((X - mu_X).*(Y - mu_Y)) / (length(X) - 1);
end