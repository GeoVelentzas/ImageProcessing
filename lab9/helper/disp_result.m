function disp_result(result, dist, window)

% display image search result (file name list) in a suplot of dimensions given in window
% distances dist are shown below image thumbnails

% get folder of query image
query = result(1).name;
slash = strfind(query, '/');
folder = query(1:slash(end)-1);

figure, k = 0;
for i = 1:window(1)
	for j = 1:window(2)
		k = k + 1;
		if(k > length(result)), return, end
		subplot(window(1), window(2), k)
		I = imread(result(k).name);
		% relevant results are images in the same folder with query
		relevant = ~isempty(strfind(result(k).name, folder));
		if(relevant), color = 'k'; else color = 'r'; end
		imshow(I), xlabel(dist(k), 'Color', color)
	end
end
