function n_miss_classify = lvq_classify(a_nprototypes,b_nprototypes,W,c,X,Y)
    n_prototypes = a_nprototypes + b_nprototypes;

    n_miss_classify = 0;

    for i = 1:length(X)
        x = X(i,:);
        y = Y(i);
        min_dis = flintmax;
        min_idx = -1;

        for j = 1:n_prototypes
            w = W(:,j);
            dis = pdist2(x,w.','euclidean')^2;
            if dis < min_dis
                min_dis = dis;
                min_idx = j;
            end
        end

        if y ~= c(min_idx)
            n_miss_classify = n_miss_classify + 1;
        end
    end

    n_miss_classify = n_miss_classify / length(X);

end