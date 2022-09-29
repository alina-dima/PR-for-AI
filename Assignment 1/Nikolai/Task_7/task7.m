
matA = load("data_lvq_A.mat").matA;
matB = load("data_lvq_B.mat").matB;


% Need at least 3 prototypes

X = vertcat(matA, matB);
Y = vertcat(zeros(length(matA), 1) + 1, zeros(length(matB), 1));
a_nprototypes = 2;
b_nprototypes = 2;

[W,E] = lvq(a_nprototypes,b_nprototypes,X,Y);

scatter(matA(:,1), matA(:,2), 'red');
hold on
scatter(matB(:,1), matB(:,2), 'blue');
hold on

for i = 1:a_nprototypes
    scatter(W(1,i), W(2,i), 120, 'red', "filled");
end

for i = a_nprototypes+1:a_nprototypes + b_nprototypes
    scatter(W(1,i), W(2,i), 120, 'blue', "filled");
end

hold off
legend('Class A', 'Class B')
xlabel('Feature 1')
ylabel('Feature 2')
figure

plot(E)
xlabel('Epoch')
ylabel('Training Erorr')


function [W,E] = lvq(a_nprototypes, b_nprototypes, X, Y)
    stop_thresh_diff = 0.01;
    stable_thresh = 5;
    n_features = 2;
    lr = 0.01;

    n_prototypes = a_nprototypes + b_nprototypes;
    W = randi([ceil(min(X(:))), floor(max(X(:)))], n_features, n_prototypes);
    c = zeros(1, n_prototypes);

    E = zeros(1, 1000);
    data_len = length(X);
    epoch = 2;
    stable = stable_thresh;

    for i = 1:a_nprototypes
        c(i) = 1; % set labels
    end

    while true
        n_miss_classify = 0;

        for i = 1:length(X)
            x = X(i,:);
            y = Y(i);
            min_dis = flintmax;
            min_idx = -1;

            % find minimum weight
            for j = 1:n_prototypes
                w = W(:,j);
                dis = pdist2(x,w.','euclidean')^2;
                if dis < min_dis
                    min_dis = dis;
                    min_idx = j;
                end
            end

            % update weight
            w = W(:,min_idx);
            if y == c(min_idx)
                W(:,min_idx) = w + (lr * (x.' - w));
            else
                W(:,min_idx) = w - (lr * (x.' - w));
                n_miss_classify = n_miss_classify + 1;
            end
        end

        E(epoch) = n_miss_classify / data_len;

        if abs(E(epoch-1) - E(epoch)) <= stop_thresh_diff
            if stable == 0
                break;
            end
            stable = stable - 1;
        else
            stable = stable_thresh;
        end
        
        epoch = epoch + 1;
    end
    E = E(2:epoch);
    fprintf("Number of epochs = %d\n", length(E));
end