function snr = snr(S, N)

% signal to noise ratio
snr = 10 * log10(sum(sum(sum(S.^2))) / sum(sum(sum(N.^2))));
 