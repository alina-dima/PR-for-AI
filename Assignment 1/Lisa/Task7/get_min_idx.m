
% Compuing minimum distance + return idx
function min_idx = get_min_idx(data_point, prototypes, n_protos)
    distances = zeros(1, n_protos);
    for j = 1:n_protos, distances(j) = pdist([prototypes(j, :); data_point], 'euclidean'); end
    [~, min_idx] = min(distances);
end