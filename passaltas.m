function saida = passaltas(imagem)
mascara = (1/9)*[-1 -1 -1; -1 8 -1; -1 -1 -1];
saida = convolu2(imagem,mascara);
end