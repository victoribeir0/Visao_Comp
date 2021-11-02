function [ci, li] = detectimg(img,r)

if nargin < 1
    img = imread('img (1).jpg');
end

[m,n,~] = size(img);

if nargin < 1
    if m > 500 || n > 500
        r = 2;
    else
        r = 1;
    end
end

[a,~,ci,li] = detects(img,r);

% imshow(label2rgb(L, @jet, [.5 .5 .5])); hold on;
% for k = 1:length(B)
%    boundary = B{k};
%    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
% end

if length(ci) > 1 && length(li) > 1
    for i = 1:length(ci)
        a((li(i)*r),(ci(i)*r),3) = 200;
        a((li(i)*r)+1,(ci(i)*r),3) = 200;
        a((li(i)*r),(ci(i)*r)+1,3) = 200;
        a((li(i)*r)+1,(ci(i)*r)+1,3) = 200;
        
        a((li(i)*r),(ci(i)*r),1) = 255;
        a((li(i)*r)+1,(ci(i)*r),1) = 255;
        a((li(i)*r),(ci(i)*r)+1,1) = 255;
        a((li(i)*r)+1,(ci(i)*r)+1,1) = 255;
    end
end

imshow(a);

% imshow(a); hold on;
% plot([min(ci)*r min(ci)*r],[min(li)*r max(li)*r],'r','Linewidth',2); hold on;
% plot([max(ci)*r max(ci)*r],[min(li)*r max(li)*r],'r','Linewidth',2); hold on;
% plot([min(ci)*r max(ci)*r],[min(li)*r min(li)*r],'r','Linewidth',2); hold on;
% plot([min(ci)*r max(ci)*r],[max(li)*r max(li)*r],'r','Linewidth',2);
% hold off

end