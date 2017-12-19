function [result, dist] = search(query, list, W, desc_func)
    if(nargin < 3 | isempty(W) | ~W), W = inf; end
    if(nargin < 4), desc_func = 'scd'; end
    if(nargin < 5), param = []; end
    
    % initialize distance vector (list length)
    dist = zeros(1,length(list));
    
    % distance function corresponding to given descriptor function
    dist_func = [desc_func '_dist'];
    
    % process query image
    I1 = im2double(imread(query));
    
    % extract its descriptor (using feval and desc_func)
    D1 = feval(desc_func,I1);
    
    % loop over database images
    for i=1:length(dist)
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
    w = min(W,length(list));
    dist = dist(1:w);
    result = result(1:w);
    
end





