function [Z_Y,Z_Cb,Z_Cr] = dct_block(I,k_Y,k_C)

RGB = im2double(I);                         
YCbCr= (rgb2ycbcr(RGB));                    
Y=YCbCr(:,:,1);                             
Cb=YCbCr(:,:,2);                            
Cr=YCbCr(:,:,3);                            

Db_Y = blkproc(Y, [8 8], 'dct2');           
Db_Cb = blkproc(Cb, [8 8], 'dct2');         
Db_Cr = blkproc(Cr, [8 8], 'dct2');         

Z_Y = blkproc(Db_Y, [8 8], 'zigzag', k_Y); 
Z_Cb= blkproc(Db_Cb, [8 8], 'zigzag', k_C); 
Z_Cr= blkproc(Db_Cr, [8 8], 'zigzag', k_C); 

end

