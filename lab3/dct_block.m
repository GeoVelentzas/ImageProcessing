function [Z_Y,Z_Cb,Z_Cr] = dct_block(I,k_Y,k_C)
%Η συναρτηση αυτη δεχεται σαν ορισμα μια εικονα I και τις τιμες k_Y,K_C.
%Πραγματοποιει τον 8x8 blockwise DCT μετασχηματισμο της και στη στνεχεια
%κραταει τις k_Y το πληθος συνιστωσες απο το Y καναλι και τις k_C το πληθος
%απο το Cb και Cr καναλι με τη μεθοδο zigzag.

RGB = im2double(I);                         % μετατροπη για υπολογισμό
YCbCr= (rgb2ycbcr(RGB));                    % RGB σε YCbCr
Y=YCbCr(:,:,1);                             % Y καναλι
Cb=YCbCr(:,:,2);                            % Cb καναλι
Cr=YCbCr(:,:,3);                            % Cr καναλι

Db_Y = blkproc(Y, [8 8], 'dct2');           % 8x8 blockwise DCT2 του Υ
Db_Cb = blkproc(Cb, [8 8], 'dct2');         % 8x8 blockwise DCT2 του Cb
Db_Cr = blkproc(Cr, [8 8], 'dct2');         % 8x8 blockwise DCT2 του Cr

Z_Y = blkproc(Db_Y, [8 8], 'zigzag', k_Y);  % κρατημα μονο k_Y συνιστωσων
Z_Cb= blkproc(Db_Cb, [8 8], 'zigzag', k_C); % κρατημα μονο k_C συνιστωσων
Z_Cr= blkproc(Db_Cr, [8 8], 'zigzag', k_C); % κρατημα μονο k_C συνιστωσων

end

