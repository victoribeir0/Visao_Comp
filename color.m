% imagem = imagem preto e branco.
% Função para transoformar uma imagem preto e branco em colorida (RGB).
% Autor: Victor Gabriell Ribeiro da Silva
% Data: 11/03/2020

function [saida] = color(imagem)
    saida(:,:,1) = imagem/0.8;
    saida(:,:,2) = imagem*0.587;
    saida(:,:,3) = imagem*0.114;
    imshow(saida);
end