function saida = fech(imagem,est)
% Abertura morfol�gica (dilata��o -> eros�o).
dilat = dilata(imagem,est);
saida = erosao(dilat,est);

subplot(131); imshow(imagem);
subplot(132); imshow(est);
subplot(133); imshow(saida);
end