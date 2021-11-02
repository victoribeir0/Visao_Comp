% Aplica zoom in ou zoom out em uma imagem (método da réplica).
% Autor: Victor Gabriell Ribeiro da Silva
% Data: 25/03/2020
% fator = fator de zoom usado (inteiros positivos).
% tipo = zoom in (0) / zoom out (1);

function [saida] = zoomm(imagem, fator, tipo)
imagem = normali(imagem);    % Normaliza a imagem.
[M,N,nc] = size(imagem);     % Pega as dimensões da imagem.
if (tipo == 0)               % 0 = Zoom in.
                             % Cria uma matriz de zeros com as dimensões da
                             % imagem final.
    saida = zeros(ceil(fator*M),ceil(fator*N),nc);
end

if (tipo == 1)               % 0 = Zoom in.
    saida = zeros(ceil(M/fator),ceil(N/fator),nc);
end

% Nesta parte é onde a matriz criada anteriormente é preenchida com os valores da
% imagem de entrada. Este é o laço para ZOOM IN.
% O x é usado como variável de controle para alterar o valor de g.
% O k é usado como variável para alterar as linhas da imagem de entrada.
% O g é usado como variável para alterar as colunas da imagem de entrada.
% O y é usado como variável de controle para alterar o valor de k.
x = 0; k = 1; g = 1; y = 0;  
for c = 1:nc                                % De 1 até o número de camadas de cores (grayscale = 1; RGB = 3).
    for i = 1:fator*M                       % De 1 até o número de linhas da matriz final.
        for j = 1:fator*N                   % De 1 até o número de colunas da matriz final.
            saida(i,j,c) = imagem(k,g,c);   % Preenche a matriz saida com os valores da imagem de entrada.
            x = x + 1;                      % Incrementa o x a fim de controlar o valor de g.
            if (x == fator)                 % Caso x seja igual ao fator selecionado.
                x = 0; g = g + 1;           % Zera o valor de x e incrementa o valor de g.
            end
        end
        y = y + 1; g = 1;                   % Incrementa o y a fim de controlar o valor de k. Também 'reseta' o valor de g.
        if (y == fator)                     % Caso y seja igual ao fator selecionado.
            y = 0; k = k + 1;               % Zera o valor de y e incrementa o valor de k.
        end
    end
    k = 1;                                  % Usado para 'resetar' o valor de k.
end
end