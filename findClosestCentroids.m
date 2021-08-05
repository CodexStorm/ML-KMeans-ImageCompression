function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

idx = zeros(size(X,1), 1);



for i = 1 : size(X,1)
    check = zeros(size(centroids,1), 1);
    for j = 1 : size(centroids,1)
        x_temp = X(i,:);
        c_temp = centroids(j,:);
        d_temp = x_temp-c_temp;
        check(j) = sum(d_temp.^2);
    end
    [M,idx(i)] = min(check);
end



end

