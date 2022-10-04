% imageData = imread('Cameraman.tiff'); % read img
% subplot(1,3,1);
% imshow(imageData);
% title('Original image');

% BW1 = edge(imageData,'Canny'); % compute Canny
% subplot(1,3,2);
% imshow(BW1)
% title('Canny-based edge map');

level = graythresh(imageData);
BW = imbinarize(imageData,level);
subplot(1,3,1);
imshow(BW)
title('Binarized/thresholded image');

BW = edge(BW,'Canny'); % compute Canny
subplot(1,3,2);
imshow(BW)
title('Canny-based edge map');


% [H,T,R] = hough(BW1,'RhoResolution',0.5,'Theta',-90:0.5:89); % compute Hough
% 
% subplot(1,3,3);
% imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
%       'InitialMagnification','fit');
% title('Hough transform of the edge map');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;
% colormap(gca,hot); % plot Hough


[H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89); % compute Hough

subplot(1,3,3);
imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough transform of gantrycrane.png');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot); % plot Hough