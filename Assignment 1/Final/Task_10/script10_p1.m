I = imread('cameraman.tif');
imshow(I);

BW1 = edge(I,'Canny');
imshow(BW1);
close
[H,T,R] = hough(BW1);
 
imshow(imadjust(H),'XData',T,'YData',R,...
      'InitialMagnification', 'fit');
title('Hough transform of gantrycrane.png');
xlabel('\theta'), ylabel('\rho');
close

t = graythresh(H);
t = t * max(max(H));

for r_idx = 1:length(H)
    for c_idx = 1:length(H(1,:))
        if H(r_idx, c_idx) <= t
            H(r_idx, c_idx) = 0;
        end    
    end
end

peaks = houghpeaks(H, 5); % is already sorted

imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on; 
plot(T(peaks(:,2)),R(peaks(:,1)),'s','color','red');
close

myhoughlines(I, R(peaks(2,1)), T(peaks(2, 2)));

function myhoughlines(image, rho, theta)
    figure
    imshow(image)
    hold on
    if theta ~= 0
        x = 1:size(image,1);
        y = -(cosd(theta)/sind(theta))*x + (rho/sind(theta));
    else
        x = rho * ones(size(image,1),1);
        y = 1:size(image,1);
    end
    plot(x,y,'LineWidth',2)
    axis on
end

