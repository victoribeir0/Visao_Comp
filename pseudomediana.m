function saida = pseudomediana(imagem)
[m,n,~] = size(imagem);
ini = floor(3/2);
saida = uint8(zeros(m-2,n-2));

vmin = zeros(1,5); vmax = zeros(1,5);

for i = (ini+1):(m-ini)
    for j = (ini+1):(n-ini)
        vet = reshape([imagem(i-ini,j-ini) imagem(i-ini,j) imagem(i-ini,j+ini) imagem(i,j-ini) imagem(i,j) imagem(i,j+ini) imagem(i+ini,j-ini) imagem(i+ini,j) imagem(i+ini,j+ini)],[1 9]);
        
        for d = 1:5
            vmin(d) = min(vet(d:d+4));
            vmax(d) = max(vet(d:d+4));            
        end
        
        saida(i-ini,j-ini) = round((max(vmin)+min(vmax))/2);
    end
end

subplot(1,2,1); imshow(imagem); title('Original');
subplot(1,2,2); imshow(saida); title('Filtrado');
end