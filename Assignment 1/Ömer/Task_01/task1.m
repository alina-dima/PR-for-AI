load("task1.mat")
lab1_1

corr(lab1_1)
height = lab1_1(:,1);
age = lab1_1(:,2);
weight = lab1_1(:,3);

scatter(height, weight)
