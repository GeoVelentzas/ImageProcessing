clear all; clc;

addpath(genpath('./'));

root = './data/';

query = [root 'sunset/p1.jpg'];
list = lsr(root, '.jpg$');
win = [3 4];
W = 10;

dist = zeros(1,length(list));

desc_func = 'scd';

dist_func = [desc_func '_dist'];

I1 = im2double(imread(query));

D1 = feval(desc_func,I1);

% loop over database images
for i=1:length(list)
    
% read database image & extract descriptor
I2 = im2double(imread(list(i).name));
D2 = feval(desc_func,I2);

% evaluate distance to query image, store in distance vector
dist(i) = feval(dist_func,D1,D2);

end

% sort list according to distance: [,]=sort(..)
[dist,IW] = sort(dist);
result = list(IW);

% keep first W elements for given window
dist = dist(1:W);
result = result(1:W);

[result, dist] = search(query, list, 100, 'scd');

disp_result(result, dist, win);

[p, r] = measure(query, result, win);

