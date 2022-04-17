
function [bestH2to1, inliers, bestPts] = computeH_ransac( locs1, locs2)

n = 1000;
count = 0;
mostPoints = -1;
h = [];

one = [locs2, ones(size(locs2,1),1)];

for i = 1:n
    %% selecting 4 random points
 
    randomPts = datasample([1:size(locs1)], 4, 'Replace',false); 
    %% creating homography
    H = computeH_norm(locs1(randomPts,:),locs2(randomPts,:));  
    %% creating predictions    
    m = H*one';
    m = rdivide(m, m(3, :));
    m = transpose(m);
    %% calculating error distance between the actual vs predicted values
    most = sqrt((locs1(:, 1) - m(:, 1)).^2 + (locs1(:, 2) - m(:,2)).^2);
    %% boolean array on accepted vs rejected points
   	count = most < 0.5;
    %% summing all the accepted points
    count = sum(count); 
    %% saving the best hypothesis (one with most points satisfied)
    if(count > mostPoints) 
        bestPts = randomPts
        inliers = most;
        mostPoints = count;
        h = H;            
    end    
end
bestH2to1 = h;
end


    