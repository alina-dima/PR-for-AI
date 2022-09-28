
mu1 = 5;
mu2 = 7;
var = 4;
x = [mu1 - 3*sqrt(var):0.1:mu2 + 3*sqrt(var)];
y1 = normpdf(x, mu1, sqrt(var));
y2 = normpdf(x, mu2, sqrt(var));
plot(x, y1);
hold on
plot(x, y2);
close

mu2 = [7, 9, 9.3, 11];
for mu2_idx = 1:length(mu2)
    [fa, h] = roc(mu1, mu2(mu2_idx), sqrt(var));
    plot(fa, h)
    hold on
    mu2(mu2_idx)
    discr = (abs(mu2 - mu1))/sqrt(var)

end

data = load('task_9.mat').('outcomes');

FP = 0;
TP = 0;
for row = 1:length(data)
    if data(row, 1) == 0 && data(row, 2) == 1
        FP = FP + 1; 
    elseif data(row, 1) == 1 && data(row, 2) == 1
        TP = TP + 1;
    end
end

fa_data = FP/sum(data(:,1) == 0);
h_data = TP/sum(data(:,1) == 1);

scatter(fa_data, h_data)
xlabel('x');
ylabel('Density');
legend('mu2 = 5', 'mu2 = 9', 'mu2 = 9.3', 'mu2 = 11', 'outcomes (fa, h)');

function [fa, h] = roc(mu1, mu2, sigma)
    min_lim = mu1 - 3*sigma;
    max_lim = mu2 + 3*sigma;
    x = [min_lim:0.1:max_lim];

    rand_nums = (max_lim-min_lim).*rand(100,1) + min_lim;
    x_star = sort([datasample(rand_nums, 50, 'replace', false)]');

    fa = zeros(1, length(x_star));
    h = zeros(1, length(x_star));
    for crit_idx = 1:length(x_star)
        x_star(crit_idx);
        ans_fa = normcdf([x_star(crit_idx) max(x)], mu1, sigma);
        fa(crit_idx) = ans_fa(2) - ans_fa(1);
    
        ans_h = normcdf([x_star(crit_idx) max(x)], mu2,sigma);
        h(crit_idx) = ans_h(2) - ans_h(1);
    end
end
