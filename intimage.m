function I = intimage(imagem)
% Zero padding a esquerda e acima.
% Isto facilita a computação do resultado.
imagem = [zeros(1,size(imagem,2)); imagem];
imagem = [zeros(size(imagem,1),1) imagem];

[m,n,~] = size(imagem);
I = zeros(m,n);

for i = 2:m
    for j = 2:n
        I(i,j) = imagem(i,j) + I(i,j-1) + I(i-1,j) - I(i-1,j-1);
    end
end

% Remove os valores de zero.
I =  normali_uint(I(2:m,2:n));
end