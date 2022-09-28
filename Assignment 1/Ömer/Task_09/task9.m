load("task_9.mat")
[fa, hitrate] = get_roc(7);
plot(fa, hitrate)
hold on;
[fa, hitrate] = get_roc(9);
plot(fa, hitrate)
hold on;
[fa, hitrate] = get_roc(11);
plot(fa, hitrate)
hold on;

% d=2 for mu2=9 and d=3 for mu2=11
hits = 0;
fa = 0;
for j = 1:200
    if outcomes(j, 1) == outcomes(j, 2)
        if outcomes(j, 1) == 1
            hits = hits + 1;
        end
    elseif outcomes(j, 2) == 1
        fa = fa + 1;
    end
end

hitrate = hits / length(outcomes);
farate = fa / length(outcomes);
plot(farate, hitrate, 'r*')
% d=1.5 with mu2=8

function [fa, hitrate] = get_roc(mu2)
    x_star = linspace(-1, 13, 100);
    dist1 = normcdf(x_star, 5, 2);
    dist2 = normcdf(x_star, mu2, 2);
    fa = 1 - dist1;
    hitrate = 1 - dist2;
end