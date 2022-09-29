
img = imread("HeadTool0002.bmp");
adjusted_img = adapthisteq(im2double(img));
imshow(adjusted_img)

[centers, radii, metric] = imfindcircles(adjusted_img,[20 40],"Sensitivity",0.9);

plot_all = false;

if plot_all == true
    for i = 1:min(6,length(centers))
        viscircles(centers(i:i,:), radii(i:i),'EdgeColor','b');
    end
end

plot_strongest_two = true;

if plot_strongest_two
    [~, idxs] = sort(metric);
    for j = 1:2
        i = idxs(j);
        viscircles(centers(i:i,:), radii(i:i),'EdgeColor','b');
    end
end

figure
edges = edge(adjusted_img, "Canny");
[H,theta,rho] = hough(edges);
imshow(imadjust(rescale(H)),'XData',theta,'YData',rho,'InitialMagnification','fit');
hold on;
axis normal;
axis on;



