feat_vectors = [4 5 6; 6 3 9; 8 7 3; 7 4 8; 4 6 5];
means = zeros(1,3);

for i = 1:3
    means(i) = sum(feat_vectors(:,i)) / length(feat_vectors(:,i));
end

cov_matrix = zeros(3,3);
for i = 1:3
    for j = i:3
        cov_matrix(i,j) = get_cov(feat_vectors(:,i), feat_vectors(:,j));
        cov_matrix(j,i) = get_cov(feat_vectors(:,j), feat_vectors(:,i));
    end
end
cov_matrix

eval_points = [5 5 6; 3 5 7; 4 6.5 1];
y = mvnpdf(eval_points, means, cov_matrix);
y

function cov = get_cov(X,Y)
    mu_X = mean(X);
    mu_Y = mean(Y);
    sum = 0;
    for i = 1:length(X)
        sum = sum + (X(i)-mu_X)*(Y(i)-mu_Y);
    end
    cov = sum / (length(X) - 1);
end