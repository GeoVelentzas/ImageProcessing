function [d, points, R] = klt_feat(I, J, ws, points)

lamda_th = 0.001;  %Choose min eigenvalue

if (size(I) ~= size(J)), error('input images are not the same size'), end
[r, c] = size(I);
ws = max(3, ws);

% keep luminance value only
I = im2double(I); if(ndims(I) > 2), I = rgb2gray(I); end
J = im2double(J); if(ndims(J) > 2), J = rgb2gray(J); end

% derivative filters
fx = (1/2) * [-1 1; -1 1];
fy = fx';

% image derivatives
Ix = imfilter((I+J)/2, fx, 'replicate');
Iy = imfilter((I+J)/2, fy, 'replicate');

% frame difference (temporal derivative)
h  = imfilter(I - J, (1/4) * ones(2), 'replicate');

% Gaussian window for averaging
w = fspecial('gaussian', ws, round((ws-1)/2));

% components of matrix G
A = imfilter(Ix.^2, w, 'replicate', 'conv'); 
B = imfilter(Iy.^2, w, 'replicate', 'conv');
C = imfilter(Ix.*Iy, w, 'replicate', 'conv');

% components of vector e
ex = imfilter(Ix.*h, w, 'replicate', 'conv'); 
ey = imfilter(Iy.*h, w, 'replicate', 'conv'); 


% feature response: minimum eigenvalue of H
R = (1/2)*( (A+B) - ( (A-B).^2 + 4*(C.^2) ).^(1/2) ); 

% local maxima of R 
[trash1 , trash2 , mx] = local_max(R, 3); 

% new feature points, above threshold for min eigenvalue
[new_pt(:,1) new_pt(:,2)] = find(mx >lamda_th);

% combine new features with pre-existing ones
if (isempty(points) | (size(points,1) < 1) | isnan(points(:)))
% allocate new feature points
points = new_pt;
else
% remove new points that overlap previous ones
valid = zeros(1,size(new_pt,1));
for k = 1:size(new_pt,1)
p = ones(size(points,1),1) * new_pt(k,:);
valid(k) = min(max(abs(p - points)')) > ws;
end
% append non-overlapping new points to previous ones
new_pt(~valid, :) = [];
points = [points; new_pt];
end

% initialization of displacements
d = zeros(size(points));



for k = 1:size(points,1);
    
% point location
row = round(points(k,1)); col = round(points(k,2));

% remove invalid points: make them NaN
 if (row<=0)||(col<=0)||(row>size(I,1))||(col>size(I,2)); 
     points(k,:) = NaN;
 end
 
% check response again, remove points if belowthreshold: make them NaN
  if (~isnan(points(k,1)))&&(R(row,col)<=lamda_th/2); points(k,:) = NaN; end 
  
% solve linear system
if ~isnan(points(k,1))
H = [A(row,col) C(row,col); C(row,col) B(row,col)];
e = [ex(row,col) ey(row,col)]';
d(k,:) = (pinv(H) * e);
end

% swap dx with dy: coordinates given as (row,column)
d(k,:) = [d(k,2) d(k,1)];

end




