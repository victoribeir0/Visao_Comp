% Função para subtrair  duas  imagens e normalizar o resultado [0,255] (uint8)
% Autor: Victor Gabriell Ribeiro da Silva
% Data: 07/04/2020

function [subtrnor] = subtrimg(img1,img2)
    [M1,N1,c1] = size(img1);
    [M2,N2,c2] = size(img2);

    if (M1 == M2 && N1 == N2 && c1 == c2)
        subtr = double(img1) - double(img2);
        subtrnor = 255*(subtr-min(subtr(:)))/(max(subtr(:))-min(subtr(:)));
        subtrnor = uint8(subtrnor);
    end
end