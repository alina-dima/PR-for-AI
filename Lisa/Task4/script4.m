x = -10:.1:10;
[X1, X2] = meshgrid(x, x);
X = [X1(:) X2(:)];
sigma = [1 0; 0 2];
mean = [3 4];

gauss = mvnpdf(X, mean, sigma);
gauss = reshape(gauss,length(x),length(x));

mesh(-10:.1:10, -10:.1:10, gauss)

points = [10 10; 0 0; 3 4; 6 8];

for i = 1:length(points)
   mahalanobis = mahal_dis(points(i,:)', mean', sigma);
end

function mahalanobis = mahal_dis(x, y, cov_mat)
    mahalanobis = sqrt((x - y)' * inv(cov_mat) * (x - y));
end