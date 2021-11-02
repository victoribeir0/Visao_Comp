function saida = fech(imagem,est)
% Abertura morfológica (dilatação -> erosão).
dilat = dilata(imagem,est);
saida = erosao(dilat,est);

subplot(131); imshow(imagem);
subplot(132); imshow(est);
subplot(133); imshow(saida);
end