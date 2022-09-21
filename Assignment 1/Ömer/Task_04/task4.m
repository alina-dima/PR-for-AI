mu = [3 4];
cov = [1 0; 0 2];
points = [10 10; 0 0; 3 4; 6 8];
x = [linspace(-10, 10, 2); linspace(-10, 10, 2)];

y = mvnpdf(x, mu, cov);
y
mesh(y);