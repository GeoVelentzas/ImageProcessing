function dist = scd_dist(D1, D2)

% Distance between two scalable color descriptors (SCD) d1 & d2
% Computed as L1 distance between the two vectors

dist = norm(D1(:) - D2(:), 1);