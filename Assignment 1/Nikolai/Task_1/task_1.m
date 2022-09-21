
m = load("task_1.mat").lab1_1;

largest = scatter(m(:,1),m(:,3));
saveas(largest,'largest_corr.eps')
% 
% second_largest = scatter(m(:,2),m(:,3));
% saveas(second_largest,"second_largest_corr.eps")

pair_corr_coeff(m)


function m_cov = pair_corr_coeff(m)
    feat_len = size(m,1);
    num_feat = size(m,2);

    m_cov = zeros(num_feat,num_feat);
    mean_diffs = zeros(feat_len,num_feat);

    for i = 1:num_feat
        feat_vec = m(:,i);
        mean_diffs(:,i) = feat_vec - (sum_vec(feat_vec) / feat_len);
    end

    for i = 1:num_feat
        x_diff = mean_diffs(:,i);
        for j = 1:num_feat
            y_diff = mean_diffs(:,j);
            m_cov(i,j) = sum_vec(x_diff.*y_diff) / sqrt(sum_vec(x_diff.^2) * sum_vec(y_diff.^2));
        end
    end
end


function s = sum_vec(arr)
    s = 0;
    for i = 1:length(arr)
        s = s + arr(i);
    end
end
