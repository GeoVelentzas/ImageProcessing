function [Q_Y,Q_Cb,Q_Cr] = dct_quant(I,q)

RGB = im2double(I);                             
YCbCr= (rgb2ycbcr(RGB));                        
Y  = YCbCr(:,:,1);                              
Cb = YCbCr(:,:,2);                              
Cr = YCbCr(:,:,3);                              

Db_Y  = 255*blkproc(Y,  [8 8], 'dct2');        
Db_Cb = 255*blkproc(Cb, [8 8], 'dct2');        
Db_Cr = 255*blkproc(Cr, [8 8], 'dct2');         

Q_Y = blkproc(Db_Y, [8 8],'quant_Y', q);        
Q_Cb= blkproc(Db_Cb,[8 8],'quant_C', q);        
Q_Cr= blkproc(Db_Cr,[8 8],'quant_C', q);        

end

