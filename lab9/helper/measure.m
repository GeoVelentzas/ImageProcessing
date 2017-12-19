function [p, r] = measure(query, result, window)

% measure precision p and recall r for given query, result and window length

if(nargin < 3), w = length(result); end
window = prod(window(:));

p = NaN;
r = NaN;
ap = NaN;

% get folder of query image
slash = strfind(query, '/');
folder = query(1:slash(end)-1);

% relevant results are images in the same folder with query
x = zeros(size(result));
for i=1:length(result)
	x(i) = ~isempty(strfind(result(i).name, folder));
end

% measurements
total = sum(x);
correct = sum(x(1:window));
p = correct / window;
r = correct / total;