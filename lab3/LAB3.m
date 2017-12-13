%�������� ��� ��������� ����
close all; clear all; clc;

%��� 2009b ��������� warning ��� � blkproc �� ����������!!
warning off all; 

%�������� ������� ��� ��������� �� double (�� ���������� ������������ �����
%����� �������� ����� �� ����������� �������� � im2double)
I = im2double(imread('flowers.tif'));

%������� ��������������
h = waitbar(0,'Please wait...');            %�������� ������ ��������
steps = 20;                                 %������ ������� ����������                        
SNR = zeros(1,19);                          %������������ ������ SNR
CR = zeros(1,19);                           %������������ ������ CR
lamda = zeros(1,19);                        %������������ ������ �

%������������ ���������� ����������� SNR,CR ��� � ���� ��� �����������
for i = 2:steps;                            %��� ��� �� ������       
    waitbar((i-1)/steps)                    %�������� ������ ��������
    k_Y = i;                                %�� k_Y 
    k_C = i/2;                              %to k_C=k_Y/2
    [Z_Y,Z_Cb,Z_Cr] = dct_block(I,i,i/2);   %����� dct_block
    [SNR_Z(i-1), CR_Z(i-1)] = ...           %����� idct_zigzag
        idct_zigzag(Z_Y, Z_Cb, Z_Cr, I);
    lamda_Z(i-1) = 1/CR_Z(i-1);             %�=1/CR
    
    %����������� ������ q �� ��� �������� ��� i ��� �� ����� �������
    %f(x)-f(x0) = � (x-x0) ��� 
    %q(i)-q(2) = [(q(20)-q(2))/(20-2)]*(i-2) , �� q(1)=0.2 ��� q(20)=16
    q = ((16-0.2)/(20-2))*i + 0.2 - ((16-0.2)/(20-2))*2;
    
    [Q_Y,Q_Cb,Q_Cr] = dct_quant(I,q);       %����� dct_quant       
    [SNR_Q(i-1), CR_Q(i-1)] = ...           %����� idct_quant
        idct_quant(Q_Y, Q_Cb, Q_Cr, I, q);
    lamda_Q(i-1) = 1/CR_Q(i-1);             %�=1/CR 
    
end
close(h)                                    %������ �������� ��������

% �� ��������� plots
figure; hold on; box on;
plot(lamda_Z,SNR_Z,'LineWidth',2);
plot(lamda_Q,SNR_Q,'r','LineWidth',2); 
xlabel('�');
legend('SNR_Z(�_z)','SNR_Q(�_Q)',4);

%Uncomment ��� ����������� ����������!
%���� ����� ����������� ��� ��� ����������� ����� ������������ �� SNR ���
%�� � �� ��������� ��� k_Y ��� Q ,������ ��������� ������� ������������
figure;
subplot(2,1,1); 
plot(2:20,SNR_Z);
title('������� zig-zag');
xlabel('k _ Y');
legend('SNR');
subplot(2,1,2);
plot(2:20,lamda_Z,'r');
xlabel('k _ Y');
legend('�')
figure;
subplot(2,1,1); 
plot(linspace(0.2,16,length(SNR_Q)),SNR_Q);
title('������� quantization');
xlabel('q');
legend('SNR');
subplot(2,1,2);
plot(linspace(0.2,16,length(lamda_Q)),lamda_Q,'r');
xlabel('q');
legend('�');












