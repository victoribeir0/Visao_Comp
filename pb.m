% Transforma uma imagem em escala de cinza para preto e branco.

function [saida] = pb(imagem, limiar)
%imagem = normali(imagem);       % Normaliza��o da matriz de entrada (0-255).
                                 % Limiar para a trasnforma��o.
[m,n,c] = size(imagem);            % Obt�m as dimens�es da matriz de entrada.
saida = (zeros(m,n));            % Pr� aloca��o da matriz de sa�da.

% (Importante!) Caso a imagem seja RGB, � convertida para escala de cinza.
if (c == 3)
    imagem = grays(imagem);       % Chama a fun��o que converte para escala de cinza.
end

for i = 1:m                           % La�o para percorrer todas as linhas.
    for j = 1:n                       % La�o para percorrer todas as colunas.
        if (imagem(i,j) < limiar)     % Caso o pixel seja menor que o limite determinado.
            saida(i,j) = 0;           % O pixel de sa�da � preto.
        end
        if (imagem(i,j) >= limiar)     % Caso o pixel seja maior que o limite determinado.
            saida(i,j) = 255;         % O pixel de sa�da � branco.
        end
    end
end
end