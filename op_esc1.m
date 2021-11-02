% Função para somar  uma imagem com um escalar e normalizar o resultado [0,255] (uint8)
% Autor: Victor Gabriell Ribeiro da Silva
% Data: 07/04/2020

function [res] = op_esc1(img,escalar,operacao)
        
    if (strcmp(operacao, 'Somar'))
        res = (img+escalar);
    elseif ((strcmp(operacao, 'Sub')))
        res = (img-escalar);
    end    
           
    subplot(1,2,1)
    imshow(img)
    subplot(1,2,2)
    imshow(res)
end