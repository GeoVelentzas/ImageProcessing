## Image encoding with fft in a full image vs block-wise fft
2D fft will be applied to a single image. The center of symmetry of the spectrum will be then translated to the center of the image. The "less important" higher frequencies from all the channels will be then discarded by keeping only the fft coefficients inside a disk. The original image will be then reconstructed with an inverse fft and the signal to noise ratio will be computed. 

We then compare the differences of the snr after endoding and encoding, using the above method to a full image and by using a non-overlaping block-wise method.
