% Função para somar  uma imagem com um escalar e normalizar o resultado [0,255] (uint8)
% Autor: Victor Gabriell Ribeiro da Silva
% Data: 07/04/2020

function [saida] = op_esc2(img,escalar,operacao)
           
    if ((strcmp(operacao, 'Mult')))    
        res = double(img*escalar);
    elseif ((strcmp(operacao, 'Div')))    
        res = double(img/escalar);       
    end           
    
    saida = 255*(res-min(res(:)))/(max(res(:))-min(res(:)));
    saida = uint8(saida); 
           
    subplot(1,3,1)
    imshow(img)
    subplot(1,3,2)
    imshow(uint8(res))
    subplot(1,3,3)
    imshow(saida)
end