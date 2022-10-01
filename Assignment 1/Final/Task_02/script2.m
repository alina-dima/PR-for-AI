
% Task 2
% Alina, Lisa, Ömer and Nikolai

% 1
seed = RandStream('mlfg6331_64'); % ensure same results

filenames = strings([1,20]);
for i = 1:length(filenames)
    filenames(i) = sprintf('person%02d.mat',i);
end

reps = 1000;

% a
S = zeros(1, reps);
for rep = 1:reps
    codes = load(datasample(seed, filenames, 1)).iriscode;
    y = datasample(seed, 1:20, 2);
    rows = codes(y,:);
    S(rep) = pdist(rows, 'hamming');
end

% b
D = zeros(1, reps);
for rep = 1:reps
    files = datasample(seed, filenames, 2, 'Replace', false); % two different row

    codes_1 = load(files(1)).iriscode;
    r1 = codes_1(datasample(seed, 1:20, 1), :);

    codes_2 = load(files(2)).iriscode;
    r2 = codes_2(datasample(seed, 1:20, 1), :);

    D(rep) = pdist([r1;r2], 'hamming');
end


% 2
figure
% calculate bin-wdith using Freedman-Diaconis rule
width_S = 2 * iqr(S) / (length(S)^(1/3));
width_D = 2 * iqr(D) / (length(D)^(1/3));
width = (width_S + width_D) / 2;
% calculate number of bins
nbins_S = round((max(S) - min(S)) / width);
nbins_D = round((max(D) - min(D)) / width);

h_S = histogram(S,nbins_S,...
    'BinWidth',width,...
    'FaceAlpha',0.5,...
    'EdgeAlpha',0.5,...
    'DisplayName','Set S');
hold on

h_D = histogram(D,nbins_D,...
    'BinWidth',width,...
    'FaceAlpha',0.5,...
    'EdgeAlpha',0.5,...
    'DisplayName','Set D');

xlabel('Normalized Hamming distance')
ylabel('Number of repetitions')
legend()
hold on

% how much do the histograms overlap?
overlap = 0;
inter = intersect(S,D);
for i = 1:length(inter)
    elem = inter(i);
    len1 = length(find(S==elem)); % check occurrence
    len2 = length(find(D==elem));
    overlap = overlap + min(len1, len2);
end
fprintf("Overlap percentage: %f\n", (overlap / reps) * 100);
fprintf("Overlap occurs at the following distance values:");
disp(inter);


% 3
mu_S = mean(S);
var_S = var(S);
sigma_S = sqrt(var_S);
fprintf('Mean and variance of set S: %f %f\n', mu_S, var_S);

mu_D = mean(D);
var_D = var(D);
sigma_D = sqrt(var_D);
fprintf('Mean and variance of set D: %f %f\n', mu_D, var_D);


%4
x_S = linspace(min(S),max(S),100);
y_S_norm = normpdf(x_S,mu_S,sigma_S);
[maxcount_S,] = max(h_S.Values);
scaling_S = maxcount_S / max(y_S_norm);

x_D = linspace(min(D),max(D),100);
y_D_norm = normpdf(x_D,mu_D,sigma_D);
[maxcount_D,] = max(h_D.Values);
scaling_D = maxcount_D / max(y_D_norm);

plot_with_dist = true; % turn off to get graph for 3

if plot_with_dist
    plot(x_S, scaling_S*y_S_norm,...
        'LineWidth', 2,...
        'Color', 'b',...
        'DisplayName','Set S Gaussian')

    plot(x_D, scaling_D*y_D_norm,...
        'LineWidth', 2,...
        'Color', 'r',...
        'DisplayName','Set D Gaussian')
end


% 5

% a
step = 0.001;
decision_crit = 0;
for x = min(D):step:max(D)
    if normcdf(x, mu_D, sigma_D) >= 0.0005
        decision_crit = x;
        break
    end
end
fprintf("\nDecision criterion: %f\n", decision_crit);

% b
frr = 1 - normcdf(decision_crit, mu_S, sigma_S);
fprintf("False rejection rate %f\n\n", frr);


% 6
testcodes = load("testperson.mat").iriscode;
test = testcodes(:,:);

HD_test = zeros(1, 20);
mask = test == 2;

for i = 1:20
    codes = load(filenames(i)).iriscode;
    HD = 0;
    for j = 1:20
        code = codes(j,:);
        code(mask) = 2;
        HD = HD + pdist([test; code], 'hamming');
    end
    HD_test(i) = HD / 20;
    fprintf("Person %d min dis %f\n", i, HD_test(i));
end

[Min, idx] = min(HD_test);
fprintf("Min dist is person %d\n", idx);

