% Transforma uma imagem em escala de cinza para preto e branco.

function [saida] = pb(imagem, limiar)
%imagem = normali(imagem);       % Normalização da matriz de entrada (0-255).
                                 % Limiar para a trasnformação.
[m,n,c] = size(imagem);            % Obtém as dimensões da matriz de entrada.
saida = (zeros(m,n));            % Pré alocação da matriz de saída.

% (Importante!) Caso a imagem seja RGB, é convertida para escala de cinza.
if (c == 3)
    imagem = grays(imagem);       % Chama a função que converte para escala de cinza.
end

for i = 1:m                           % Laço para percorrer todas as linhas.
    for j = 1:n                       % Laço para percorrer todas as colunas.
        if (imagem(i,j) < limiar)     % Caso o pixel seja menor que o limite determinado.
            saida(i,j) = 0;           % O pixel de saída é preto.
        end
        if (imagem(i,j) >= limiar)     % Caso o pixel seja maior que o limite determinado.
            saida(i,j) = 255;         % O pixel de saída é branco.
        end
    end
end
end