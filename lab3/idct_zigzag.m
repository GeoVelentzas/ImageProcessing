function [SNR_Dz, CR_Dz] = idct_zigzag(Z_Y, Z_Cb, Z_Cr, I)
bits_Iz_Y = size(find(Z_Y),1)*8;                
bits_Iz_Cb = size(find(Z_Cb),1)*8;              
bits_Iz_Cr = size(find(Z_Cr),1)*8;              
bits_Iz = bits_Iz_Y + bits_Iz_Cb + bits_Iz_Cr;  


bits_I_R = size(I,1)*size(I,2)*8;           
bits_I = 3 * bits_I_R;                      

iz_Y  = abs(blkproc(Z_Y, [8 8],'idct2'));
iz_Cb = abs(blkproc(Z_Cb,[8 8],'idct2'));
iz_Cr = abs(blkproc(Z_Cr,[8 8],'idct2'));

iz_YCbCr(:,:,1) = iz_Y;
iz_YCbCr(:,:,2) = iz_Cb;
iz_YCbCr(:,:,3) = iz_Cr;

Iz = ycbcr2rgb(iz_YCbCr);

SNR_Dz = snr(I,I-Iz);

CR_Dz = bits_I/bits_Iz;

end













