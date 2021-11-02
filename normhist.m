function saida = normhist(imagem)
% Define o vetor de histograma:
L = histo(imagem, 0, 1);
% Inicializa o vetor de distribuição cumulativa:
acum = zeros(1,length(L));
% Determina que o primeiro elemento da distribuição cumulativa é
% igual ao primeiro do histograma.
acum(1) = L(1);

[m,n,~] = size(imagem);
saida = uint8(zeros(m,n));
niveis = 256;

% Determina a função de distribuição cumulativa:
for i = 2:length(L)
    acum(i) =  acum(i-1) + L(i);
end

sk = round(acum * (niveis-1));

for i = 1:m
    for j = 1:n
        saida(i,j) = sk(imagem(i,j)+1);
    end
end

L1 = histo(imagem, 0, 1);
L2 = histo(saida, 0, 1);

subplot(2,2,1);
imshow(imagem); title('Imagem original');

subplot(2,2,2);
bar(L1,'b'); title('Histograma'); xlabel('Nível de cinza'); ylabel('Probabilidade'); xlim([1 niveis]);

subplot(2,2,3);
imshow(saida); title('Imagem (histograma eqaulizado)');

subplot(2,2,4);
bar(L2,'b'); title('Histograma eqaulizado'); xlabel('Nível de cinza'); ylabel('Probabilidade'); xlim([1 niveis]);

end