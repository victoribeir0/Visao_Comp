function [ci, li] = detectvid(vid,r)

if nargin < 1
    vid = VideoReader('vid5.mp4');
end

if nargin < 1
    r = 2;
end

%NFrames = vid.NumberOfFrames;
i = 0;
figure(1)
while hasFrame(vid)
    tic; vv = readFrame(vid); toc
    i = i+1;
    
    if mod(i,10) == 1
        imshow(vv); drawnow;
        [a,~,ci,li] = detects(vv,r);
        
        %     if length(ci) > 1 && length(li) > 1
        %         for k = 1:length(ci)
        %             a((li(k)*r),(ci(k)*r),3) = 200;
        %             a((li(k)*r)+1,(ci(k)*r),3) = 200;
        %             a((li(k)*r),(ci(k)*r)+1,3) = 200;
        %             a((li(k)*r)+1,(ci(k)*r)+1,3) = 200;
        %         end
        %     end
        
        if length(ci) > 1 && length(li) > 1
            imshow(a); hold on;
            plot([min(ci)*r min(ci)*r],[min(li)*r max(li)*r],'r','Linewidth',2); hold on;
            plot([max(ci)*r max(ci)*r],[min(li)*r max(li)*r],'r','Linewidth',2); hold on;
            plot([min(ci)*r max(ci)*r],[min(li)*r min(li)*r],'r','Linewidth',2); hold on;
            plot([min(ci)*r max(ci)*r],[max(li)*r max(li)*r],'r','Linewidth',2);
            hold off
            drawnow;
        end
    disp(i);    
    end    
end

end