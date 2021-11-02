% m1 e n1 = número da linha/col que começam as linhas pretas.
% m2 e n2 = número da linha/col que terminas as linhas pretas.
function [saida] = cretebin(img, m1, m2, n1, n2)
[m,n] = size(img);
saida = zeros(m,n);

    for i = m1:m2
        for j = n1:n2
            saida(i,j) = 255; % Torna o pixel preto.
        end
    end
    
    saida = normali_uint(saida);
end