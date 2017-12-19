function dist = dcd_dist(D1, D2, method)

% Distance between two dominant color descriptors (DCD) d1 & d2

% EMD distance or not?
use_emd = 0;

% distance thresholds
T = 20; a = 2; % (for LUV)

% number of dominant colors
n1 = size(D1, 1);
n2 = size(D2, 1);

% first 3 columns contain the dominant colors
col1 = D1(:, 1:3);
col2 = D2(:, 1:3);

% last column gives the area percentages
p1 = D1(:, 4)';
p2 = D2(:, 4)';

if(use_emd),

	% ground distance matrix
	% ...

	% earth mover distance
	% ...

else 

	% all combinations of dominant colors in two descriptors
	s = 0;
	for i1 = 1:n1, for i2 = 1:n2
			d12 = norm(col1(i1, :) - col2(i2, :));
			if(d12 <= T), a12 = 1 - d12 / (a*T); else a12 = 0; end
			s = s + a12 * p1(i1) * p2(i2);
	end, end

	% dominant color distance
	dist = sqrt(max(0, norm(p1)^2 + norm(p2)^2 - 2 * s));

end
