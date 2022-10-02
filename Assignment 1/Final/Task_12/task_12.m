% 1
clear
load('kmeans1.mat')
for k = [2 4 8]
    [clusters,means, movement_points] = kmeans(kmeans1,k,false);
    plot_clusters(kmeans1,k,clusters,means, movement_points);
end


% 2
%{
load('checkerboard.mat')
k = 100;
error = zeros(20,1);
error_pp = zeros(20,1);
for i = 1:20
    [clusters,means] = kmeans(checkerboard,k,false);
    [clusters_pp,means_pp] = kmeans(checkerboard,k,true);
    error(i) = quant_error(checkerboard,clusters,means);
    error_pp(i) = quant_error(checkerboard,clusters_pp,means_pp);
end
mu_error = mean(error);
mu_error_pp = mean(error_pp);
sd_error = std(error);
sd_error_pp = std(error_pp);
[h,p,ci,stat] = ttest2(error,error_pp,'Vartype','unequal');
display(h), display(p), display(ci), display(stat)
%}


% Implementation of k-means clustering for the feature vector X
% with k clusters. The function returns, in order, the index
% of the cluster that each point of X belongs to.
function [clusters,means,movement_points] = kmeans(X,k,plusplus)
    clusters = zeros(size(X,1),1);
    movement_points = zeros(10000, k, size(X,2));
    if plusplus
        means = initialize_means(X,k);
    else
        means = X(randsample(size(X,1),k,'false'),:);
    end
    changed = true;
    count = 1;
    while changed
        changed = false;
        dist = pdist2(X,means);
        sum_terms = zeros(k,size(X,2));
        nr_terms = zeros(k,1);
        for i = 1:size(X,1)
            [~, new_cluster] = min(dist(i, :));
            sum_terms(new_cluster,:) = sum_terms(new_cluster,:)+X(i,:);
            nr_terms(new_cluster) = nr_terms(new_cluster)+1;
            if new_cluster ~= clusters(i)
                clusters(i) = new_cluster;
                changed = true;
            end
        end
        means = sum_terms./nr_terms;
        movement_points(count,:,:) = means;
        count = count + 1;
    end
    movement_points = movement_points(1:count-1,:,:);
end

% Given a feature vector X, k clusters and the index of the cluster
% that each data point belong to, the function plots the points
% differentiated by cluster alongside their mean.
function plot_clusters(X,k,clusters,means, movement_points)
    % The colors are pre-defined for good distinguishability.
    % For k > 8, more colors should be added.
    clrs = [240 35 85; 60 180 75; 255 225 25; 40 160 230; ...
            245 130 48; 220 190 255; 70 240 240; 210 245 60]./255;
    figure
    tiledlayout('flow')
    nexttile
    hold on
    for cluster = 1:k
        pts = X(find(clusters==cluster),:);
        scatter(pts(:,1),pts(:,2),100,clrs(cluster,:),'.',...
                'DisplayName',append('Cluster ',num2str(cluster)))
        scatter(means(cluster,1),means(cluster,2),...
                40,max(0,clrs(cluster,:)-0.4),'LineWidth',1.5,...
                'DisplayName',append('Cluster ',num2str(cluster),' mean'))
        xlabel('Feature 1')
        ylabel('Feature 2')
    end
    hold off
    lgd = legend();
    lgd.Layout.Tile = 'east';
    
    figure
    tiledlayout('flow')
    nexttile
    hold on
    for i = 1:k
        scatter(movement_points(:,i,1),movement_points(:,i,2),100,...
                clrs(i,:),'DisplayName',append('Cluster ',num2str(i)));
        xlabel('Feature 1')
        ylabel('Feature 2')
        hold on;
    end
    hold off
    lgd = legend();
    lgd.Layout.Tile = 'east';
end

% The function returns k prototypes to be used as means/centroids
% in k-means.
function means = initialize_means(X,k)
    chosen(1) = randi(size(X,1));
    means(1,:)=X(chosen(1),:);
    D = zeros(size(X,1),1);
    for prot = 2:k
        for x = 1:size(X,1)
            D(x) = min(pdist2(X(x,:),means));
        end
        D = D./max(D);  % Brings D in [0,1]
        means(prot,:)=X(randsample(size(X,1),1,true,D.^2),:);
    end
end

% The function returns the quantization error resulting from k-means.
% The function uses the data (X), the cluster that each point was assigned
% to and the means/centroids of the clusters.
function qe = quant_error(X,clusters,means)
    sum_sq_error = 0;
    for i = 1:size(X,1)
        centroid = means(clusters(i),:);
        sum_sq_error = sum_sq_error+pdist2(X(i,:),centroid,...
                                           'squaredeuclidean');
    end
    qe = sum_sq_error/size(X,1);
end