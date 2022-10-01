% Part 3
% 1
tiledlayout(1,2);
nexttile
image=zeros(50,50);
white_px = randi(50, 1, 2);
image(white_px(1), white_px(2)) = 1;
[H,T,R]=img_and_hough(image);

% 2
figure()
tiledlayout(1,2);
nexttile
image=zeros(50,50);
white_px = zeros(3,2);
white_px(:,1) = randsample(50, 3, false);
white_px(:,2) = randsample(50, 3, false);
for pt=1:3
    image(white_px(pt,1), white_px(pt,2)) = 1;
end
[H,T,R]=img_and_hough(image);

% 3
figure()
tiledlayout(1,2);
nexttile
image=zeros(50,50);
white_px = zeros(3,2);
white_px(:,1) = randsample(50, 3, false);
white_px(:,2) = randsample(50, 1);
for pt=1:3
    image(white_px(pt,1), white_px(1,2)) = 1;
end
[H, T, R]=img_and_hough(image);

% 5
P=houghpeaks(H,1);
plot(T(P(2)),R(P(1)),'s','color','white');

% 6
lines = houghlines(image,T,R,P,'FillGap',50,'MinLength',1);
figure
imshow(image,'InitialMagnification','fit')
hold on
for l = 1:length(lines)
   line = [lines(l).point1; lines(l).point2];
   plot(line(:,1),line(:,2),'LineWidth',1.5);
   title('Line Through Aligned Points')
   axis on, hold on
   plot(line(1,1),line(1,2),'x','LineWidth',1.5,'Color','red');
   plot(line(2,1),line(2,2),'x','LineWidth',1.5,'Color','red');
end

function [H, T, R] = img_and_hough(image)
    imshow(image)
    title('Image')
    axis on

    [H,T,R]=hough(image);
    nexttile
    imshow(H,[],'XData',T,'YData',R);
    title('Hough Space')
    xlabel('\theta'), ylabel('\rho');
    axis on, hold on;
end


