function [C] = rotacao(img, theta)

%calculating array dimesions such that  rotated image gets fit in it exactly.
% we are using absolute so that we get  positve value in any case ie.,any quadrant.
[m,n,z]= size(img);

%rowsf=ceil(rowsi*abs(cosd(theta))+colsi*abs(sind(theta)));
%colsf=ceil(rowsi*abs(sind(theta))+colsi*abs(cosd(theta)));

% define an array withcalculated dimensionsand fill the array  with zeros ie.,black
C=uint8(zeros([m n z]));

%calculating center of original and final image
xo=ceil(m/2);
yo=ceil(n/2);

midx=xo; %=ceil((size(C,1))/2);
midy=yo; %=ceil((size(C,2))/2);

% in this loop we calculate corresponding coordinates of pixel of A
% for each pixel of C, and its intensity will be  assigned after checking
% weather it lie in the bound of A (original image)
for i=1:m
    for j=1:n
        
        x= (i-midx)*cosd(theta)+(j-midy)*sind(theta);
        y= -(i-midx)*sind(theta)+(j-midy)*cosd(theta);
        x=round(x)+xo;
        y=round(y)+yo;
        
        if (x>=1 && y>=1 && x<=m &&  y<=n)
            C(i,j,:)=img(x,y,:);
        end
        
    end
end
end