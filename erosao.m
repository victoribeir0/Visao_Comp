function ero = erosao(imagem,est)
% Realiza a erosão binária.
% est = Elemento estruturante.
imagem = grays(imagem);
imagem = normali_uint(imagem);

% Encontra os índices ativos do elemento estruturante.
[ln1, col1] = find(est == 1);
ln1 = ln1 - 2; col1 = col1 - 2;

[ln2, col2] = find(imagem == 255);

% Obtém as dimensões da imagem.
[m,n] = size(imagem);
ero = zeros(m,n);

% Varre toda a imagem.
for i = 1:m
    for j = 1:n
        if (imagem(i,j) == 255)
            % Soma cada índ. da imagem com os índ. ativos do ele. est.
            % Para cada valor do índ. do ele. est. (q) é feita uma mat. diferente.
            if (i+ln1 <= max(ln2) & j+col1 <= max(col2))
                ero(i, j) = 255;
            end
        end
    end
end

subplot(131); imshow(imagem);
subplot(132); imshow(est);
subplot(133); imshow(normali_uint(ero));
end