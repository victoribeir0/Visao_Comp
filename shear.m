function [saida] = shear(img,a)

[m,n,c] = size(img); % Obtém as dimensões da imagem.
saida = uint8(255*(ones(m,n,c))); % Inicializa a matriz de saída.

xm = ceil(m/2);
ym = ceil(n/2);

% Matriz para transladar a imagem para origem.
mat1 = [1 0 xm; 0 1 ym; 0 0 1];

% Matriz para rotacionar a imagem.
mat2 = [1 0 0; a 1 0; 0 0 1];

% Matriz para transladar a imagem para posição original.
mat3 = [1 0 -xm; 0 1 -ym; 0 0 1];

mat = mat1*mat2*mat3; % Multiplicação para obter a matriz final.

% Atualização dos índices
for i = 1:m                % Laço para as linhas.
    for j = 1:n            % Laço para as colunas.
        
        coord = [i; j; 1]; % Define a matriz de coordenadas.
        res = mat*coord;   % Multiplica a matriz mat pela matriz de coordenadas.
        
        % Define as novas coordenadas.
        x2 = round(res(1,1)); y2 = round(res(2,1));
        
        % Caso as novas coordenadas não ultrapassem os limites da imagem.

        if (x2 > 0 && y2 > 0 && x2 <= m && y2 <= n)
            saida(i,j,:) = img(x2,y2,:);
        end
        
    end
end
end
