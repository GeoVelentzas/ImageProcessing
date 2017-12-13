function [SNR_Dq, CR_Dq] = idct_quant(Q_Y, Q_Cb, Q_Cr, I, q)

bits_Iq_Y  = size(find(Q_Y),1)*8;           
bits_Iq_Cb = size(find(Q_Cb),1)*8;          
bits_Iq_Cr = size(find(Q_Cr),1)*8;         
bits_Iq = bits_Iq_Y+bits_Iq_Cb+bits_Iq_Cr;  

bits_I_R = size(I,1)*size(I,2)*8;           
bits_I = 3 * bits_I_R;                      

Q_Y  = blkproc(Q_Y, [8 8],'i_quant_Y',q);
Q_Cb = blkproc(Q_Cb,[8 8],'i_quant_C',q);
Q_Cr = blkproc(Q_Cr,[8 8],'i_quant_C',q);

iq_Y  = blkproc(Q_Y, [8 8],'idct2');
iq_Cb = blkproc(Q_Cb,[8 8],'idct2');
iq_Cr = blkproc(Q_Cr,[8 8],'idct2');

iq_YCbCr(:,:,1) = iq_Y;
iq_YCbCr(:,:,2) = iq_Cb;
iq_YCbCr(:,:,3) = iq_Cr;

Iq = ycbcr2rgb(iq_YCbCr/255);

SNR_Dq = snr(I,I-Iq);

CR_Dq = bits_I/bits_Iq;


end

