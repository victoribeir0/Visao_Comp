%% convolução rapida
clear
clc
close all

auxiliar = imread('t.bmp');
M = auxiliar(:,:,1);
M = double(M);
figure(1)
imshow(uint8(M))
clear auxiliar

%% mascaras para detectar a borda
mascaray= [-1 0 1 ; -2 0 2; -1 0 1];
mascarax= [-1 -2 -1 ; 0 0 0; 1 2 1];
%% tamanho da imagem e vetores linha com 
%% coordenadas das linhas e colunas de cada posição da imagem
[linhas,colunas] = size(M);
[xx,yy] = meshgrid((1:colunas),(1:linhas));
x = reshape(xx,1,linhas*colunas);
y = reshape(yy,1,linhas*colunas);
%% Primeiro, vetor coluna com cada posição de cada par de coordenada 
%% usando a forma como o MATLAB acessa coordenadas como
%% M(linhas + 1) = M(1,2) e M(2*linhas + 1) = M(1,3).
%% Depois, dois vetores semelhantes um da segunda coluna e outro da terceira.
%% Todos são anexados como vetores linhas em uma matriz e um total de linhas
%% equivalentes a duas linhas da imagem são removidos para os três vetores terem 
%% a mesma quantidade de componentes não nulas. 
%% O impacto disso não é relevante já que as duas últimas colunas não 
%% seriam acessadas pela mascara que tem tamanho 3x3.
posicao = y + (x-1)*linhas;
posicao = posicao'; 
posicao(1:end-linhas,2) = posicao(linhas+1:end,1);
posicao(1:end-2*linhas,3) = posicao(2*linhas+1:end,1);
posicao(end-2*linhas+1:end,:) = [];

%% matriz com as intesidades de cada 3 sequências de colunas da imagem inteira.
%% Da sequência inicial até todas que começam na primeira coluna até as que terminam
%% na coluna descrita por (colunas - 2).
%% O tamanho dessa matriz é (linhas*colunas - linhas,3 - colunas)
J = [M(posicao(:,1)) M(posicao(:,2)) M(posicao(:,3))];
%% A matriz anterior vai ser multiplicada pela transposta de cada linha 1x3 
%% da mascara 3x3 e o resultado é transformado em uma matriz com 
%% o formato (linhas - linhas, (colunas-2) - colunas).
pM1x = J*mascarax(3,(end:-1:1))';
pM2x = J*mascarax(2,(end:-1:1))';
pM3x = J*mascarax(1,(end:-1:1))';
p_1x= reshape(pM1x,linhas,colunas-2);
p_2x = reshape(pM2x,linhas,colunas-2);
p_3x = reshape(pM3x,linhas,colunas-2);
%% A próxima operação vai ser somar os três resultados
%% antes é preciso deixar todas na mesma posição.
%% removendo duas linhas iniciais da matriz multiplicada pela terceira linha mascara
%% removendo uma linha inicial e uma final da multiplicada pela segunda linha mascara
%% removendo duas linhas finais da matriz multiplicada pela primeira linha mascara
p_2x(1,:) = [];
p_3x(1:2,:) = [];
p_1x(end-1:end,:) = [];
p_2x(end,:) = [];
%% com todas as matrizes na mesma posição a soma delas da o resultado da convolução
%% e o valor absoluto é o valor da borda obtido na convolução
px = p_1x+p_2x+p_3x;
px = abs(px);

%% todo processo é semelhante ao que foi feito para fazer a convolução 
%% com a mascara anterior 
pM1y = J*mascaray(3,(end:-1:1))'/4;
pM2y = J*mascaray(2,(end:-1:1))'/4;
pM3y = J*mascaray(1,(end:-1:1))'/4;

p_1y= reshape(pM1y,linhas,colunas-2);
p_2y = reshape(pM2y,linhas,colunas-2);
p_3y = reshape(pM3y,linhas,colunas-2);

p_2y(1,:) = [];
p_3y(1:2,:) = [];
p_1y(end-1:end,:) = [];
p_2y(end,:) = [];

py = p_1y+p_2y+p_3y;
py = abs(py);
%% o resultado dos dois tipos de bordas são somados
p = py+px;

figure(2)
imshow(uint8(p))


