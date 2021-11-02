function saida = medianafilt(imagem)
[m,n,c] = size(imagem);

ini = floor(3/2);
saida = (zeros(m-2,n-2));

if (c == 1)

for i = (ini+1):(m-ini)
    for j = (ini+1):(n-ini)
        mediana = [imagem(i-ini,j-ini) imagem(i-ini,j) imagem(i-ini,j+ini) imagem(i,j-ini) imagem(i,j) imagem(i,j+ini) imagem(i+ini,j-ini) imagem(i+ini,j) imagem(i+ini,j+ini)];
        saida(i-ini,j-ini) = median(sort(mediana));
    end    
end

elseif (c == 3)
    
    for d = 1:3
        for i = (ini+1):(m-ini)
            for j = (ini+1):(n-ini)
                mediana = [imagem(i-ini,j-ini,d) imagem(i-ini,j,d) imagem(i-ini,j+ini,d) imagem(i,j-ini,d) imagem(i,j,d) imagem(i,j+ini,d) imagem(i+ini,j-ini,d) imagem(i+ini,j,d) imagem(i+ini,j+ini,d)];
                saida(i-ini,j-ini,d) = median(sort(mediana));
            end
        end
    end
    
end

%subplot(1,2,1); imshow(imagem); title('Original');
%subplot(1,2,2); imshow(saida); title('Filtrado');
end