
% Task 11
% Alina, Lisa, Ömer and Nikolai


function class = KNN(new_point, K, data, class_labels)
    distances = zeros(1, length(data));
    for idx = 1:length(data)
        distances(idx) = pdist([new_point; data(idx,:)], 'euclidean');
    end

    [~, max_idx] = mink(distances, K); % is already sorted
    classes = unique(class_labels);
    counts = zeros(length(classes), 2);
    for idx = 1:length(counts)
        counts(idx, 1) = classes(idx);
    end

    if K == 1
        class = class_labels(max_idx);
    else
        for idx = 1:length(max_idx)
            for class_idx = 1:length(counts) 
                if counts(class_idx, 1) == class_labels(max_idx(idx))
                    counts(class_idx, 2) = counts(class_idx, 2) + 1;
                    break
                end
            end
        end
        class = classes(find(counts(:,2)== max(counts(:,2))));
        if length(class) > 1; class = class(1); end
    end
end