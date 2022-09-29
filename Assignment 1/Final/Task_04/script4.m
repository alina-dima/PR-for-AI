
% Task 4
% Alina, Lisa, Ömer and Nikolai

mu = [3 4];
sigma = [1 0; 0 2];

x = -10:0.1:10;
y = -10:0.1:10;

[X, Y] = meshgrid(x, y);
Z = mvnpdf([X(:) Y(:)], mu, sigma);
Z = reshape(Z, length(y), length(x));

mesh(X, Y, Z)
xlabel('x')
ylabel('y')
zlabel('z')
colorbar

points = [10 10; 0 0; 3 4; 6 8];

for i = 1:length(points)
    fprintf("\nPoint ")
    disp(points(i,:))
    fprintf("Mahal Distance")
    disp(mahal_dis(points(i,:)', mu', sigma));
end

function mahalanobis = mahal_dis(x, y, cov_mat)
    mahalanobis = sqrt((x - y)' * inv(cov_mat) * (x - y));
end
