function [idx, c] = km(X, k)

% shortcut to kmeans clustering with appropriate options

warning off
[idx, c] = kmeans(X, k, 'start', 'uniform', 'emptyaction', 'singleton', 'onlinephase', 'off', 'options', statset('MaxIter', 30));
warning on