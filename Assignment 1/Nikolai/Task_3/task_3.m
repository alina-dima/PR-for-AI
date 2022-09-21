
m = [4 5 6; 
     6 3 9; 
     8 7 3; 
     7 4 8; 
     4 6 5];

mu = means(m)

sigma = cov_m(m,mu)


points = [5 5 6; 
          3 5 7; 
          4 6.5 1];

prob = mvnpdf(points,mu,sigma)


function sigma = cov_m(m, mu)
    feat_len = size(m,1);
    num_feat = size(m,2);

    sigma = zeros(num_feat,num_feat);
    mean_diffs = zeros(feat_len,num_feat);

    for i = 1:num_feat
        mean_diffs(:,i) = m(:,i) - mu(i);
    end

    for i = 1:num_feat
        x_diff = mean_diffs(:,i);
        for j = 1:num_feat
            y_diff = mean_diffs(:,j);
            sigma(i, j) = sum_vec(x_diff.*y_diff) / (feat_len - 1);
        end
    end
end


function mu = means(m)
    feat_len = size(m,1);
    num_feat = size(m,2);

    mu = zeros(1,num_feat);

    for i = 1:num_feat
        mu(i) = sum_vec(m(:,i)) / feat_len;
    end
end


function s = sum_vec(arr)
    s = 0;
    for i = 1:length(arr)
        s = s + arr(i);
    end
end
