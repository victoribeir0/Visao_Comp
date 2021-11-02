function saida = lapla(imagem)
mascara = [0 -1 0;-1 4 -1;0 -1 0];
saida = convolu2(imagem,mascara);
end