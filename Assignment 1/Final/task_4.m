mu = [3 4];
Sigma = [1 0; 0 2];

x = -10:.1:10;
y = -10:.1:10;
[X,Y] = meshgrid(x, y);
XY = [X(:) Y(:)];
Z = mvnpdf(XY, mu, Sigma);
Z = reshape(Z, length(y), length(x));

mesh(X, Y, Z)
xlabel('x')
ylabel('y')
zlabel('z')
colorbar

points = [10 10; 0 0; 3 4; 6 8];

for i = 1:length(points)
   mahalanobis = mahal_dis(points(i,:)', mean', sigma);
end

function mahalanobis = mahal_dis(x, y, cov_mat)
    mahalanobis = sqrt((x - y)' * inv(cov_mat) * (x - y));
end
