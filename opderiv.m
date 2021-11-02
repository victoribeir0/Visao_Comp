function [saida] = opderiv(imagem,t)
imagem = grays(imagem);
imagem = normali(imagem);

[m,n] = size(imagem);
%t = 1;
hor = zeros(m,n); ver = zeros(m,n);

    for i = t+1:m
        for j = t+1:n
            hor(i,j) = abs(imagem(i,j) - imagem(i,j-t));
            ver(i,j) = abs(imagem(i,j) - imagem(i-t,j));
        end
    end
    saida = hor + ver;
    saida = normali_uint(saida);
    
    saida = pb(saida);
    imshow(saida)
    
end