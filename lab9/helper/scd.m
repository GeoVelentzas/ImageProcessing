function D = scd(I, level)

% simplified scalable color descriptor of image I, at a given scale level, 1 to 5

if(nargin < 2 | isempty(level)), level = 2; end
level = max(min(level, 5), 1);

% no. of bins per channel, according to level
bins_mat = [  4  2  2;
              8  2  2;
	      8  2  4;
	      8  4  4;
	     16  4  4 ];

bins_H = bins_mat(level, 1);
bins_S = bins_mat(level, 2);
bins_V = bins_mat(level, 3);

% color space conversion & channels
I = rgb2hsv(I);
H = I(:,:,1);
S = I(:,:,2);
V = I(:,:,3);

% quantization per channel
Q_H = min(floor(H * bins_H), bins_H-1) + 1;
Q_S = min(floor(S * bins_S), bins_S-1) + 1;
Q_V = min(floor(V * bins_V), bins_V-1) + 1;

% histogram construction
D = zeros(bins_H, bins_S, bins_V);
for i_H = 1:bins_H
	L_H = (Q_H == i_H);
	for i_S = 1:bins_S
		L_S = L_H & (Q_S == i_S);
		for i_V = 1:bins_V
			L_V = L_S & (Q_V == i_V);
			D(i_H, i_S, i_V) = sum(L_V(:));
		end
	end
end

% normalization
D = D(:);
D = D / sum(D);