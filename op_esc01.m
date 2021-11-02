% Função para somar  uma imagem com um escalar e normalizar o resultado [0,255] (uint8)
% Autor: Victor Gabriell Ribeiro da Silva
% Data: 07/04/2020

function [saida] = op_esc01(img,escalar,operacao)
    
    if (strcmp(operacao, 'Somar'))
        saida = img+escalar;
    else if ((strcmp(operacao, 'Sub')))
        saida = img-escalar;
    else if ((strcmp(operacao, 'Mult')))    
        saida = img*escalar;    
    else if ((strcmp(operacao, 'Div')))    
        saida = img*escalar;          
    end
    
    saida = normali_uint(saida);
end