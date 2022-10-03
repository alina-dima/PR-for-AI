% 1
data_A = load('data_lvq_A.mat').('matA');
data_B = load('data_lvq_B.mat').('matB');

figure()
scatter(data_A(:,1),data_A(:,2),20,'filled','DisplayName','Data A')
hold on
scatter(data_B(:,1),data_B(:,2),20,'filled','DisplayName','Data B')
xlabel('1st Column Feature')
ylabel('2nd Column Feature')
legend

% 2
for no_A = 1:2
    for no_B = 1:2
        [E, prot_all] = LVQ(data_A,data_B,no_A,no_B);
        figure()
        plot(E,'LineWidth',1)
        title(['E over epoch for ' num2str(no_A) ' A prototypes and '...
            num2str(no_B) ' B prototypes']) 
        xlabel('Epoch')
        ylabel('Misclassification error')
        
        figure()
        scatter(data_A(:,1),data_A(:,2),'DisplayName','Class A',...
                'LineWidth',1.5)
        hold on
        scatter(data_B(:,1), data_B(:,2),'DisplayName','Class B',...
                'LineWidth',1.5)
        hold on
        scatter(prot_all(1:no_A,1),prot_all(1:no_A,2),70,'filled',...
                'DisplayName','A prototypes')
        hold on
        scatter(prot_all(no_A+1:end,1),prot_all(no_A+1:end,2),70,...
                'filled','DisplayName','B prototypes')
        xlabel('Feature 1')
        ylabel('Feature 2')
        hold on
        legend
        
        if no_A == 2 && no_B == 1
            cross_validation(data_A,data_B,no_A,no_B)
        end
    end
end