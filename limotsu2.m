function [saida, lim] = limotsu2(imagem,L)
imagem = grays(imagem);
% Obt�m o histograma normalizado da imagem.
%L = histo(imagem, 0, 1);

% Obt�m a quantidade de n�veis de cinza.
tam = length(L);

% Obt�m a m�dia de todos os pixels da imagem.
mg = mean(imagem(:));

% Inicializa o vetor de vari�ncia.
varc = zeros(1,tam);

% Inicializa a m�dia da classe 1.
m = 0;

% Para cada valor de k (1 at� 256) calcula a vari�ncia(k).
for k = 1:tam
    
    % Determina o p1(k) (Soma das probalidades de 1 at� k).
    p1 = sum(L(1:k));
    
    % Itera��o para calcular a m�dia da classe 1 (1 at� k).
    for i = 1:k
        m = m + (i-1)*L(i);
    end
    
    if (p1 > 0 && p1 < 1)
        varc(k) = (mg*p1 - m)^2 / (p1*(1-p1));
    end
    % Obs: O correto � varc come�ar em 0. Isso � corrigido mais a frente.
    
    % Zera a m�dia da classe 1 para o pr�ximo k.
    m = 0;
    
end

% O k* �timo � quando o vetor de vari�ncia � m�ximo.
[~,lim] = max(varc); % k* = lim = �ndice do vetor no valor m�ximo.

% Corre��o do varc: Como k come�a em 1 mas o os n�veis de cinza vai de 0 at� 255, �
% preciso subtrair o �ndice de 1.
lim = lim - 1;

saida = pb(imagem,lim);

 subplot(131); imshow(imagem); title('Imagem de entrada');
 subplot(132); imshow(saida); title(sprintf('Imagem de sa�da %d', lim));
 subplot(133); plot(varc); xlim([0 256]); title('Vari�ncia de 1 at� 256');
 disp(graythresh(imagem)*255);

end