black_img = zeros(50, 50);
black_img(25,25) = 255;
imshow(black_img);

[H,T,R] = hough(black_img);
 
imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification', 'fit');
title('Hough transform of gantrycrane.png');
xlabel('\theta'), ylabel('\rho');
close
black_img = zeros(50, 50);
black_img(25,25) = 255;
black_img(9,37) = 255;
black_img(34, 43) = 255;
imshow(black_img);

[H,T,R] = hough(black_img);

imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification', 'fit');
title('Hough transform of gantrycrane.png');
xlabel('\theta'), ylabel('\rho');
close

black_img = zeros(50, 50);
black_img(25,25) = 255;
black_img(25,26) = 255;
black_img(25, 27) = 255;
imshow(black_img);

[H,T,R] = hough(black_img);

imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification', 'fit');
title('Hough transform of gantrycrane.png');
xlabel('\theta'), ylabel('\rho');
close

peaks = houghpeaks(H, 100);
max_peak = peaks(1,:);

imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on; 
plot(T(max_peak(2)),R(max_peak(1)),'s','color','red');
close

lines = houghlines(black_img,T,R,peaks);
imshow(black_img), hold on
max_len = 0;
lines

for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   xy
   plot(xy(:,1),xy(:,2),'LineWidth',10,'Color','red');
end

