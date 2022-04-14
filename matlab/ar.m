% Q3.3.1


vid1 = loadVid("../data/ar_source.mov");
vid2 = loadVid("../data/book.mov");
cv_img = imread('../data/cv_cover.jpg');
v = VideoWriter('../results/goodrun.mp4', 'MPEG-4');
open(v)

bar1 = size(frame2, 2);
bar2 = size(frame2, 1);

for i=1:size(vid1,2)
    %% pulling frames 
    frame1 = vid2(i).cdata;
    frame2 = vid1(i).cdata;
    %% matching feature locations to find the book
    [locs1, locs2] = matchPics(cv_img, frame1);
    %% computing homography
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);    
    %% for black bars
    bar1 = size(frame2, 2)
    bar2 = size(frame2, 1)
    
    crop = imcrop(frame2, [0 45 bar1 bar2 - 90]);
    
    scaled_img = imresize(crop, [size(cv_img,1) size(cv_img,2)]);
    %% superimposing frames on book
    vid1(i).cdata = compositeH(inv(bestH2to1), scaled_img, vid2(i).cdata);
    %% saving video
    imshow(vid1(i).cdata);
    writeVideo(v,vid1(i).cdata);
end
close(v)