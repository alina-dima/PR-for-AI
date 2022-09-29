
im = imread("Cameraman.tiff");
% imshow(im)
% figure

edges = edge(im, "Canny");
%im = imbinarize(im,graythresh(im));
%edges = edge(im, "Canny");
%imshow(edges)
figure

[H,theta,rho] = hough(edges);
% imshow(imadjust(rescale(H)),'XData',theta,'YData',rho,'InitialMagnification','fit');
% hold on;
% axis normal;
% axis on;

%5
%thresh hold actual image
thresh = 80;
dims = size(H);
H_thresh = zeros(dims(1), dims(2));
for i = 1:dims(1)
    for j = 1:dims(2)
        if H(i,j) >= thresh
            H_thresh(i,j) = H(i,j);
        end
    end
end

% imshow(imadjust(rescale(H_thresh)),'XData',theta,'YData',rho,'InitialMagnification','fit');
% hold on;
% axis normal;
% axis on;

%6
max_val = max(H_thresh,[],"all");
[row, col] = find(H_thresh == max_val);
max_rho = rho(row);
max_theta = theta(col);
fprintf("Max rho = %d Max theta = %d\n",max_rho,max_theta);

%7
P = houghpeaks(H,1);
% imshow(H,[],'XData',theta,'YData',rho,'InitialMagnification','fit');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;
% plot(theta(P(:,2)),rho(P(:,1)),'s','color','red');

%8
hold off
figure
imshow(im)
hold on
axis on
for i = 1:length(P)
    r = rho(P(i,1));
    t = theta(P(i,2));
    myhoughline(im, r,t);
end

function myhoughline(img, rho, theta)
    %r_theta = deg2rad(theta);
    % check if line is vertical
    p = [cosd(theta) sind(theta)]; 
    % unit vector (x y)
    % unit normal is (-y x)
    % slope = (x / -y)
    m = p(1) / -p(2);
    b = rho / cosd(90 - theta);
    x = linspace(1,length(img),10);
    y = m * x + b;
    line(x,y,"Color","red");
    hold on
end

