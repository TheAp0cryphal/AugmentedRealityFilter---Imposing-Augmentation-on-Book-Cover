function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
I1 = im2gray(I1);
I2 = im2gray(I2);
%% Detect features in both images
p1 = detectFASTFeatures(I1);
p2 = detectFASTFeatures(I2);
%p1 = detectSURFFeatures(I1);
%p2 = detectSURFFeatures(I2);
%% Obtain descriptors for the computed feature locations
[desc1, xlocs1] = computeBrief(I1, p1.Location);
[desc2, xlocs2] = computeBrief(I2, p2.Location);
%[desc1, xlocs1] = extractFeatures(I1, p1.Location);
%[desc2, xlocs2] = extractFeatures(I2, p2.Location);
%% Match features using the descriptors

featurePairs = matchFeatures(desc1, desc2, 'MatchThreshold', 10.0, 'MaxRatio', 0.665);
locs1 = xlocs1(featurePairs(:,1),:);
locs2 = xlocs2(featurePairs(:,2),:);


end

