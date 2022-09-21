% Task 1 - Pairwise correlation coefficients
c1 = lab1_1(:,1);
c2 = lab1_1(:,2);
c3 = lab1_1(:,3);
% 1a)

%covariance12 = covariance(c1, c3);
%covariance12

corr_mat = [0 0 0; 0 0 0; 0 0 0];

for r = 1:3
    for c = 1:3
        corr_mat(r, c) = coeff(lab1_1(:,r), lab1_1(:,c));
    end
end
corr_mat;

fig1 = scatter(c1,c3,'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0 .7 .7],...
              'LineWidth',1.5);
axis([0 max(c1) 0 max(c3)]);
xlabel('Height (cm)'); 
ylabel('Body weight (kg)');

saveas(fig1, '1-2a.jpg');

fig2 = scatter(c2,c3,'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0 .7 .7],...
              'LineWidth',1.5);
axis([0 max(c2) 0 max(c3)]);
xlabel('Age (years)'); 
ylabel('Body weight (kg)'); 
saveas(fig2, '1-2b.jpg');

function corr_coeff = coeff(f1, f2)
    covar = sum((f1 - mean(f1)) .* (f2 - mean(f2)))/(length(f1) - 1);
    corr_coeff = covar/sqrt(var(f1) * var(f2));
end
