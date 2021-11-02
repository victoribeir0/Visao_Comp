function [saida, lim] = limotsu2(imagem,L)
imagem = grays(imagem);
% Obtém o histograma normalizado da imagem.
%L = histo(imagem, 0, 1);

% Obtém a quantidade de níveis de cinza.
tam = length(L);

% Obtém a média de todos os pixels da imagem.
mg = mean(imagem(:));

% Inicializa o vetor de variância.
varc = zeros(1,tam);

% Inicializa a média da classe 1.
m = 0;

% Para cada valor de k (1 até 256) calcula a variância(k).
for k = 1:tam
    
    % Determina o p1(k) (Soma das probalidades de 1 até k).
    p1 = sum(L(1:k));
    
    % Iteração para calcular a média da classe 1 (1 até k).
    for i = 1:k
        m = m + (i-1)*L(i);
    end
    
    if (p1 > 0 && p1 < 1)
        varc(k) = (mg*p1 - m)^2 / (p1*(1-p1));
    end
    % Obs: O correto é varc começar em 0. Isso é corrigido mais a frente.
    
    % Zera a média da classe 1 para o próximo k.
    m = 0;
    
end

% O k* ótimo é quando o vetor de variância é máximo.
[~,lim] = max(varc); % k* = lim = índice do vetor no valor máximo.

% Correção do varc: Como k começa em 1 mas o os níveis de cinza vai de 0 até 255, é
% preciso subtrair o índice de 1.
lim = lim - 1;

saida = pb(imagem,lim);

 subplot(131); imshow(imagem); title('Imagem de entrada');
 subplot(132); imshow(saida); title(sprintf('Imagem de saída %d', lim));
 subplot(133); plot(varc); xlim([0 256]); title('Variância de 1 até 256');
 disp(graythresh(imagem)*255);

end