% Task 2 - Hamming distance
load("Assignment1-files/Task_2/person01.mat");
path = "Assignment1-files/Task_2/";
seed = RandStream('mlfg6331_64');

%1 
filenames = [];
for i = 1:20
    h = sprintf('person%02d.mat',i);
    filenames = [filenames; char(h)];
end

% a)
reps = 1000;
HD_S = zeros(1, reps);

for rep = 1:reps
    file = datasample(seed, filenames, 1);
    load(path + file);
    y = datasample(seed, 1:20,2,'Replace',false);
    r1 = iriscode(y(1), :);
    r2 = iriscode(y(2), :);
    HD_S(1, rep) = pdist([r1;r2], 'hamming');
end

% b)
HD_D = zeros(1, reps);

for rep = 1:reps
    files = datasample(seed, filenames, 2, 'Replace', false);
    load(path + files(1, :));
    r1 = iriscode(datasample(seed, 1:20, 1), :);
    load(path + files(2, :));
    r2 = iriscode(datasample(seed, 1:20, 1), :);
    HD_D(1, rep) = pdist([r1;r2], 'hamming');
end


mevar_HD_S = [mean(HD_S), var(HD_S)];
mevar_HD_D = [mean(HD_D), var(HD_D)];

w = 0.03;
h1 = histogram(HD_S, 'BinWidth', w);
hold on
h2 = histogram(HD_D, 'BinWidth', w);
xlabel('Normalised Hamming distances')
hold on
xg1 = [min(HD_S):w:max(HD_S) + 0.2];
g1 = normpdf(xg1, mevar_HD_S(1), sqrt(mevar_HD_S(2))) * w * reps;
plot(xg1, g1, 'blue', 'LineWidth', 2);
hold on
xg2 = [min(HD_S):w:max(HD_D) + 0.2];
g2 = normpdf(xg2, mevar_HD_D(1), sqrt(mevar_HD_D(2))) * w * reps;
plot(xg2, g2, 'red', 'LineWidth', 2);
legend('HD S', 'HD D', 'Gaussian HD S', 'Gaussian HD D');

for x = [min(HD_D) - 0.1:w:max(HD_D) + 0.05]
    normcdf(x, mean(HD_D), std(HD_D))
    if normcdf(x, mean(HD_D), std(HD_D)) >=  0.0005
        x
        break
    end
end

lims = [x (max(HD_S) + 0.2)];
ans = normcdf(lims, mean(HD_S), std(HD_S));
rej = ans(2) - ans(1);
rej


% 6
load(path + "testperson.mat");
test = iriscode(:,:);

HD_test = zeros(1, 20);
mask = test == 2;

for i = 1:20
    load(path + filenames(i,:));
    HD = 0;
    for j = 1:20
        code = iriscode(j,:);
        code(mask) = [2];
        HD = HD + pdist([test;code], 'hamming');
    end
    HD_test(i) = HD/20;
end

[Min, idx] = min(HD_test);








