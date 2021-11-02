%Detecta pontos isolados de uma imagem.
% Autor: Victor Gabriell Ribeiro da Silva
% Data: 20/03/2020

function [saida] = mascara(imagem, operador, wb)
imagem = grays(imagem);
imagem = normali(imagem);

[ox, oy] = operador();

sx2 = convolu2(imagem,ox);
sy2 = convolu2(imagem,oy);

saida = normali_uint(abs(sx2) + abs(sy2));
%ang = atan2(sy2,sx2);

if (wb == 1)
    saida = pb(saida,50);
end
end