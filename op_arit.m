% Função para somar  duas  imagens e normalizar o resultado [0,255] (uint8)
% Autor: Victor Gabriell Ribeiro da Silva
% Data: 08/04/2020

function [saida] = op_arit(img1,img2,operacao)
[M1,N1,c1] = size(img1);
[M2,N2,c2] = size(img2);

if (M1 == M2 && N1 == N2 && c1 == c2)
    if (strcmp(operacao, 'Somar'))
        soma = double(img1) + double(img2);
        somanor = 255*(soma-min(soma(:)))/(max(soma(:))-min(soma(:)));
        saida = uint8(somanor);
    elseif ((strcmp(operacao, 'Sub')))
        subtr = double(img1) - double(img2);
        subtrnor = 255*(subtr-min(subtr(:)))/(max(subtr(:))-min(subtr(:)));
        saida = uint8(subtrnor);
    end
end
end