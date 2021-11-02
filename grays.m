% imagem = imagem colorida (RGB).
% Função para transoformar uma imagem colorida (RGB) em preto e branco.
% Autor: Victor Gabriell Ribeiro da Silva
% Data: 11/03/2020

function [saida] = grays(imagem)
    [~,~,c] = size(imagem); 
    
    if (c == 3) %Caso a imagem seja RGB a conversão é feita.
        saida = imagem(:,:,1)*0.299 + imagem(:,:,2)*0.587 + imagem(:,:,3)*0.114; %Baseado na 'Recommendation ITU-R BT.601-7'.
    else
        saida = imagem;
    end
    
end