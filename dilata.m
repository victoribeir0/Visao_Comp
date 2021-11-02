function dilat = dilata(imagem,est)
% Realiza a dilatação binária.
% est = Elemento estruturante.
imagem = grays(imagem);
imagem = normali_uint(imagem);

% Encontra os índices ativos do elemento estruturante.
[ln, col] = find(est == 1);

% Obtém as dimensões da imagem.
[m,n] = size(imagem);
res = zeros(m,n);

% Varre toda a imagem.
for i = 1:m
    for j = 1:n
        
        % Soma cada índ. da imagem com os índ. ativos do ele. est.
        % Para cada valor do índ. do ele. est. (q) é feita uma mat. diferente.
        for q = 1:length(ln)
            res(i+ln(q), j+col(q), q) = imagem(i,j);
        end
        
    end
end

% Inicializa a matriz de dilatação.
res2 = zeros(size(res,1),size(res,2));

% Soma todos os valores (q) da matriz res (m,n,q).
for q = 2:length(ln)
    res2 = res2 + res(:, :, q-1) + res(:, :, q);
end

dilat = uint8(zeros(m,n));

% A soma anterior resultará em valores maiores que 1, é preciso limitar em 1. 
% Neste passo também é corrigido os índices 
for i = 3:3+(m-1)
    for j = 3:3+(n-1)
        if (res2(i,j) >= 1)
            dilat(i-2,j-2) = 255;
        end
    end
end

% subplot(131); imshow(imagem);
% subplot(132); imshow(est);
% subplot(133); imshow(dilat);
end