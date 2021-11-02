function [saida,lim] = limglobal(imagem)
[m,n,~] = size(imagem);

g1 = uint8(zeros(1,m)); g2 = uint8(zeros(1,m));
lim(1) = 127; lim(2) = 0;
dt = 127;

while (dt > 5)
    % Determina os grupos 1 (>= lim) e 2 (< lim).
    for i = 1:m
        for j = 1:n
            if (imagem(i,j) >= lim(1))
                g1(i,j) = imagem(i,j);
            else
                g2(i,j) = imagem(i,j);
            end
        end
    end
    
    m1 = mean(g1(:)); % Calcula a média do grupo 1.
    m2 = mean(g2(:)); % Calcula a média do grupo 2.
    lim(1) = (m1 + m2)/2;
    
    dt = abs(lim(1) - lim(2));
    
    lim(2) = lim(1);
    
end
lim = lim(1);
saida = pb(imagem, round(lim));

% teste = pb(imagem, 127);
% 
% subplot(1,3,1)
% imshow(saida); title(sprintf('Imagem com limiar global (Limiar %d)', round(lim)));
% 
% subplot(1,3,2)
% imshow(teste); title('Imagem com limiar 127');
% 
% subplot(1,3,3)
% imshow(imagem); title('Imagem original');
% disp(lim) %68 cameraman
end