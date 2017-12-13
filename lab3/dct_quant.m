function [Q_Y,Q_Cb,Q_Cr] = dct_quant(I,q)
%Σ'αυτη τη συναρτηση υπολογιζονται οι πινακες κβαντισμου (Q_Y,Q_Cb,Q_Cr)απο
%τους πινακες blockwise DCT (Db_Y,Db_Cb,Db_Cb) κανοντας μια "επιλεκτική"
%κατωφλιοποίηση με βαση την παραμετρο q χρησιμοποιώντας τη συνάρτηση quant 

RGB = im2double(I);                             % μετατροπη για υπολογισμό
YCbCr= (rgb2ycbcr(RGB));                        % RGB σε YCbCr
Y  = YCbCr(:,:,1);                              % Y καναλι
Cb = YCbCr(:,:,2);                              % Cb καναλι
Cr = YCbCr(:,:,3);                              % Cr καναλι

% Ο πολλαπλασιασμος με 255 γινεται καθως στη συνεχεια η quant θελει τιμες
% του φασματος απο 0-255 ενω αλλιως θα ειχα απο 0-1 και θα μηδενιζονταν
% οι DCT πινακες. Αυτο ειναι kai to πρωτο bug που ειδαμε στο εργαστηριο!!!
Db_Y  = 255*blkproc(Y,  [8 8], 'dct2');         % 8x8 blockwise DCT2 του Υ
Db_Cb = 255*blkproc(Cb, [8 8], 'dct2');         % 8x8 blockwise DCT2 του Cb
Db_Cr = 255*blkproc(Cr, [8 8], 'dct2');         % 8x8 blockwise DCT2 του Cr

Q_Y = blkproc(Db_Y, [8 8],'quant_Y', q);        % Κβαντισμος(βλεπε quant_Y)
Q_Cb= blkproc(Db_Cb,[8 8],'quant_C', q);        % Κβαντισμος(βλεπε quant_C)
Q_Cr= blkproc(Db_Cr,[8 8],'quant_C', q);        % Κβαντισμος(βλεπε quant_C)

end

