function cross_validation(data_A,data_B,no_A,no_B)
    % Each group of [10(i-1)+1, 10i], will be test data once
    % The other [10(n-1)+1, 10n], where n~=i, will be the training data
    A_indices = randperm(100);
    B_indices = randperm(100);
    test_E = zeros(1,10);
    train_E = zeros(1,10);
    for i = 1:10
        [test_A,train_A] = split_test_train(data_A,A_indices,i);
        [test_B,train_B] = split_test_train(data_B,B_indices,i);
        [~,prot_all] = LVQ(train_A,train_B,no_A,no_B);
        test_E(i) = get_error(test_A,test_B,prot_all);
        train_E(i) = get_error(train_A,train_B,prot_all);
    end
    display(append("Test error: ",num2str(mean(test_E))))
    figure()
    bar(train_E*100,'HandleVisibility','off')
    ylim([0 max(round(train_E*100)+5)])
    text(1:length(train_E),train_E*100,num2str(round(train_E*100)')+...
        "%",'vert','bottom','horiz','center')
    yline(mean(test_E*100),'LineWidth',1.5,'Color','red',...
          'DisplayName','Test error')
    xlabel('Fold')
    ylabel('Training error (%)')
    legend
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