## Image encoding with fft in a full image vs block-wise fft
2D fft will be applied to a single image. The center of symmetry of the spectrum will be then translated to the center of the image and by using a mask the less important frequencies from all the channels will be discarded by keeping only the fft coefficients inside a disk of radius rxmin(M,N)/2, where M,N are the number of rows and columns of the image. The original image will be then reconstructed with an inverse fft and the signal to noise ratio will be computed. 

We then compare the differences of the snr after endoding and encoding, using the above method to a full image and by using a non-overlaping block-wise method.
