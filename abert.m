function saida = abert(imagem,est)
ero = erosao(imagem,est);
saida = dilata(ero,est);

subplot(131); imshow(imagem);
subplot(132); imshow(est);
subplot(133); imshow(saida);
end