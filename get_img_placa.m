function [feat_y, feat_r] = get_img_placa()
%a = dir('*.png');
%n = numel(a);

feat_y = [];
feat_r = [];

for i = 1:11
    filename = ['not ' sprintf('(%1d).jpg', i)];
    img = imread(filename);
    
    if (exist(filename, 'file') == 2)
        [feat_y1, feat_r1] = detc_img(img,1,1);
        feat_y(:,((size(feat_y,2))+1):(size(feat_y,2))+(size(feat_y1,2))) = feat_y1;
        feat_r(:,((size(feat_r,2))+1):(size(feat_r,2))+(size(feat_r1,2))) = feat_r1;
    end    
end

feat_y = (feat_y-mean2(feat_y))/std2(feat_y);
feat_r = (feat_r-mean2(feat_r))/std2(feat_r);
end