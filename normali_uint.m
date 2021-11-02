% imagem = imagem a ser processada.
% Função para normalizar uma imagem entre os intervalos [0,255] (uint8).
% Autor: Victor Gabriell Ribeiro da Silva
% Data: 07/04/2020

function [saida] = normali_uint(imagem)
        imagem = double(imagem); 
        saida = 255*(imagem-min(imagem(:)))/(max(imagem(:))-min(imagem(:)));
        saida = uint8(saida);         
end