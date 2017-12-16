function points = harris_laplace( I )
% P = harris_laplace(I) returns the Harris-Laplace corners of grayscale image I.
% P is an Nx3 matrix where N is the number of corners extracted.

I = im2double(I); if(ndims(I) == 3), I = rgb2gray(I); end
s_n = 12; s_step = 1.2; s_array = s_step .^ (1:s_n);

harris_pts = harris_multi(I, s_step, s_n);
disp('Laplace')
lap = laplace(I, s_step, s_n);



% keep points where laplacian attains a local maximum over scale
points = zeros(0, 3);
for i = 1:size(harris_pts, 1)                       %Για κάθε σημείο βρές 
    x=harris_pts(i,1);                              %τις συντεταγμένες του x,y
    y=harris_pts(i,2);                              %στην εικόνα και την
    s=harris_pts(i,3);                              %κλίμακά του s 
    if s==1                                         %Αν η κλίμακα είναι η 1 τότε
        if lap(x,y,s)>lap(x,y,s+1)                  %έλεγξε αν η λαπλασιανή του είναι
        points = [points ; harris_pts(i,:)];        %μεγαλύτερη απο την επόμενη κλίμακα
        end                                         %και αν ναι τοτε βαλτο στον πινακα με τα σημεία ακμών
    elseif s==s_n                                   %Αν η κλίμακα είναι η τελευταία 
        if lap(x,y,s)>lap(x,y,s-1)                  %έλεγξε με την προτελευταία
        points = [points ; harris_pts(i,:)];        %και κάνε το ίδιο    
        end                                         %Αλλιώς έλεγξε με την προηγούμενη και την επόμενη
    elseif (lap(x,y,s)>lap(x,y,s-1))&&(lap(x,y,s)>lap(x,y,s+1))
        points = [points ; harris_pts(i,:)];        %και αν είναι βαλ'το στον points
    end                                             %Έτσι ο points θα έχει τα σημεία harris_pts
end                                                 %που η λαπλασιανή τους παρουσιάζει τοπικό μέγιστο





% Set scale to 3*sigma for display
points(:,3) = 3 * s_array(points(:,3));



end