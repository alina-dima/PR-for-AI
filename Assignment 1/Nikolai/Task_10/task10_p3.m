
%1
img = zeros(50,50,'uint8');
img(10,10) = 255;
%showHough(img);


%2
img = zeros(50,50,'uint8');
img(10,10) = 255;
img(25,15) = 255;
img(30,29) = 255;
%showHough(img);




%3
img = zeros(50,50,'uint8');
img(10,10) = 255;
img(10,11) = 255;
img(10,12) = 255;

img_edges = edge(img, 'canny');
[H,theta,rho] = hough(img_edges);
imshow(img)
peaks = houghpeaks(H, 1);


h_line = houghlines(img_edges, theta, rho, peaks);
h_line

p = [h_line.point1 h_line.point2];
plot(p(:,1), p(:,2), 'Color', 'red');






















%     imshow(H,[],'XData',theta,'YData',rho,'InitialMagnification','fit');
%     xlabel('\theta'), ylabel('\rho');
%     axis on, axis normal, hold on;
%     plot(theta(peaks(:,2)),rho(peaks(:,1)),'s','color','red');
