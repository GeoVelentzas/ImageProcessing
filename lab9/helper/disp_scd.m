function disp_scd(D)

% display scalable color descriptor

% level
level = floor(log(length(D)/8) / log(2));

% no. of bins per channel, according to level
bins_mat = [  4  2  2;
              8  2  2;
	      8  2  4;
	      8  4  4;
	     16  4  4 ];

bins_H = bins_mat(level, 1);
bins_S = bins_mat(level, 2);
bins_V = bins_mat(level, 3);

% original 3-d historgam size
D = reshape(D, [bins_H bins_S bins_V]);

% rectangle coordinates
x = [0 1 1 0]';
y = [0 0 1 1]';

figure, axis([0 bins_H 0 bins_S * bins_V]), axis equal, axis off
patch(x * bins_H, y * bins_S * bins_V, [1 1 1])

for i_H = 1:bins_H
	val_H = (i_H-.5) / bins_H;
	for i_S = 1:bins_S
		val_S = (i_S-.5) / bins_S;
		for i_V = 1:bins_V
			val_V = (i_V-.5) / bins_V;
			a = D(i_H, i_S, i_V);
			rgb = hsv2rgb([val_H val_S val_V]);
			patch(x+(i_H-1), y+(i_S-1)+bins_S*(i_V-1), rgb*a + [1 1 1]*(1-a));
		end
	end
end

