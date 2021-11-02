function saida = statmask3(imagem1, imagem2)
% Obtém o desvio padrão da imagem através de uma máscara 5x5.
% imagem1 = entrada (grayscale).
% imagem2 = referência (colorida).
% edit: kurtose e assimetria

[imagem2, imagem1] = iluremap(imagem2, imagem1);

ilu1 = imagem1(:,:,1);
ilu2 = imagem2(:,:,1);

% Obtém as dimensões das imagens.
[m1,n1,~] = size(imagem1);
[m2,n2,~] = size(imagem2);

saida = zeros(m1,n1,3);

tam_mask = 5; % Define o tamanho da máscara (sempre ímpar).

mat_tam = tam_mask-1; % Define o tamanho mínimo da imagem1 (entrada).

% Define o índice a ser usado no laço for para calcular o desv. padrão.
indx = floor(tam_mask/2);

% Caso os dimensões da imagem1 seja maior que o tamanho mínimo.
if (m1 > mat_tam && n1 > mat_tam)
    
    ini = ceil(tam_mask/2); % Define a posição de início.
    
    %% Calculo da matriz de desv. padrão da imagem1.
    
    % Inicializa a matriz de desv1.
    desv1 = zeros(m1-mat_tam,n1-mat_tam);
    
    % Obtém as dimensões.
    [ms, ns, ~] = size(desv1);
    
    % Calcula a matriz de desvio padrão da iluminância da imagem1 (entrada).
    for i = ini:m1-(ini-1)
        for j = ini:n1-(ini-1)
            desv1(i-(ini-1),j-(ini-1)) = (0.5*ilu1(i,j))+(0.2*skewness(skewness(ilu1(i-indx:i+indx,j-indx:j+indx))));
        end
    end
    
    %% Calculo da matriz de desv. padrão da imagem2 (pixels aleatórios).
    
    % Número máximo de pixels a ser selecionados.
    npixels = 32;
    
    % Define os índices aleatórios.
    ind2x = randi([3 (m2-2)],npixels); % min = 3, max = m2, npixels x npixels.
    ind2y = randi([3 (n2-2)],npixels);
    
    desv2 = zeros(npixels,npixels);
    
    % Calcula a desvio padrão da imagem2 nos pixels selecionados da iluminância.
    for i = 1:npixels
        for j = 1:npixels
            desv2(i,j) = (0.5*ilu2(ind2x(i,j),ind2y(i,j))) + (0.2*skewness(skewness(ilu2(ind2x(i,j)-indx:ind2x(i,j)+indx, ind2y(i,j)-indx:ind2y(i,j)+indx))));
        end
    end

    %% Comparação entre o desv1 e desv2 para fazer o color matching.    
    minv = abs(max(desv1(:))-min(desv2(:)));
    
    for i = 1:ms
        for j = 1:ns
            for k = 1:npixels % 0.002674 s
                for s = 1:npixels
                    
                    dif = abs(desv1(i,j) - desv2(k,s));
                    
                    if (dif < minv)
                        minv = dif;
                        saida(i,j,2:3) = imagem2(ind2x(k,s),ind2y(k,s),2:3);
                    end
                    
                end
            end   
            minv = abs(max(desv1(:))-min(desv2(:)));
        end       
    end 
    toc;
    
    saida(:,:,1) = ilu1;
    saida = lab2rgb(saida);
    
    subplot(131); imshow(lab2rgb(imagem1)); title('Original');
    subplot(132); imshow(lab2rgb(imagem2)); title('Referência');
    subplot(133); imshow(saida); title('Colorido');  
    %subplot(224); imshow(medianafilt(saida)); title('Colorido (Filtro de mediana)');
    
end
end