data = load('kmeans1.mat').kmeans1;
cluster_centers = kmeans(data, 8, 1);
plot_clusters(data, cluster_centers);
close;


data = load('checkerboard.mat').checkerboard;
n_runs = 20;
k = 100;

[mean_q_err, std_q_err, q_err] = n_runs_kmeans(data, k, n_runs, 0);
[mean_q_err_plus, std_q_err_plus, q_err_plus] = n_runs_kmeans(data, k, n_runs, 1);
[h, p] = ttest2(q_err, q_err_plus);
[ mean_q_err, std_q_err ]
[ mean_q_err_plus, std_q_err_plus ]
[h, p]


function [mean_q_err, std_q_err, q_err] = n_runs_kmeans(data, k, n_runs, kmeans_plus)
    q_err = zeros(1, n_runs);
    for n_run = 1:n_runs
        n_run
        cluster_centers = kmeans(data, k, kmeans_plus);
        q_err(n_run) = quantization_error(data, cluster_centers);
    end
    
    mean_q_err = mean(q_err);
    std_q_err = std(q_err);
end

function plot_clusters(data, cluster_centers)
    distances = zeros(1, length(cluster_centers) );
    cluster_idx_data = zeros(1, length(data));
    cluster_idx_data = assign_clusters(cluster_centers, data, cluster_idx_data, distances);
    for cluster_idx = 1:length(cluster_centers)
        txt = ['Class ',num2str(cluster_idx) ];
        cluster_data = data(cluster_idx_data == cluster_idx,: );
        scatter( cluster_data(:,1), cluster_data(:, 2), 'fill', 'DisplayName',txt );
        xlabel('Feature 1');
        ylabel('Feature 2');
        hold on

    end
    legend show
end

function centroids =  kmeans(data, k, kmeans_extension)
    [ data, centroids ] = get_centroids(data, k, kmeans_extension);
    prev_centroids = zeros( length(centroids), length( centroids(1,:) ) ) ;
    distances = zeros(1, length(centroids) );
    cluster_idx_data = zeros(1, length(data));
    runs = 0;
    while prev_centroids ~= centroids
        runs = runs + 1;
        prev_centroids = centroids;
        cluster_idx_data = assign_clusters(centroids, data, cluster_idx_data, distances);
        for centr_idx = 1:length(centroids)
            centroid_data = data(cluster_idx_data == centr_idx,: );
            centroids(centr_idx,:) = mean(centroid_data);
        end
    end
end

function cluster_idx_data = assign_clusters(centroids, data, cluster_idx_data, distances)
    for data_idx = 1:length(data)
        for centr_idx = 1:length(centroids)
            distances(centr_idx) = pdist([centroids(centr_idx, :); data(data_idx, :)]);
        end
        [~, centr_idx] = min(distances);
        cluster_idx_data(data_idx) = centr_idx;
    end
end

function [data, centroids] = get_centroids(data, k, kmeans_extension)
    if kmeans_extension == 1
        [ data, centroids ] = kmeans_plus_init(data, k);
    else
        centroids_indices = datasample( [ 1:length(data) ], k );
        centroids = data(centroids_indices, :);
        data(centroids_indices,:) = [];
    end
end

function [data, centroids] = kmeans_plus_init(data, k)
    for i = 1:k
       if i == 1
           new_centroid_idx = datasample( [ 1:length(data) ], 1);
           centroids = data(new_centroid_idx, :); 
           data(new_centroid_idx, :) = [];
       else
           all_dists = zeros(1, length(data) );
           for data_idx = 1:length(data)
               distances = zeros(1, length(centroids) );
               if length(centroids(1,:)) ~= 1
                   for centr_idx = 1:length(centroids)
                       if i <= 2
                           distances(centr_idx) = pdist([centroids; data(data_idx, :)] );
                       else
                           distances(centr_idx) = pdist([centroids(centr_idx, :); data(data_idx, :) ] );
                       end
                   end
                   [min_dist, ~] = min(distances);
               else
                   min_dist = pdist([centroids; data(data_idx, :) ] );
               end
               all_dists(data_idx) = min_dist;
           end
           sum_dists = sum(all_dists.^ 2);
           probs = all_dists / sum_dists;
           [~, max_idx] = max(probs);
           centroids = [centroids; data(max_idx,:) ];
           data(max_idx, :) = [];
       end
    end
end

% only for cases where k > 1
function q_err = quantization_error(data, centroids)
    all_dists = zeros(1, length(data));
    for data_idx = 1:length(data)
       distances = zeros(1, length(centroids) );
       for centr_idx = 1:length(centroids)
           distances(centr_idx) = pdist([centroids(centr_idx, :); data(data_idx, :) ] );
       end
       [min_dist, ~] = min(distances);
       all_dists(data_idx) = min_dist;
    end
    q_err = sum(all_dists.^ 2);
end


   

