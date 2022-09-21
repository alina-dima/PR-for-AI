matrix = [4 5 6; 6 3 9; 8 7 3; 7 4 8; 4 6 5];
mu = mean(matrix);
points = [5 5 6; 3 5 7; 4 6.5 1];
y = mvnpdf(points, mu, cov(matrix));
y