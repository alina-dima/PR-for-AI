I = imread('cameraman.tif');
imshow(I);
close
BW1 = edge(I,'Canny');
imshow(BW1);
close
[H,T,R] = hough(BW1);

t = (graythresh(H) * max(max(H)));

for r_idx = 1:length(H)
    for c_idx = 1:length(H(1,:))
        if H(r_idx, c_idx) < t
            H(r_idx, c_idx) = 0;
        end
    end
end

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

