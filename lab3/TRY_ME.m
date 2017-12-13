clear all; close all; clc;
warning off all;
I = imread('flowers.tif');

k_Y = 64;
k_C = 64;
q = 0.00001;


RGB = im2double(I);                            
YCbCr= (rgb2ycbcr(RGB));                       
Y=YCbCr(:,:,1);                                
Cb=YCbCr(:,:,2);                                
Cr=YCbCr(:,:,3);                               

Db_Y  = blkproc(Y,  [8 8], 'dct2');             
Db_Cb = blkproc(Cb, [8 8], 'dct2');             
Db_Cr = blkproc(Cr, [8 8], 'dct2');            

Z_Y = blkproc(Db_Y,  [8 8], 'zigzag', k_Y);     
Z_Cb= blkproc(Db_Cb, [8 8], 'zigzag', k_C);    
Z_Cr= blkproc(Db_Cr, [8 8], 'zigzag', k_C);   

Q_Y = blkproc(255*Db_Y, [8 8],'quant_Y', q);    
Q_Cb= blkproc(255*Db_Cb,[8 8],'quant_C', q);   
Q_Cr= blkproc(255*Db_Cr,[8 8],'quant_C', q);   

iz_Y =  (blkproc(Z_Y, [8 8],'idct2'));
iz_Cb = (blkproc(Z_Cb,[8 8],'idct2'));
iz_Cr = (blkproc(Z_Cr,[8 8],'idct2'));

Q_Y  = blkproc(Q_Y, [8 8],'i_quant_Y',q);
Q_Cb = blkproc(Q_Cb,[8 8],'i_quant_C',q);
Q_Cr = blkproc(Q_Cr,[8 8],'i_quant_C',q);

iq_Y  = (blkproc(Q_Y, [8 8],'idct2'));
iq_Cb = (blkproc(Q_Cb,[8 8],'idct2'));
iq_Cr = (blkproc(Q_Cr,[8 8],'idct2'));


iz_YCbCr(:,:,1) = iz_Y;
iz_YCbCr(:,:,2) = iz_Cb;
iz_YCbCr(:,:,3) = iz_Cr;
Iz = ycbcr2rgb(iz_YCbCr);

iq_YCbCr(:,:,1) = iq_Y;
iq_YCbCr(:,:,2) = iq_Cb;
iq_YCbCr(:,:,3) = iq_Cr;
Iq = ycbcr2rgb(iq_YCbCr/255);   

SNR_Dz = snr(RGB,Iz-RGB);
SNR_Dq = snr(RGB,Iq-RGB);

figure; imshow(I);
figure; imshow(Iz);
figure; imshow(Iq);

bits_Iz_Y = size(find(Z_Y),1)*8;
bits_Iz_Cb = size(find(Z_Cb),1)*8;
bits_Iz_Cr = size(find(Z_Cr),1)*8;
bits_Iz = bits_Iz_Y + bits_Iz_Cb + bits_Iz_Cr;

bits_Iq_Y  = size(find(Q_Y),1)*8;
bits_Iq_Cb = size(find(Q_Cb),1)*8;
bits_Iq_Cr = size(find(Q_Cr),1)*8;
bits_Iq = bits_Iq_Y + bits_Iq_Cb + bits_Iq_Cr;

bits_I_R = size(I,1)*size(I,2)*8;
bits_I_G = size(I,1)*size(I,2)*8;
bits_I_B = size(I,1)*size(I,2)*8;
bits_I = bits_I_R + bits_I_G +bits_I_B;

CR_Dq = bits_I/bits_Iq;
CR_Dz = bits_I/bits_Iz;






