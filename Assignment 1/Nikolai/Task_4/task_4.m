
mu = [3 4];
cov = [1 0; 0 2];

n_points = 1000;
min_val = -10;
max_val = 10;

X = linspace(min_val,max_val,n_points);
Y = linspace(min_val,max_val,n_points);

[X, Y] = meshgrid(X,Y);
Z = reshape(mvnpdf([X(:) Y(:)],mu,cov),n_points,n_points);

p = mesh(X,Y,Z);



saveas(p,'mesh_plot.eps')

points = [10 10;
          0 0;
          3 4;
          6 8];

for i = 1:length(points)
    x = points(i,:)
    mahalanobis(x, mu, cov)
end


function dis = mahalanobis(x, u, s)
    % using definition from: https://en.wikipedia.org/wiki/Mahalanobis_distance
    dis = sqrt((((x - u).').*s^(-1)).*(x - u));
end
