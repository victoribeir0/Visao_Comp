function saida = colorize2(img1,img2)

img1_lab = rgb2xyz_c(img1); % RGB -> XYZ.
img1_lab = xyz2lab_c(img1_lab); % XYZ -> LAB.

img2_lab = rgb2xyz_c(img2); % RGB -> XYZ.
img2_lab = xyz2lab_c(img2_lab); % XYZ -> LAB.

int = 30;
for i = 1:int:256
   img1(img1>=i & img1<=i+(int-1)) = i; 
end


end