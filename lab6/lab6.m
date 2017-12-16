clear all; close all; clc;

addpath(genpath('./'));

img1 = imread('eiffel_00.jpg');
p1 = harris(img1);
img2 = imread('eiffel_00.jpg');
p2 = harris(img2);

%���������� binsize ��� threshold
binsize = 3;
thres = 0.9;

%����� ���������� hough2 ��� ����������� r, c, A, A_t
[r, c, A, A_t]= hough2d(img1, p1, img2, p2, binsize, thres);

%�������� ������������� ���� ������ �� ��������� opac ������� �� �� ������
%��� ����������� ��� ����� ������� � ������.
imshow(img2);
hold on;
for i =1 : length(r)
draw_bb(img1,r(i),c(i),0.4/length(r))
end