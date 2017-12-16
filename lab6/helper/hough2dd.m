function [r, c, Acc, A_t] = hough2d(img1, p1, img2, p2, binsize, thres)

% 1)Calculate accumulator A size and create empty A 
[M1,N1]=size(img1);
[M2,N2]=size(img2);
Acc=zeros((M1+M2)/binsize,(N1+N2)/binsize); 

% 2)Initialize votes for object center from corner points
I=size(p1,1);
J=size(p2,1);

p1(:,1)=M1/2-p1(:,1);
p1(:,2)=N1/2-p1(:,2);


% 3)Accumulate votes in appropriate position
%Casting votes for center: (xj, yj) + (xc-xi, yc-yi) = (xj-xi+xc, yj-yi+yc)
for i=1:J 
  for j=1:I
    Acc(round((p2(i,1)-p1(j,1)+M1/2)/binsize),round((p2(i,2)-p1(j,2)+N1/2)/binsize))= Acc(round((p2(i,1)-p1(j,1)+M1/2)/binsize),round((p2(i,2)-p1(j,2)+N1/2)/binsize))+1;
  end
end


% 4)Apply threshold to A and store in A_t
T=max(max(Acc))*thres;
A_t = Acc .* (Acc > T);

% 5)Find local maxima of A_t
[r, c, value] = local_max(A_t);

% 6)Compute coordinates of local maxima in image domain
r=M1/2 - r;
c=N1/2 - c;

end

