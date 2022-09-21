
n_exp = 1000;

D = zeros(1, n_exp);
S = zeros(1, n_exp);

for n = 1:n_exp
    [person, file] = random_person();

    rows = [person(random_20(),:); person(random_20(),:)];
    hd = pdist(rows, 'hamming');
    S(n) = hd;

    [person1, file1] = random_person();
    while true
        [person2, file2] = random_person();
        if strcmp(file1, file2) == 0
            break
        end
    end
    rows = [person1(random_20(),:); person2(random_20(),:)];
    hd = pdist(rows, 'hamming');
    D(n) = hd;
end


overlap = 0;
for i = intersect(S,D)
    len1 = length(find(S==i));
    len2 = length(find(D==i));
    overlap = overlap + min(len1, len2);
end
overlap = (overlap / n_exp) * 100;
fprintf("Overlap percent: %f\n", overlap);


d_mu = mean(D);
s_mu = mean(S);
d_sigma = var(D);
s_sigma = var(S);

fprintf("Mean of S: %f \nVar of S: %f \nMean of D: %f \nVar of D: %f \n", s_mu, s_sigma, d_mu, d_sigma);

plot_dist(D, d_mu, d_sigma);
plot_dist(S, s_mu, s_sigma);



x = linspace(-0.2,1,1000);
y = normcdf(x, d_mu, sqrt(d_sigma));
far = 0.0005;

plot(x, y)

for i = 1:1000
    if y(i) >= far
        decision = x(i);
        break;
    end
end

fprintf("Decision criterion: %f\n", decision);

y = normcdf(x, s_mu, sqrt(s_sigma));
for i = 1:1000
    if x(i) >= decision
        frr = 1-y(i);
        break;
    end
end

fprintf("False rejection rate: %f\n", frr);


function plot_dist(values,mu,sigma)
    bin_width = 0.01;
    h = histogram(values, "BinWidth", bin_width);
    hold on;
    
    x = linspace(-0.2,1,1000);    
    y = normpdf(x,mu, sqrt(sigma));

    y_scale = max(h.Values) / max(y);

    plot(x, y * y_scale);
    hold on;
end


function rand_20 = random_20()
    rand_20 = round((rand * 19) + 1);
end


function [mat, file] = random_person()
    rand_num = round((rand * 19) + 1);
    file = sprintf("person%02d.mat", rand_num);
    mat = load(file).iriscode;
end
