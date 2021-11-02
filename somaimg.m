% Função para somar  duas  imagens e normalizar o resultado [0,255] (uint8)
% Autor: Victor Gabriell Ribeiro da Silva
% Data: 07/04/2020

function [somanor] = op_arit(img1,img2,operacao)
[M1,N1,c1] = size(img1);
[M2,N2,c2] = size(img2);

if (M1 == M2 && N1 == N2 && c1 == c2)
    if (strcmp(operacao, 'Somar'))
        soma = double(img1) + double(img2);
        somanor = 255*(soma-min(soma(:)))/(max(soma(:))-min(soma(:)));
        somanor = uint8(somanor);
    elseif ((strcmp(operacao, 'Sub')))
    end
end
end