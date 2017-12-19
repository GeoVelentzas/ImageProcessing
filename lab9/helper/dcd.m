function [D, idx] = dcd(I, ncol, scale)

% simplified dominant color descriptor of image I, generating ncol (up to 8) dominant colors
% d is a ncol x 4 matrix. each row corresponds to a dominant color, the first 3 columns contain
% their color components and the last column their area percentage in the image.

if(nargin < 2 | isempty(ncol)), ncol = 3; end
if(nargin < 3 | isempty(scale)), scale = .5; end

% downsample image to speed up
I = imresize(I, scale);

% color space conversion & channels
I = colorspace('rgb->luv', I);
L = I(:,:,1);
U = I(:,:,2);
V = I(:,:,3);

% data clustering & dominant colors
X = [L(:) U(:) V(:)];
[idx, col] = km(X, ncol);

% color area percentages
percent = zeros(ncol, 1);
for i = 1:ncol
	percent(i) = sum(idx == i);
end
percent = percent / length(idx);

% descriptor construction (concatenate dom. colors + percentages)
D = [col percent];

% pixel indices
idx = reshape(idx, size(L));

