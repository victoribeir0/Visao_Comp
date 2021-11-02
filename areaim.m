function area = areaim(imagem,reg)
% Calcula a área de uma imagem binária.
% Pixels ativos = 1.
imagem = grays(imagem);
%[imagem,~] = limglobal(imagem);

[m,n,~] = size(imagem);
area = zeros(1,reg);

for k = 1:reg
    for i = 1:m
        for j = 1:n
            if imagem(i,j) == k
                area(k) = area(k) + 1;
            end
        end
    end
end
end