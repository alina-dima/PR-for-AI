
% Task 9
% Alina, Lisa, Ömer and Nikolai

data = load('task_9.mat').outcomes;
mu1 = 5;
var = 4;

% 1
mu2 = [7, 9, 11];
ds = zeros(1, length(mu2));
for i = 1:length(mu2)
    [fa, h, d] = roc(mu1, mu2(i), sqrt(var));
    ds(i) = d;
    plot(fa, h,'LineWidth',2);
    hold on
end

% 2
part2 = true;
if part2
    FP = 0;
    TP = 0;
    for row = 1:length(data)
        if data(row, 1) == 0 && data(row, 2) == 1
            FP = FP + 1; 
        elseif data(row, 1) == 1 && data(row, 2) == 1
            TP = TP + 1;
        end
    end
    fa_point = FP / sum(data(:,1) == 0); % false positive rate
    h_point = TP / sum(data(:,1) == 1); % true positive rate
    
    % brute force
    fprintf("Starting brute force (may take a while)...\n");
    mu = 9;
    inc = 0.001;
    min_dis = flintmax;
    min_mu = mu1;
    while true
        mu = mu + inc;
        [fa, h] = roc(mu1, mu, sqrt(var));
        if mu >= 9.5
            break;
        end
        dis = flintmax;
        for i = 1:length(fa)
            dis = min(dis, pdist2([fa_point h_point], [fa(i) h(i)]));
        end
        if dis < min_dis
            min_dis = dis;
            min_mu = mu;
        end
    end
    
    [fa, h, d] = roc(mu1, min_mu, sqrt(var));
    plot(fa, h,'LineWidth',2)
    hold on
    scatter(fa_point, h_point, 80, 'filled')
    mu2 = [mu2 min_mu];
    ds = [ds d];
end

xlabel("False Alarm");
ylabel("Hit");
legend('mu_2 = ' + string(mu2) + ' (d = ' + string(ds) + ')');

function [fa, h, d] = roc(mu1, mu2, sigma)
    min_lim = mu1 - 3 * sigma;
    max_lim = mu2 + 3 * sigma;
    n = 1000;

    x_star = sort(min_lim + rand(1, n) * (max_lim - min_lim));
    fa = 1 - normcdf(x_star, mu1, sigma);
    h = 1 - normcdf(x_star, mu2, sigma);

    d = (mu2 - mu1) / sigma;
end
