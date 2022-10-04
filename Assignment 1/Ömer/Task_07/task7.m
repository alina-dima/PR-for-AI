load("data_lvq_A.mat")
load("data_lvq_B.mat")
scatter(matA, matB)
legend("A", "B")
hold on;
% a) 2 for one class and 1 for the other
mean_A = mean(matA);
proto_A1 = [mean_A - mean_A / 2 0];
proto_A2 = [mean_A + mean_A / 2 0];
proto_B = [mean(matB) 1];
prototypes = [proto_A1; proto_A2; proto_B];
for i = 1:100
    update(matA, prototypes, 0);
    update(matB, prototypes, 1);
end
for p = 1:length(prototypes(:,1))
    proto = prototypes(p,:);
    xp = proto(1);
    yp = proto(2);
    plot(xp, yp, 'r*');
    hold on;

end

function prototypes = update(matrix, prototypes, label)
    eta = 0.01;
    for j = 1:length(matrix)
        sample = matrix(j,:);
        min_dist = 100;
        best_pidx = 1;
        for p = 1:length(prototypes(:,1))
            proto = prototypes(p,:);
            xp = proto(1);
            yp = proto(2);
            dist = pdist2([xp yp], sample);
            if dist < min_dist
                best_pidx = p;
                min_dist = dist;
            end
        end
        best_p = prototypes(best_pidx,:);
        coords = [best_p(1), best_p(2)];
        if best_p(3) == label
            prototypes(best_pidx,:) = [coords + eta*(sample - coords) label];
        else
            prototypes(best_pidx,:) = [coords - eta*(sample - coords) abs(label - 1)];
        end
    end
end