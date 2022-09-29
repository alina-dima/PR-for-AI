
matA = load("data_lvq_A.mat").matA;
matB = load("data_lvq_B.mat").matB;

X = vertcat(matA, matB);
Y = vertcat(zeros(length(matA), 1) + 1, zeros(length(matB), 1));

n_folds = 10;
errors = zeros(1, n_folds);

for i = 1:n_folds
    bound = (20*(i-1)) + 1;
    X_test = X(bound:bound+19,:);
    Y_test = Y(bound:bound+19,:);

    remain = setdiff(1:length(X),bound:bound+19);
    X_train = X(remain,:);
    Y_train = Y(remain,:);

    [W,c,E] = lvq(2,1,X_train,Y_train);
    errors(i) = lvq_classify(2,1,W,c,X_train,Y_train);
end

errors = errors * 100;
mu = mean(errors);
fprintf("Test error: %f \n", mu);
bar(errors);
xlabel("Fold")
ylabel("Classifiction Error (%)")
yline(mu,Color="red")
text(1:length(errors),errors,num2str(round(errors)')+"%",'vert','bottom','horiz','center')


