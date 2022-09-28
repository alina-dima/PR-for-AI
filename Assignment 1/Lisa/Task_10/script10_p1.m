I = imread('cameraman.tif');
t = graythresh(I);
BW = imbinarize(I,t);
imshow(BW);

BW1 = edge(BW,'Canny');
imshow(BW1);
close
[H,T,R] = hough(BW1);
 
imshow(imadjust(H),'XData',T,'YData',R,...
      'InitialMagnification', 'fit');
title('Hough transform of gantrycrane.png');
xlabel('\theta'), ylabel('\rho');
close
 
peaks = houghpeaks(H, 156); % is already sorted
P_5 = peaks(1:5,:); 

imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on; 
plot(T(P_5(:,2)),R(P_5(:,1)),'s','color','red');
close

lined_img = myhoughlines(I, R(P_5(2,1)), T(P_5(2, 2)));
%imshow(lined_img);

function new_img = myhoughlines(img, rho, theta)
    x_coor = rho * cosd(theta);
    y_coor = rho * sind(theta);
    line_slope = -1/tand(theta); % -1/perpendicular slope
    b = y_coor - x_coor * line_slope;
    x = [1:length(img(1,:))];
    y = round(line_slope * x + b);
    imshow(img)
    hold on
    plot([x(1) x(length(x))],[y(length(y)) y(1)],'Color','r','LineWidth',2)      
end

