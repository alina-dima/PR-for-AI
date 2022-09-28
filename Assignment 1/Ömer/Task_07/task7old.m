load("data_lvq_A.mat")
load("data_lvq_B.mat")
scatter(matA, matB)
legend("A", "B")
hold on;
% a) 2 for one class and 1 for the other
eta = 0.01;
mean_A = mean(matA);
proto_A1 = mean_A - mean_A / 2;
proto_A2 = mean_A + mean_A / 2;
proto_B = mean(matB);
for i = 1:25
    for j = 1:length(matA)
        sample = matA(j,:);
        dist_to_A1 = pdist2(proto_A1, sample);
        dist_to_A2 = pdist2(proto_A2, sample);
        dist_to_B = pdist2(proto_B, sample);
        dis = [dist_to_A1, dist_to_A2, dist_to_B];
        if dist_to_A1 == min(dis)
            proto_A1 = proto_A1 + eta*(sample - proto_A1);
        elseif dist_to_A2 == min(dis)
            proto_A2 = proto_A2 + eta*(sample - proto_A2);
        else
            proto_B = proto_B - eta*(sample - proto_B);
        end

    end
    for j = 1:length(matB)
        sample = matB(j,:);
        dist_to_A1 = pdist2(proto_A1, sample);
        dist_to_A2 = pdist2(proto_A2, sample);
        dist_to_B = pdist2(proto_B, sample);
        dis = [dist_to_A1, dist_to_A2, dist_to_B];
        if dist_to_A1 == min(dis)
            proto_A1 = proto_A1 - eta*(sample - proto_A1);
        elseif dist_to_A2 == min(dis)
            proto_A2 = proto_A2 - eta*(sample - proto_A2);
        else
            proto_B = proto_B + eta*(sample - proto_B);
        end

    end
end
plot(proto_A1(:,1), proto_A1(:,2), 'r*');
hold on;
plot(proto_A2(:,1), proto_A2(:,2), 'r*')
hold on;
plot(proto_B(:,1), proto_B(:,2), 'r*');