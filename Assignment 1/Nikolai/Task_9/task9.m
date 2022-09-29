
std = 4;
mu1 = 5;
mu2s = [7 9 11];
labels = 1:length(mu2s);

for i = 1:length(mu2s)
    [d, probs] = roc(mu1, mu2s(i), std);
    labels(i) = d;
    plot(probs(:,1), probs(:,2),'LineWidth',2)
    hold on
end

% %2
outcomes = load("task_9.mat").outcomes;
n = length(outcomes);
h = 0;
fa = 0;

for i = 1:n
    if outcomes(i,2) == 1
        if outcomes(i,1) == 1
            h = h + 1;
        else
            fa = fa + 1;
        end
    end
end

fa = fa / n; %
h = h / n;

mu_test = 5;
inc = 0.1;
min_dis = flintmax;
min_d = intmax;
min_probs = [];

while true
    mu_test = mu_test + inc;
    [d, probs] = roc(mu1, mu_test, std);
    if d >= max(labels)
        break;
    end
    dis = flintmax;
    for i = 1:length(probs)
        dis = min(dis, pdist2([fa h], probs(i,:)));
    end
    if dis < min_dis
        min_dis = dis;
        min_d = d;
        min_probs = probs;
    end
end

plot(min_probs(:,1), min_probs(:,2),'LineWidth',2);
hold on

scatter(fa, h, 80, 'filled');

hold off
xlabel("false alarm")
ylabel("hit")
legend("d=" + string([labels min_d]))


function [discrim, probs] = roc(mu1, mu2, std)
    sigma = sqrt(std);
    n_points = 1000;
    discrim = abs(mu2 - mu1) / sigma;
    
    max_val = mu1 - 3 * sigma;
    min_val = mu2 + 3 * sigma;
    points = min_val + rand(1, n_points) * (max_val - min_val);
    
    probs = zeros(n_points, 2);
    probs(:,1) = 1 - normcdf(points, mu1, sigma);
    probs(:,2) = 1 - normcdf(points, mu2, sigma);
    probs = sort(probs);
end
