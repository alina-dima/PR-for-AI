D = zeros(1,1000);
S = zeros(1,1000);

for i = 1:1000
    file_num = randi([1 20],1,1);
    filename = sprintf("person%02d.mat",file_num);
    
    load(filename);
    while true
        random_pair = randi([1 20],1,2);
        row_idx1 = random_pair(1);
        row_idx2 = random_pair(2);
        if row_idx2 ~= row_idx1
            break;
        end
    end
    row_1 = iriscode(row_idx1,:);
    row_2 = iriscode(row_idx2,:);
    S(i) = pdist2(row_1,row_2, "hamming");
end

for i = 1:1000
    
    while true
        random_pair = randi([1 20],1,2);
        file_num1 = random_pair(1);
        file_num2 = random_pair(2);
        if file_num1 ~= file_num2
            break;
        end
    end
    filename1 = sprintf("person%02d.mat",file_num1);
    filename2 = sprintf("person%02d.mat",file_num2);
    iriscode1 = load(filename1).iriscode;
    iriscode2 = load(filename2).iriscode;

    random_pair = randi([1 20],1,2);
    row_idx1 = random_pair(1);
    row_idx2 = random_pair(2);
    row_1 = iriscode1(row_idx1,:);
    row_2 = iriscode2(row_idx2,:);
    D(i) = pdist2(row_1,row_2, "hamming");
end

overlap = 0;
for i = intersect(S,D)
    intersect(S, D)
    len1 = length(find(S==intersect(S, D)));
    len2 = length(find(D==intersect(S, D)));
    overlap = overlap + min(len1, len2);
end
overlap = (overlap / 1000) * 100;

dist_Sx = linspace(-0.2, 1, 1000);
dist_S = normpdf(dist_Sx, mean(S), sqrt(var(S)));
h_S = histogram(S, "BinWidth", 0.03);
hold on;
h_D = histogram(D, "BinWidth", 0.03);
hold on;
plot(dist_Sx, dist_S)

mean(S)
var(S)

mean(D)
var(D)