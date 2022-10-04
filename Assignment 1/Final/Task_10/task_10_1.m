% Task 10 (part 1)
% Alina, Lisa, Ömer and Nikolai

% 1
clear
image=imread('Cameraman.tiff');
figure
imshow(image)

% 2
BW=edge(image,'Canny');
figure
imshow(BW)

% 3 & 4
[H,T,R]=hough(BW);
figure
imshow(H,[],'XData',T,'YData',R);
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on
colormap(gca, hot)

% 5, 6 & 7
t = graythresh(image);
image_th = imbinarize(image, t);
BW_th=edge(image_th,'Canny');
subplot(1,2,1);
imshow(image_th)
title('Binarized/thresholded image');
subplot(1,2,2);
imshow(BW_th)
title('Canny-based edge map');
[H,T,R]=hough(BW_th);
P=houghpeaks(H,5);
figure
imshow(H,[],'XData',T,'YData',R);
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
plot(T(P(:,2)),R(P(:,1)),'s','color','white');
colormap(gca, hot)

% 8
myhoughline(image, R(P(1,1)), T(P(1,2)));

function myhoughline(image,rho,theta)
    figure
    imshow(image)
    hold on
    if theta ~= 0
        x = 1:size(image,1);
        y = -(cosd(theta)/sind(theta))*x+(rho/sind(theta));
    else
        x = rho * ones(size(image,1),1);
        y = 1:size(image,1);
    end
    plot(x,y,'LineWidth',2)
    axis on
end

