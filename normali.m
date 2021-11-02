% imagem = imagem a ser processada.
% Função para normalizar uma imagem entre os intervalos [0,1] (double).
% Autor: Victor Gabriell Ribeiro da Silva
% Data: 12/03/2020

function [saida] = normali(imagem)
        imagem = double(imagem); 
        
        if (max(imagem(:))-min(imagem(:))) ~= 0
            saida = (imagem-min(imagem(:)))/(max(imagem(:))-min(imagem(:)));   
        else
            saida = imagem/255;
        end
        
        
        
end