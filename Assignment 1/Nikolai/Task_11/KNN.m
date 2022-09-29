
function class = KNN(point, K, data, labels)
    n_data = length(data);
    dists = zeros(1, n_data);

    for i = 1:n_data
        dists(i) = pdist2(point, data(i,:), 'euclidean');
    end

    [~, idxs] = sort(dists);

    hist = zeros(1, length(unique(labels)));

    for i = 1:K
        hist_idx = labels(idxs(i)) + 1;
        hist(hist_idx) = hist(hist_idx) + 1;
    end

    [~, class_idx] = max(hist);
    class = class_idx - 1; % since 0 is a class
end


%class = max_tie(hist);
function class_idx = max_tie(hist)
    m = max(hist);
    maxs = [];
    for i = 1:length(hist)
        if hist(i) == m
            maxs = [maxs i];
        end
    end
    class_idx = min(maxs) - 1;
end
