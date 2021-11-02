function L = histo(imagem, plot, norm)
niveis = 256;
L = zeros(1,niveis);
[m,n,~] = size(imagem);

for i = 1:m
    for j = 1:n
        pos = imagem(i,j);
        L(pos+1) = L(pos+1) + 1;
    end
end

if (norm == 1)
    L = L/(m*n);
end   

if (plot == 1)
    subplot(1,2,1);
    imshow(imagem); title('Imagem');
    
    subplot(1,2,2);
    bar(L,'b'); title('Histograma'); xlabel('Nível de cinza'); ylabel('Probabilidade'); xlim([1 niveis]);
end
end