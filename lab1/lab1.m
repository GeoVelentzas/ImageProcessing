clear all; close all; clc;

addpath(genpath('./'))

% *********** read original image and add salt&pepper noise ************* %
I=imread('board.tif');                  %read image
I=rgb2gray(I);                          %convert to grayscale
I=im2double(I);                         %convert to double
In=imnoise(I,'salt & pepper',0.15);     %add salt and pepper noise


% ********** filter with median and adaptive median ********************* %
Im=medfilt2(In,[5 5]);                  %filtered with median
Iam=adpmedian(In,7);                    %filtered with adaptive median


% *********** observe a window of the original image *********************%
I_win = I(200:250,10:60);               %chose a window
In_win = In(200:250,10:60);             %noised image window
Im_win = Im(200:250,10:60);             %window of filtered with median
Iam_win = Iam(200:250,10:60);           %window of filtered with adaptive


% **************** compute signal to noise ratio  ************************% 
snr_n = snr(I,In)                       %SNR of noised image
snr_m = snr(I,Im)                       %SNR of filtered with median
snr_am = snr(I,Iam)                     %SNR of filtered with adaptive


% ****************** visualization of results ****************************%
figure;
imshow(imresize(I_win,10,'nearest'));
title('\fontsize{16} Original Image ');

figure;
imshow(imresize(In_win,10,'nearest'));
title('\fontsize{16} Image with "salt & pepper" noise');
xlabel(['\fontsize{16} {\color{blue} SNR =',num2str(snr_n),'}']);

figure;
imshow(imresize(Im_win,10,'nearest'));
title('\fontsize{16} Image filtered with median');
xlabel(['\fontsize{16} {\color{blue} SNR =',num2str(snr_m),'}']);

figure;
imshow(imresize(Iam_win,10,'nearest'));
title('\fontsize{16} Image filtered with adaptive median');
xlabel(['\fontsize{16} {\color{blue} SNR =',num2str(snr_am),'}']);
