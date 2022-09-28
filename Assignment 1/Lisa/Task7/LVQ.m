% LVQ
function [prototypes, train_error] = LVQ(data, data_labels, start_prototypes, label_protos, learn_rate)
    train_error = [1000];
    epoch = 1;
    go = true;
    prototypes = start_prototypes;
    n_protos = length(prototypes);
    n_data = length(data);
    while go 
        if train_error(epoch) ~= 1000,  epoch = epoch + 1; end
        for i = 1:n_data
           min_idx = get_min_idx(data(i, :), prototypes, n_protos);
           if label_protos(min_idx) == data_labels(i)
               prototypes(min_idx,:) = prototypes(min_idx,:) + learn_rate * (data(i,:) - prototypes(min_idx,:));
           else
               prototypes(min_idx,:) = prototypes(min_idx,:) - learn_rate * (data(i,:) - prototypes(min_idx,:));
           end
        end
        
        train_error(epoch) = train_err(data, data_labels, prototypes, label_protos, n_protos, n_data);
        if epoch ~= 1 && epoch ~= 2 && train_error(epoch) == train_error(epoch - 1) && train_error(epoch - 1) == train_error(epoch - 2)
           go = false;
        end 
    end
end