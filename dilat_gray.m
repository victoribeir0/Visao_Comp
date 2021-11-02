function saida = dilat_gray(imagem,est,val)
% Dilatação em escala de cinza.

% imagem = imagem a ser processada.
% est = elemento estruturante.
est = est*val;

imagem = grays(imagem); % Converte para escala de cinza.
[m,n,~] = size(imagem); % Obtém as dimensões da imagem.
saida = uint8(zeros(m-2,n-2)); % Inicializa a saída.

% Converte o ele. est. pra uint8 e transforma-o em um vetor linha (1x9).
vet2 = reshape(uint8(est), [1 9]);  

for i = 2:m-1
    for j = 2:n-1
        % Transforma a região da imagem (3x3) em um vetor linha (1x9).
        vet1 = reshape(imagem(i-1:i+1,j-1:j+1), [1 9]);
        % Realiza a soma, obtém o máximo e coloca o resultado na saída.
        saida(i-1,j-1) = max(vet1 + vet2);
    end
end

% Normaliza a saída para não saturar a imagem.
saida = normali_uint(saida);
end