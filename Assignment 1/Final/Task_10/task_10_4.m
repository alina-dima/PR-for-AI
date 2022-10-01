% Part 4
% 1
clear
image = imread('HeadTool0002.bmp');
image = im2double(image);

% 2
contrasted = adapthisteq(image);

% 3
[centers,radii,metric] = imfindcircles(contrasted,[20 40],...
    'Sensitivity',0.9);

% 4
imshow(contrasted)
viscircles(centers,radii);

% 5
strongest_centers = centers(1:2,:);
strongest_radii = radii(1:2,:);
figure
imshow(contrasted)
viscircles(strongest_centers,strongest_radii)

% 6
metric(1:2)