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

P = [10 10; 0 0; 3 4; 6 8].';
d_M = zeros(1, size(P,2));
for p_idx=1:size(P,2)
    d_M(p_idx) = ((P(:,p_idx) - mu.').' *...
        (Sigma ^ (-1)) *...
        (P(:,p_idx) - mu.')) ^ (1/2);
end
d_M
