function cross_validation(data_A,data_B,no_A,no_B)
    % Each group of [10(i-1)+1, 10i], will be test data once
    % The other [10(n-1)+1, 10n], where n~=i, will be the training data
    A_indices = randperm(100);
    B_indices = randperm(100);
    test_E = zeros(1,10);
    train_E = zeros(9,10);
    for i = 1:10
        [test_A,train_A] = split_test_train(data_A,A_indices,i);
        [test_B,train_B] = split_test_train(data_B,B_indices,i);
        [~,prot_all] = LVQ(train_A,train_B,no_A,no_B);
        test_E(i) = get_error(test_A,test_B,prot_all);
        for t_idx = 1:10
            if t_idx < i
                train_A_fold = train_A(10*(t_idx-1)+1:10*t_idx,:);
                train_B_fold = train_B(10*(t_idx-1)+1:10*t_idx,:);
                train_E(i-1,t_idx) = get_error(train_A_fold,...
                                               train_B_fold,prot_all);
            elseif t_idx > i
                train_A_fold = train_A(10*(t_idx-2)+1:10*(t_idx-1),:);
                train_B_fold = train_B(10*(t_idx-2)+1:10*(t_idx-1),:);
                train_E(i,t_idx) = get_error(train_A_fold,...
                                             train_B_fold,prot_all);
            end
        end
    end
    display(append("Test error: ",num2str(mean(test_E))))
    figure()
    train_SD = std(train_E);
    bar(mean(train_E),'HandleVisibility','off')
    hold on
    errorbar(1:10,mean(train_E),-train_SD,train_SD,'Color','black',...
             'LineStyle','none','LineWidth',1.5,'HandleVisibility','off')
    yline(mean(test_E),'LineWidth',1.5,'Color','red',...
          'DisplayName','Test error')
    xlabel('Fold')
    ylabel('Training error (± 1 SD)')
    legend()
end

function [test, train] = split_test_train(data,indice_order,test_i)
    test = data(indice_order(10*(test_i-1)+1:10*test_i),:);
    train = cat(1, data(indice_order(1:10*(test_i-1)),:),...
                   data(indice_order(10*test_i+1:end),:));
end

function E = get_error(test_A,test_B,prot)
    data = cat(1,test_A,test_B);
    dist = pdist2(data(:, 1:2),prot(:, 1:2));
    misclass = 0;
    for pt = 1:size(data,1)
        class = 1;
        if pt > size(test_A,1)
            class = 2;
        end
        [~,best_prot] = min(dist(pt,:));
        if class ~= prot(best_prot,3)
            misclass = misclass + 1;
        end
    end
    E = misclass / size(data,1);
end