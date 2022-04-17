function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points
centroid1 = mean(x1,1);
centroid2 = mean(x2,1);

%% Shift the origin of the points to the centroid
x1 = x1 - centroid1;
x2 = x2 - centroid2;
%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
d1 = mean(sqrt(x1(1,:).^2 + x1(2,:).^2));
d2 = mean(sqrt(x2(1,:).^2 + x2(2,:).^2));
%% dividing with mean 
x1 = rdivide(x1, d1);
x2 = rdivide(x2, d2);
%% similarity transform 1
T1 =  [1/d1 0 -centroid1(1)/d1;
      0 1/d1, -centroid1(2)/d1;
      0 0 1];

%% similarity transform 2
T2 =  [1/d2 0 -centroid2(1)/d2;
      0 1/d2, -centroid2(2)/d2;
      0 0 1];


%% Compute Homography

H = computeH(x1, x2);
%% Denormalization
H2to1 = (T1\H)*T2;
