function [saida] = escalo2(img,sx,sy)
[m,n,c] = size(img);              % Obt�m as dimens�es da imagem.
saida = uint8(255*(ones(m,n,c))); % Inicializa a matriz de sa�da.

% Determina o ponto central da imagem.
xm = ceil(m/2);
ym = ceil(n/2);

% Obt�m as coordenadas da imagem de entrada.
[xx, yy] = meshgrid(1:m, 1:n);
coord = [xx(:) yy(:) ones(length(xx(:)),1)];

% Matriz para transladar a imagem para origem.
mat1 = [1 0 xm; 0 1 ym; 0 0 1];

% Matriz para escalonar a imagem.
mat2 = [1/sx 0 0; 0 1/sy 0; 0 0 1];

% Matriz para transladar a imagem para posi��o original.
mat3 = [1 0 -xm; 0 1 -ym; 0 0 1];

mat = mat1*mat2*mat3; % Multiplica��o para obter a matriz final.

res = coord*mat'; % Determina as novas coordenadas da imagem.

% Determina as coordenadas x e y atrav�s da matriz 'res'.
x2 = round(res(:,1)); y2 = round(res(:,2)); 

k = length(x2);

for i = 1:k
    
    if (x2(i) > 0 && y2(i) > 0 && x2(i) <= m && y2(i) <= n)
        saida(coord(i,1),coord(i,2),:) = img(x2(i),y2(i),:);
    end
    
end
end