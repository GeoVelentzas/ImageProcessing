function J = freqfilt(I,h)
l=length(h)-1;
high = l/2 + 1;
low = l/2;
[M, N] = size(I);

F = fft2(I, M+l, N+l);
H = fft2(h, M+l, N+l);
J = abs(ifft2(F.*H)); 
J = J(high:end-low, high:end-low);

end

