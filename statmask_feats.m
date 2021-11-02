function saida = statmask_feats(imagem1, imagem2)
% Obt�m o desvio padr�o da imagem atrav�s de uma m�scara 5x5.
% imagem1 = entrada (grayscale).
% imagem2 = refer�ncia (colorida).

tic;
if nargin < 1
    imagem1 = rgb2gray(imread('sat01.jpg'));
end

if nargin < 2
    imagem2 = imread('sat02.jpg');
end

[imagem2, imagem1] = iluremap(imagem2, imagem1);

ilu1 = imagem1(:,:,1);
ilu2 = imagem2(:,:,1);

% Obt�m as dimens�es das imagens.
[m1,n1,~] = size(imagem1);
[m2,n2,~] = size(imagem2);

saida = zeros(m1,n1,3);

tam_mask = 5; % Define o tamanho da m�scara (sempre �mpar).

add = floor(tam_mask/2);
ilu1 = [zeros(m1,add) ilu1];
ilu1 = [ilu1 zeros(size(ilu1,1),add)];
ilu1 = [zeros(add,size(ilu1,2)); ilu1];
ilu1 = [ilu1; zeros(add,size(ilu1,2))];

mat_tam = tam_mask-1; % Define o tamanho m�nimo da imagem1 (entrada).

% Define o �ndice a ser usado no la�o for para calcular o desv. padr�o.
indx = floor(tam_mask/2);

% N�mero de caracter�sticas
feat = 3;
tic;
% Caso os dimens�es da imagem1 seja maior que o tamanho m�nimo.
if (m1 > mat_tam && n1 > mat_tam)
    
    ini = ceil(tam_mask/2); % Define a posi��o de in�cio.
    
    %% Calculo da matriz de desv. padr�o da imagem1.
    
    % Inicializa a matriz de desv1.
    desv1 = zeros(m1,n1,feat);
    
    % Obt�m as dimens�es.
    %[ms, ns, ~] = size(desv1);
    
    % Calcula a matriz de desvio padr�o da ilumin�ncia da imagem1 (entrada).
    for i = ini:m1+(ini-1)
        for j = ini:n1+(ini-1)
            %desv1(i-(ini-1),j-(ini-1)) = (0.5*ilu1(i,j))+(0.5*std2(ilu1(i-indx:i+indx,j-indx:j+indx)));
            %desv1(i-(ini-1),j-(ini-1),1) = ilu1(i,j);
            desv1(i-(ini-1),j-(ini-1),2) = std2(ilu1(i-indx:i+indx,j-indx:j+indx));
            desv1(i-(ini-1),j-(ini-1),3) = entimg(ilu1(i-indx:i+indx,j-indx:j+indx),tam_mask);
            %desv1(i-(ini-1),j-(ini-1),4) = max(max(ilu1(i-indx:i+indx,j-indx:j+indx))) ...
            %    - min(min(ilu1(i-indx:i+indx,j-indx:j+indx)));
        end
    end        
    ilu1 = ilu1(ini:m1+(ini-1),ini:n1+(ini-1));
    desv1(:,:,1) = ilu1;
end

%% Calculo da matriz de desv. padr�o da imagem2 (pixels aleat�rios).

% N�mero m�ximo de pixels a ser selecionados (npixels*npixels).
npixels = 30; %(12, 16)

% Define os �ndices aleat�rios.
ind2x = randi([3 (m2-2)],npixels); % min = 3, max = m2, npixels x npixels.
ind2y = randi([3 (n2-2)],npixels);

desv2 = zeros(npixels,npixels,feat);

% Calcula a desvio padr�o da imagem2 nos pixels selecionados da ilumin�ncia.
for i = 1:npixels
    for j = 1:npixels
        %desv2(i,j) = (0.5*ilu2(ind2x(i,j),ind2y(i,j))) + (0.5*std2(ilu2(ind2x(i,j)-indx:ind2x(i,j)+indx, ind2y(i,j)-indx:ind2y(i,j)+indx)));
        desv2(i,j,1) = ilu2(ind2x(i,j),ind2y(i,j));
        desv2(i,j,2) = std2(ilu2(ind2x(i,j)-indx:ind2x(i,j)+indx, ind2y(i,j)-indx:ind2y(i,j)+indx));
        desv2(i,j,3) = entimg(ilu2(ind2x(i,j)-indx:ind2x(i,j)+indx, ind2y(i,j)-indx:ind2y(i,j)+indx),tam_mask);
        %desv2(i,j,4) = max(max(ilu2(ind2x(i,j)-indx:ind2x(i,j)+indx, ind2y(i,j)-indx:ind2y(i,j)+indx))) ...
        %    - min(min(ilu2(ind2x(i,j)-indx:ind2x(i,j)+indx, ind2y(i,j)-indx:ind2y(i,j)+indx)));
    end
end
toc;
%% Compara��o entre o desv1 e desv2 para fazer o color matching.

desv1 = 0.5*desv1(:,:,1) + 0.7*desv1(:,:,2) + desv1(:,:,3);
desv2 = 0.5*desv2(:,:,1) + 0.7*desv2(:,:,2) + desv2(:,:,3);

%desv2 = reshape(desv2, [1 size(desv2,1)*size(desv2,2)]);

tic
for i = 1:size(desv1,1)
    for j = 1:size(desv1,2)
        
        v = min(min(abs(desv2 - desv1(i,j))));
        [x,y] = find(abs(desv2-desv1(i,j)) == v);
        saida(i,j,2:3) = imagem2(ind2x(x(1),y(1)),ind2y(x(1),y(1)),2:3);
    end
end
toc;

saida(:,:,1) = ilu1;
saida = lab2rgb(saida);

subplot(221); imshow(imread('sat01.jpg')); title('Original');
subplot(222); imshow(lab2rgb(imagem2)); title('Refer�ncia');
subplot(223); imshow(saida); title('Colorido atrav�s da refer�ncia');
subplot(224); imshow(medianafilt(saida)); title('Colorido (Filtro de mediana)');

end