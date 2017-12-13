function [Q_Y,Q_Cb,Q_Cr] = dct_quant(I,q)
%�'���� �� ��������� ������������� �� ������� ���������� (Q_Y,Q_Cb,Q_Cr)���
%���� ������� blockwise DCT (Db_Y,Db_Cb,Db_Cb) �������� ��� "����������"
%�������������� �� ���� ��� ��������� q ��������������� �� ��������� quant 

RGB = im2double(I);                             % ��������� ��� ����������
YCbCr= (rgb2ycbcr(RGB));                        % RGB �� YCbCr
Y  = YCbCr(:,:,1);                              % Y ������
Cb = YCbCr(:,:,2);                              % Cb ������
Cr = YCbCr(:,:,3);                              % Cr ������

% � ��������������� �� 255 ������� ����� ��� �������� � quant ����� �����
% ��� �������� ��� 0-255 ��� ������ �� ���� ��� 0-1 ��� �� ������������
% �� DCT �������. ���� ����� kai to ����� bug ��� ������ ��� ����������!!!
Db_Y  = 255*blkproc(Y,  [8 8], 'dct2');         % 8x8 blockwise DCT2 ��� �
Db_Cb = 255*blkproc(Cb, [8 8], 'dct2');         % 8x8 blockwise DCT2 ��� Cb
Db_Cr = 255*blkproc(Cr, [8 8], 'dct2');         % 8x8 blockwise DCT2 ��� Cr

Q_Y = blkproc(Db_Y, [8 8],'quant_Y', q);        % ����������(����� quant_Y)
Q_Cb= blkproc(Db_Cb,[8 8],'quant_C', q);        % ����������(����� quant_C)
Q_Cr= blkproc(Db_Cr,[8 8],'quant_C', q);        % ����������(����� quant_C)

end

