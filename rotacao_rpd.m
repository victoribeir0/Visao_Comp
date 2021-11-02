function [saida] = rotacao_rpd(img,theta)

[m,n,c] = size(img); % Obtém as dimensões da imagem.
saida = uint8(255*(ones(m,n,c))); % Inicializa a matriz de saída.

xm = ceil(m/2);
ym = ceil(n/2);

% Obtém as coordenadas da imagem de entrada.
[xx, yy] = meshgrid(1:m, 1:n);
coord = [xx(:) yy(:) ones(length(xx(:)),1)];

% Matriz para transladar a imagem para origem.
mat1 = [1 0 xm; 0 1 ym; 0 0 1];

% Matriz para rotacionar a imagem.
mat2 = [cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1];

% Matriz para transladar a imagem para posição original.
mat3 = [1 0 -xm; 0 1 -ym; 0 0 1];

mat = mat1*mat2*mat3; % Multiplicação para obter a matriz final.

res = coord*mat'; % Determina as novas coordenadas da imagem.

% Determina as coordenadas x e y através da matriz 'res'.
x2 = round(res(:,1)); y2 = round(res(:,2));

k = length(x2);

% Atualização dos índices

for i = 1:k
    
    if (x2(i) > 0 && y2(i) > 0 && x2(i) <= m && y2(i) <= n)
        saida(coord(i,1),coord(i,2),:) = img(x2(i),y2(i),:);
    end
    
end
end
