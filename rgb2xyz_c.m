function saida = rgb2xyz_c(imagem)
% Converte de RGB para XYZ.

[m,n,~] = size(imagem);

imagem = double(imagem);

img_r = imagem(:,:,1) / 255;
img_g = imagem(:,:,2) / 255;
img_b = imagem(:,:,3) / 255;

for i = 1:m
    for j = 1:n        
        if (img_r(i,j) > 0.04045)
            img_r(i,j) = ((img_r(i,j) + 0.055)/1.055)^(2.4);
        else
            img_r(i,j) = img_r(i,j) / 12.92;
        end
    end
end

for i = 1:m
    for j = 1:n        
        if (img_g(i,j) > 0.04045)
            img_g(i,j) = ((img_g(i,j) + 0.055)/1.055)^(2.4);
        else
            img_g(i,j) = img_g(i,j) / 12.92;
        end
    end
end

for i = 1:m
    for j = 1:n        
        if (img_b(i,j) > 0.04045)
            img_b(i,j) = ((img_b(i,j) + 0.055)/1.055)^(2.4);
        else
            img_b(i,j) = img_b(i,j) / 12.92;
        end
    end
end

X = (img_r * 0.4124) + (img_g * 0.3576) + (img_b * 0.1805);
Y = (img_r * 0.2126) + (img_g * 0.7152) + (img_b * 0.0722);
Z = (img_r * 0.0193) + (img_g * 0.1192) + (img_b * 0.9505);

saida(:,:,1) = X;
saida(:,:,2) = Y;
saida(:,:,3) = Z;
end