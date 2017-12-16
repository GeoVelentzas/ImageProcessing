close all; clear all; clc;

addpath(genpath('./'))

I = im2double(imread('house.tif')); 


SNR_0 = zeros(1,20);                
SNR_G = zeros(1,20);                
SNR_S = zeros(1,20);                

i = 0;
for s = 0.01:0.1:2                  
     i=i+1;
    [SNR_0(i) ,SNR_G(i), SNR_S(i)]=denoise(I,s);
end

figure; hold on; box on;
plot(SNR_0,SNR_0,'LineWidth',2);
plot(SNR_0,SNR_G,'r','LineWidth',2);
plot(SNR_0,SNR_S,'k','LineWidth',2);
legend('SNR 0','SNR G','SNR S',2);
xlabel('SNR 0');

figure; hold on; box on
plot(0.01:0.1:2,SNR_0(1:i),'LineWidth',2);
plot(0.01:0.1:2,SNR_G(1:i),'r','LineWidth',2);
plot(0.01:0.1:2,SNR_S(1:i),'k','LineWidth',2);
legend('SNR 0','SNR G','SNR S',1);












