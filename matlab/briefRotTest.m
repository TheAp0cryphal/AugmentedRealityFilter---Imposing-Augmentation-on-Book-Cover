% Your solution to Q2.1.5 goes here!
clear all
close all
%% Read the image and convert to grayscale, if necessary
I1 = imread('../data/cv_cover.jpg');
I1 = im2gray(I1)
%% Compute the features and descriptors
p1 = detectFASTFeatures(I1);
[p1, xlocs1] = computeBrief(I1, p1.Location);
counter = []
for i = 0:36
    %% Rotate image
    rotImage = imrotate(I1,(i)*10);
    %% Compute features and descriptors
    pRot = detectFASTFeatures(rotImage);
    [pRot, xlocs2] = computeBrief(rotImage, pRot.Location);
    %% Match features
    featurePairs = matchFeatures(p1, pRot, 'MatchThreshold', 10.0, 'MaxRatio', 0.668);
    locs2 = xlocs2(featurePairs(:,2),:);
    if  (i == 1 || i == 6 || i == 9)
        locs1 = xlocs1(featurePairs(:,1),:);
        figure()
        showMatchedFeatures(I1, rotImage, locs1, locs2, 'montage');
    end
    %% Update histogram
    counter = [counter, size(featurePairs(:,1),1)];
end
figure()
bar(counter)

%{
p1 = detectSURFFeatures(I1);
[p1, xlocs1] = extractFeatures(I1, p1.Location, 'Method', 'SURF');
counter = []
for i = 0:36
    %% Rotate image
    rotImage = imrotate(I1,(i)*10);
    %% Compute features and descriptors
    pRot = detectSURFFeatures(rotImage);
    [pRot, xlocs2] = extractFeatures(rotImage, pRot.Location, 'Method', 'SURF');
    %% Match features
    MaxRatio = 0.668
    if (i == 1 || i == 6 || i == 9) 
        MaxRatio = 0.2
    end
    featurePairs = matchFeatures(p1, pRot, 'MatchThreshold', 10.0, 'MaxRatio', MaxRatio);
    locs2 = xlocs2(featurePairs(:,2),:);
    locs1 = xlocs1(featurePairs(:,1),:);
    if (i == 1 || i == 6 || i == 9)    
        %figure()
       % showMatchedFeatures(I1, rotImage, locs1, locs2, 'montage');
    end
    %counter = [counter, size(featurePairs(:,1),1)];
end
x = figure()
bar(counter, 'r')
%}
