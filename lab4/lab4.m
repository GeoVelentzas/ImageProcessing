close all; clear all; clc;

addpath(genpath('./'))

I = im2double(imread('building.tif'));

[E,Z,M] = gdlog(I,3);

subplot(2,2,1);
imshow(I); title('Original Image');
subplot(2,2,2);
imshow(M,[]); title('Fitlered with DoG');
subplot(2,2,3);
imshow(Z,[]); title('Filgered with LoG');
subplot(2,2,4);
imshow(E,[]); title('Edges');    