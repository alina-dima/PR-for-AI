img = im2double(imread("HeadTool0002.bmp"));
img_contrasted = adapthisteq(img);
imshow(img_contrasted);


[centers, radii, metric] = imfindcircles(img_contrasted, [20 40], 'Sensitivity', 0.9);
viscircles(centers, radii,'EdgeColor','b');
close;
imshow(img_contrasted);
viscircles(centers(1:2, :), radii(1:2, :),'EdgeColor','b');
peaks = metric(1:2)

