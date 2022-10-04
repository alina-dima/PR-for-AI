seed = RandStream('mlfg6331_64');
% 1
filenames = [];
for i = 1:20
    h = sprintf('person%02d.mat',i);
    filenames = [filenames; char(h)];
end

reps = 1000;
S = zeros(1, reps);

for rep = 1:reps
    file = datasample(seed, filenames, 1);
    load(file);
    y = datasample(seed, 1:20,2);
    r1 = iriscode(y(1), :);
    r2 = iriscode(y(2), :);
    S(1, rep) = pdist([r1;r2], 'hamming');
end

D = zeros(1, reps);

for rep = 1:reps
    files = datasample(seed, filenames, 2, 'Replace', false);
    load(files(1, :));
    r1 = iriscode(datasample(seed, 1:20, 1), :);
    load(files(2, :));
    r2 = iriscode(datasample(seed, 1:20, 1), :);
    D(1, rep) = pdist([r1;r2], 'hamming');
end


% 2
figure,
width_S = 2 * iqr(S) / (length(S)^(1/3));   % Freedman-Diaconis rule
width_D = 2 * iqr(D) / (length(D)^(1/3));   % Freedman-Diaconis rule
width = (width_S + width_D) / 2;
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


% 3
disp('Mean and variance of set S:')
mu_S = sum(S)/length(S);
sigma_S = var(S);
disp(mu_S)
disp(sigma_S)

disp('Mean and variance of set D:')
mu_D = sum(D)/length(D);
sigma_D = var(D);
disp(mu_D)
disp(sigma_D)

%{
x_S = linspace(min(S),max(S),100);
y_S_norm = normpdf(x_S,mu_S,sigma_S);
[maxcount,] = max(h_S.Values);
scaling = maxcount / max(y_S_norm);
plot(x_S, scaling*y_S_norm,...
    'LineWidth', 2,...
    'Color', 'b',...
    'DisplayName','Set S Gaussian')

x_D = linspace(min(D),max(D),100);
y_D_norm = normpdf(x_D,mu_D,sigma_D);
[maxcount,] = max(h_D.Values);
scaling = maxcount / max(y_D_norm);
plot(x_D, scaling*y_D_norm,...
    'LineWidth', 2,...
    'Color', 'r',...
    'DisplayName','Set D Gaussian')
%}

% 5
CDF = normcdf(x_D, mu_D, sigma_D);
dist = abs(CDF - 0.0005);
idx = find(dist == min(dist));
decision_crit = x_D(idx(1));


% 6
testperson = load('testperson.mat').( 'iriscode' );
testmask = zeros(1, length(testperson));
for i = 1:length(testperson)
    if testperson(i) == 2
        testmask(i) = 1;
    end
end

avg_dist = zeros(1, 20);
masked_testperson = or(testperson, testmask);
for person = 1:20
    if person < 10
        filename = sprintf('person%02d.mat', person);
    else
        filename = sprintf('person%2d.mat', person);
    end
    
    person_data = load(filename).('iriscode');
    
    sum_HD = 0;
    for row = 1:20
        masked_row = or(person_data(row, :), testmask);
        HD_row = sum(xor(testmask, masked_row)) / 30;
        sum_HD = sum_HD + HD_row;
    end
    avg_dist(person) = sum_HD / 20;
end
[min_dist, best_match_pers] = min(avg_dist);