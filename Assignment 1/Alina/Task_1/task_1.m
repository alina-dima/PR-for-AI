data = load('task_1.mat').('lab1_1');
corr_matrix = zeros(3,3);
for i = 1:3
    for j = i:3
        corr_matrix(i,j) = corr_coef(data(:,i), data(:,j));
        corr_matrix(j,i) = corr_matrix(i,j);
    end
end

% Automatize the scatter plots?
figure(1)
scatter(data(:,1), data(:,3), 100, '.')
xlabel('Height (cm)')
ylabel('Body weight (kg)')

figure(2)
scatter(data(:,2), data(:,3), 100, '.')
xlabel('Age (years)')
ylabel('Body weight (kg)')

function corr = corr_coef(X,Y)
    mu_X = mean(X);
    mu_Y = mean(Y);
    sum = 0;
    for i = 1:length(X)
        sum = sum + (X(i)-mu_X)*(Y(i)-mu_Y);
    end
    cov = sum / (length(X) - 1);
    corr = cov / (std(X)*std(Y));
end