spam_prior = 0.9;
nospam_prior = 0.1;

customers_spam = 0.005;
customers_nospam = 0035;

watches_spam = 0.0003;
watches_nospam = 0.000004;

fun_spam = 0.00015;
fun_nospam = 0.0007;

vacation_spam = 0.00025;
vacation_nospam = 0.00014;

%a)
spam_prob = spam_prior * customers_spam * watches_spam
nospam_prob = nospam_prior * customers_nospam * watches_nospam

%b)
spam_prob = spam_prior * fun_spam * vacation_spam
nospam_prob = nospam_prior * fun_nospam * vacation_nospam
