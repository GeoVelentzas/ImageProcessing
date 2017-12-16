clear all; close all; clc;

addpath(genpath('./'));

img1 = imread('eiffel_00.jpg');
p1 = harris(img1);

img2 = imread('eiffel_01.jpg');
p2 = harris(img2);

img3 = imread('eiffel_02.jpg');
p3 = harris(img3);

img4 = imread('eiffel_03.jpg');
p4 = harris(img4);

binsize = 3;
thres = 0.9;

subplot(2,2,1);
imshow(img1);
title('reference picture');

[r, c, A, A_t]= hough2d(img1, p1, img2, p2, binsize, thres);
subplot(2,2,2);
imshow(img2);
hold on;
for i =1 : length(r)
draw_bb(img1,r(i),c(i),0.4/length(r))
end
title('found in picture 2');


[r, c, A, A_t]= hough2d(img1, p1, img3, p3, binsize, thres);
subplot(2,2,3);
imshow(img3);
hold on;
for i =1 : length(r)
draw_bb(img1,r(i),c(i),0.4/length(r))
end
title('found in picture 3');


[r, c, A, A_t]= hough2d(img1, p1, img4, p4, binsize, thres);
subplot(2,2,4);
imshow(img4);
hold on;
for i =1 : length(r)
draw_bb(img1,r(i),c(i),0.4/length(r))
end
title('found in picture 3');





















