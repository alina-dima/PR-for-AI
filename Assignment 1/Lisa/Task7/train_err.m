
% Compute training error
function train_error = train_err(data, data_labels, prototypes, proto_labels, n_protos, n_data)
    n_false = 0;

    for idx = 1:n_data
        min_idx = get_min_idx(data(idx, :), prototypes, n_protos);
        if proto_labels(min_idx) ~= data_labels(idx), n_false = n_false + 1; end
    end
    train_error = n_false / n_data;
end