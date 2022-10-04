prob_cust = [0.005 0.0001];
prob_watches = [0.0003 0.000004];
prob_fun = [0.00015 0.0007];
prob_vac = [0.00025 0.00014];
prior_spam = 0.9;
prior_non_spam = 0.1;

prob_spam1 = prob_cust(1)*prior_spam*prob_watches(1) ;
prob_non_spam1 = prob_cust(2)*prior_non_spam*prob_watches(2);

prob_spam2 = prob_fun(1)*prior_spam*prob_vac(1) ;
prob_non_spam2 = prob_fun(2)*prior_non_spam*prob_vac(2);
prob_spam1
prob_non_spam1
prob_spam2
prob_non_spam2
