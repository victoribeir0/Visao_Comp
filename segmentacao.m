function [saida,reg] = segmentacao(imagem)
imagem = grays(imagem);
imagem = normali(imagem);
[m,n,~] = size(imagem);
saida = zeros(m,n);
fator = 30;

reg = 1;

for i = 1:m
    for j = 1:n
        inc1 = zeros(1,3);
        inc2 = zeros(1,3);
        
        % Caso o pixel da img seja ativo e não marcado na saída.
        if imagem(i,j) == 1
            
            % Marca a saída como a região (caso ainda não marcado).
            if (saida(i,j) == 0)
                saida(i,j) = reg*fator;
            end
            
            % Checa os pixels a direita.
            for k = -1:1
                if (i+k > 0 && i+k <= m && j+1 <= n)
                    if imagem(i+k,j+1) == 1
                        saida(i+k,j+1) = reg*fator;
                        
                    elseif imagem(i+k,j+1) == 0
                        inc1(k+2) = 1;
                    end
                    
                elseif j+1 > n || i+1 > m
                    inc1(k+2) = 1;
                end
            end
            
            % Checa os pixels abaixo.
            for k = -1:1
                if (j+k > 0 && j+k <= n && i+1 <= m)
                    if imagem(i+1,j+k) == 1
                        saida(i+1,j+k) = reg*fator;
                        
                    elseif imagem(i+1,j+k) == 0
                        inc2(k+2) = 1;
                    end
                    
                elseif i+1 > m || j+1 > n
                    inc2(k+2) = 1;
                end
            end
            
            % Inc. o n° de reg. caso não haja pixel marcado a direita nem abaixo.
            if (inc1 & inc2) & ~(i == m && j == n)
                reg = reg + 1;
            end
            
        end
    end
    
end
saida = normali_uint(saida);
subplot(121); imshow(imagem);
subplot(122); imshow(saida);
end