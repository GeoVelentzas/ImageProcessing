close all;clear all; clc;

addpath(genpath('./'));

I1 = imread('building.jpg');
I2 = imread('house2.jpg');
points1 = harris_laplace(I1);
points2 = harris_laplace(I2);
figure(1);
subplot(1,2,1);
draw_points(I1, points1, 'Harris');
subplot(1,2,2);
draw_points(I2, points2, 'Harris');
