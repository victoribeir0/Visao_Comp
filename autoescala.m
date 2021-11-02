function saida = autoescala(imagem,plot)
imagem = double(imagem);
immin = min(imagem(:));
immax = max(imagem(:));

saida = (255*(imagem-immin))/(immax-immin);
saida = uint8(saida);

if plot
    subplot(1,2,1); imshow(uint8(imagem)); title('Original');
    subplot(1,2,2); imshow(saida); title('Autoescala');
end
end