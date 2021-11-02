function [remap, img2] = iluremap(imref, img)
% Faz o remapeamento da ilumin�ncia da imagemA.

%imref = double(imref); img = double(img);

% Converte as imagens de RGB para LAB.
 imref = rgb2xyz_c(imref); % RGB -> XYZ.
 imref = xyz2lab_c(imref); % XYZ -> LAB.
%imref = rgb2lab(imref);

img2(:,:,1) = img; img2(:,:,2) = img; img2(:,:,3) = img;
%img2 = rgb2lab(img2);
  img2 = rgb2xyz_c(img2); % RGB -> XYZ.
  img2 = xyz2lab_c(img2); % XYZ -> LAB.

% Obt�m as ilumin�cias de A e B.
 iluA = imref(:,:,1);
 iluB = img2(:,:,1);

% Calcula a m�dia das ilumin�cias de A e B.
 mA = mean(iluA(:));
 mB = mean(iluB(:));

% Calcula o desvio padr�o das ilumin�cias de A e B.
 sdA = std(iluA(:));
 sdB = std(iluB(:));

% Faz o remapeamento da ilumin�ncia de A (Hertzmann, 2001). 
 iluA = (sdB/sdA) * (iluA - mA) + mB;

% Associa a nova ilumin�ncia � imagemA.
 remap = imref;
 remap(:,:,1) = iluA;

end