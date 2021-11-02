function [saida] = transla(img, dx, dy)
% Realiza a translação de uma imagem em x e y.
% dx = variação em x.
% dy = variação em y.

[m,n,c] = size(img); % Obtém as dimensões da imagem.
saida = uint8(255*(ones(m,n,c))); % Inicializa a matriz de saída.

mat = [1 0 dx; 0 1 dy; 0 0 1]; % Define a matriz de coordenada homogênea.

if (dx == 0 && dy == 0) % Caso não haja deslocamento.
    saida = img;
    
elseif (dy == 0) % Caso não haja deslocamento em y (colunas).
    for i = abs(dx):m % Laço para as linhas (até m-dx para não passar dos limites da img original).        
            
            coord = [i-((abs(dx)-1)); 1; 1]; % Define a matriz de coordenadas.
            res = mat*coord;   % Multiplica a matriz mat pela matriz de coordenadas.
            x2 = res(1,1); y2 = res(2,1);
            
            if (x2 > 0 && y2 > 0 && x2 <= m && y2 <= n)
                saida(x2, :, :) = img(i,:,:);
            end        
            
    end
    
elseif (dx == 0) % Caso não haja deslocamento em x (linhas).  
        for j = abs(dy):n % Laço para as colunas (até n-dy para não passar).
            
            coord = [1; j-((abs(dy)-1)); 1]; % Define a matriz de coordenadas.
            res = mat*coord;   % Multiplica a matriz mat pela matriz de coordenadas.
            x2 = res(1,1); y2 = res(2,1);
            
            if (x2 > 0 && y2 > 0 && x2 <= m && y2 <= n)
                saida(:, y2, :) = img(:,j,:);
            end
            
        end    
        
else % Caso haja deslocamento em x (linhas) e y (colunas) simultaneamente.
    for i = abs(dx):m % Laço para as linhas (até m-dx para não passar dos limites da img original).
        for j = abs(dy):n % Laço para as colunas (até n-dy para não passar).
            
            coord = [i-((abs(dx)-1)); j-((abs(dy)-1)); 1]; % Define a matriz de coordenadas.
            res = mat*coord;   % Multiplica a matriz mat pela matriz de coordenadas.
            x2 = res(1,1); y2 = res(2,1);
            
            if (x2 > 0 && y2 > 0 && x2 <= m && y2 <= n)
                saida(x2, y2, :) = img(i,j,:);
            end
            
        end
    end
end