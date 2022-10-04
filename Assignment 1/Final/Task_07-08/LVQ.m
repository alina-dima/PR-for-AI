
% Task 7 
% Alina, Lisa, Ömer and Nikolai

function [E, prot_all] = LVQ(data_A,data_B,no_prot_A,no_prot_B)
    prot_A = data_A(randsample(size(data_A,1),no_prot_A,false),:);
    prot_B = data_B(randsample(size(data_B,1),no_prot_B,false),:);

    % The third columns of tr_data and prot_all are labeled as follows:
    % 1 for class A samples and 2 for class B samples
    tr_data = cat(1,cat(2,data_A,ones(length(data_A),1)),...
              cat(2,data_B,2.*ones(length(data_B),1)));
    prot_all = cat(1,cat(2,prot_A,ones(size(prot_A,1),1)),...
               cat(2,prot_B,2.*ones(size(prot_B,1),1)));
    
    eta = 0.01;
    E = [];
    unchanged_E = 0;
    epoch_no = 0;
    while unchanged_E < 3 && epoch_no < 50
        epoch_no = epoch_no + 1;
        misclass = 0;
        dist = pdist2(tr_data(:,1:2),prot_all(:,1:2));
        for pt = 1:size(tr_data,1)
            [~,best_prot] = min(dist(pt,:));
            if tr_data(pt,3) == prot_all(best_prot,3)
                prot_all(best_prot,1:2) = prot_all(best_prot,1:2) +...
                                          eta.*(tr_data(pt,1:2) -...
                                          prot_all(best_prot, 1:2));
            else
                misclass = misclass + 1;
                prot_all(best_prot, 1:2) = prot_all(best_prot, 1:2) -...
                                           eta.*(tr_data(pt, 1:2) -...
                                           prot_all(best_prot, 1:2));
            end
        end
        E(epoch_no) = misclass / length(tr_data);
        if epoch_no > 1 && E(epoch_no) == E(epoch_no - 1)
            unchanged_E = unchanged_E + 1;
        else
            unchanged_E = 0;
        end
    end
end
