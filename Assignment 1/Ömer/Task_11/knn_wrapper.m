clear all;
load task_11.mat;

samples=64;
data = lab3_2;
nr_of_classes = 4;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );
K = [1,3,5,7,9,11,13,15,17,19,21,23,25];
for l = 1:length(K)
    k = K(l);
    for d=1:length(data)
        point = data(d);
        data(d, :) = [];
        % Sample the parameter space
        result=zeros(samples);
        for i=1:samples
          X=(i-1/2)/samples;
          for j=1:samples
            Y=(j-1/2)/samples;
            result(j,i) = KNN([X Y],k,data,class_labels);
          end
        end
        class_label = class_labels(d);
        if class_label > k / 2
            class = 1;
        else
            class = 0;
        end
        data(d, :) = point;
    end
end

% Show the results in a figure
imshow(result,[0 nr_of_classes-1],'InitialMagnification','fit')
hold on;
title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);

% this is only correct for the first question
scaled_data=samples*data;
plot(scaled_data(  1:100,1),scaled_data(  1:100,2),'go');
plot(scaled_data(101:200,1),scaled_data(101:200,2),'r+');


function class = KNN(point,K,data,class_labels)
    dis = [];
    for i = 1:length(data)
        distance = pdist2(point, data(i, :));
        dis(i) = distance;
    end
    [sorted, idx] = sort(dis);
    if sum(class_labels(idx(1:K))) > K / 2
        class = 1;
    else
        class = 0;
    end
end