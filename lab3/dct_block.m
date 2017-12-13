function [Z_Y,Z_Cb,Z_Cr] = dct_block(I,k_Y,k_C)
%� ��������� ���� ������� ��� ������ ��� ������ I ��� ��� ����� k_Y,K_C.
%������������� ��� 8x8 blockwise DCT �������������� ��� ��� ��� ��������
%������� ��� k_Y �� ������ ���������� ��� �� Y ������ ��� ��� k_C �� ������
%��� �� Cb ��� Cr ������ �� �� ������ zigzag.

RGB = im2double(I);                         % ��������� ��� ����������
YCbCr= (rgb2ycbcr(RGB));                    % RGB �� YCbCr
Y=YCbCr(:,:,1);                             % Y ������
Cb=YCbCr(:,:,2);                            % Cb ������
Cr=YCbCr(:,:,3);                            % Cr ������

Db_Y = blkproc(Y, [8 8], 'dct2');           % 8x8 blockwise DCT2 ��� �
Db_Cb = blkproc(Cb, [8 8], 'dct2');         % 8x8 blockwise DCT2 ��� Cb
Db_Cr = blkproc(Cr, [8 8], 'dct2');         % 8x8 blockwise DCT2 ��� Cr

Z_Y = blkproc(Db_Y, [8 8], 'zigzag', k_Y);  % ������� ���� k_Y ����������
Z_Cb= blkproc(Db_Cb, [8 8], 'zigzag', k_C); % ������� ���� k_C ����������
Z_Cr= blkproc(Db_Cr, [8 8], 'zigzag', k_C); % ������� ���� k_C ����������

end

