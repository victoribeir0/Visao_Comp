function dilat = dilata(imagem,est)
% Realiza a dilata��o bin�ria.
% est = Elemento estruturante.
imagem = grays(imagem);
imagem = normali_uint(imagem);

% Encontra os �ndices ativos do elemento estruturante.
[ln, col] = find(est == 1);

% Obt�m as dimens�es da imagem.
[m,n] = size(imagem);
res = zeros(m,n);

% Varre toda a imagem.
for i = 1:m
    for j = 1:n
        
        % Soma cada �nd. da imagem com os �nd. ativos do ele. est.
        % Para cada valor do �nd. do ele. est. (q) � feita uma mat. diferente.
        for q = 1:length(ln)
            res(i+ln(q), j+col(q), q) = imagem(i,j);
        end
        
    end
end

% Inicializa a matriz de dilata��o.
res2 = zeros(size(res,1),size(res,2));

% Soma todos os valores (q) da matriz res (m,n,q).
for q = 2:length(ln)
    res2 = res2 + res(:, :, q-1) + res(:, :, q);
end

dilat = uint8(zeros(m,n));

% A soma anterior resultar� em valores maiores que 1, � preciso limitar em 1. 
% Neste passo tamb�m � corrigido os �ndices 
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