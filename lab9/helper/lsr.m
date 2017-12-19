function list = lsr(root, reg)

% recursively list files in folder root (similar to ls -r)
% filters file names according to regular expression reg, if given

if(nargin < 1), root = '.'; end
if(nargin < 2), reg = 0; end

n = length(root);
if(root(n) == '/'), root = root(1:n-1); end
d = dir(root);
list = [];

% ignore first two items ('.' and '..')
for i=3:length(d)
	% make full path
	d(i).name = [root '/' d(i).name];
	if(d(i).isdir) 
		% recurse into folder
		list = [list; lsr(d(i).name, reg)];
	else
		% filter with regular expression
		if(reg & isempty(regexp(d(i).name, reg))), continue, end
		% add current file to list
		list = [list; d(i)];
	end
end
