% initialization
close all;  clear;

addpath(genpath('./'));
% motion vector parameters
b = [8 8]; % block size
d = [4 4]; % max displacement

bx = b(1); by = b(2);
dx = d(1); dy = d(2);

% show figures or not
fig = 1; 

% root folder and filenames for frames in sequence
root = './data/';
seq = 'coast'; frame = 30; frames = 10:60;
file_pat = [root seq '/' seq '_%03d.gif']; 

figure(1);
% main loop over frames
for f = frames, disp(f)

	I = indread(sprintf(file_pat, f));
	J = indread(sprintf(file_pat, f+1));

    subplot(2,3,1);
	imshow(I), title('frame n');
	subplot(2,3,2);
    imshow(J), title('frame n+1');

	% sizes
	[ny, nx, c] = size(I);
	nby = ny / by;
	nbx = nx / bx;

	% zero padding
	Z = zeros(ny+2*dy, nx+2*dx, c);
	Z((1:ny)+dy, (1:nx)+dx, :) = I;

	% motion estimation
	[vx, vy] = bmatch(Z, J, b, d);
    subplot(2,3,4);
    quiver(1:nbx, nby:-1:1, vx, vy), title('flow');
    xlim([0 20]); ylim([0 20]);

	% motion vector filtering
	f_vx = medfilt2(vx);
	f_vy = medfilt2(vy);
	subplot(2,3,5);
    quiver(1:nbx, nby:-1:1, f_vx, f_vy), title('filtered flow');
    xlim([0 20]); ylim([0 20]);

	% main mobile object
	obj = f_vx < -1; % for coast

	% expand image and get binary mask of mobile object 
	m = expand(obj, b);
	subplot(2,3,6);
    imshow(m); title('thresholded');
    
    drawnow;
end



















