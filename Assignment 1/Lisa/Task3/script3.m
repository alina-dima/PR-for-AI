feat_vec = [4 5 6; 6 3 9; 8 7 3; 7 4 8; 4 6 5];

cov_mat = get_cov(feat_vec);

means = [0 0 0];
for i = 1:3
    means(i) = sum(feat_vec(:, i))/length(feat_vec(:, i));
end

mvnpdf([5 5 6], means, cov_mat)
mvnpdf([3 5 7], means, cov_mat)
mvnpdf([4 6.5 1], means, cov_mat)

function cov_mat = get_cov(feat_vec)
    cov_mat = [0 0 0; 0 0 0; 0 0 0];
    
    for r = 1:3
        f1 = feat_vec(:, r);
        mean_f1 = sum(f1)/length(f1);
        for c = 1:3
            f2 = feat_vec(:, c);
            mean_f2 = sum(f2)/length(f2);
            cov_mat(r, c) = sum((f1 - mean_f1) .* (f2 - mean_f2))/(length(f1) - 1);
        end
    end
end


