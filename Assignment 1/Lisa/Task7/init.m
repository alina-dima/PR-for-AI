function [init_protos, label_protos] = init(n_class_A, n_class_B, data_A, data_B)
    label_protos = zeros(1, n_class_A + n_class_B);
    init_protos = [datasample(data_A, n_class_A); datasample(data_B, n_class_B)];
    label_protos(n_class_A + 1:n_class_B + n_class_A) = 1;
end