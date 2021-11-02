function saida = statmask2(imagem1, imagem2)
% Obt�m o desvio padr�o da imagem atrav�s de uma m�scara 5x5.
% imagem1 = entrada (grayscale).
% imagem2 = refer�ncia (colorida).

[imagem2, imagem1] = iluremap(imagem2, imagem1);

ilu1 = imagem1(:,:,1);
ilu2 = imagem2(:,:,1); 

% Obt�m as dimens�es das imagens.
[m1,n1,~] = size(imagem1);
[m2,n2,~] = size(imagem2);

saida = zeros(m1,n1,3);

tam_mask = 5; % Define o tamanho da m�scara (sempre �mpar).

mat_tam = tam_mask-1; % Define o tamanho m�nimo da imagem1 (entrada).

% Define o �ndice a ser usado no la�o for para calcular o desv. padr�o.
indx = floor(tam_mask/2);

% Caso os dimens�es da imagem1 seja maior que o tamanho m�nimo.
if (m1 > mat_tam && n1 > mat_tam)
    
    ini = ceil(tam_mask/2); % Define a posi��o de in�cio.
    
    %% Calculo da matriz de desv. padr�o da imagem1.
    
    % Inicializa a matriz de desv1.
    desv1 = zeros(m1-mat_tam,n1-mat_tam,2);
    
    % Obt�m as dimens�es.
    [ms, ns, ~] = size(desv1);
    
    % Calcula a matriz de desvio padr�o da ilumin�ncia da imagem1 (entrada).
    for i = ini:m1-(ini-1)
        for j = ini:n1-(ini-1)
            %desv1(i-(ini-1),j-(ini-1)) = (0.5*ilu1(i,j))+(0.2*std2(ilu1(i-indx:i+indx,j-indx:j+indx)));
            desv1(i-(ini-1),j-(ini-1),1) = ilu1(i,j);
            desv1(i-(ini-1),j-(ini-1),2) = 0.2*std2(ilu1(i-indx:i+indx,j-indx:j+indx));
        end
    end
    
    %% Calculo da matriz de desv. padr�o da imagem2 (pixels aleat�rios).
    
    % N�mero m�ximo de pixels a ser selecionados (npixels*npixels).
    npixels = 24; %(12, 16)
    
    % Define os �ndices aleat�rios.
    ind2x = randi([3 (m2-2)],npixels); % min = 3, max = m2, npixels x npixels.
    ind2y = randi([3 (n2-2)],npixels);
    
    desv2 = zeros(npixels,npixels,2);
    
    % Calcula a desvio padr�o da imagem2 nos pixels selecionados da ilumin�ncia.
    for i = 1:npixels
        for j = 1:npixels
            %desv2(i,j) = (0.5*ilu2(ind2x(i,j),ind2y(i,j))) + (0.2*std2(ilu2(ind2x(i,j)-indx:ind2x(i,j)+indx, ind2y(i,j)-indx:ind2y(i,j)+indx)));
            desv2(i,j,1) = 0.5*ilu2(ind2x(i,j),ind2y(i,j));
            desv2(i,j,2) = 0.2*std2(ilu2(ind2x(i,j)-indx:ind2x(i,j)+indx, ind2y(i,j)-indx:ind2y(i,j)+indx));
        end
    end
    
    %% Compara��o entre o desv1 e desv2 para fazer o color matching.
    minv = abs(max(desv1(:))-min(desv2(:)));
    
    % Crit�rio de parada de compara��o. (Redu��o de tempo).
    c_stop = 0.05;
    
    % N�mero de subgrupos para fazer a compara��o = 4.
    
    % Define os intervalos.
    medn_c = median(desv2(:)); %max(desv2(:))/ngrupos;
    medn1 = median(desv2(desv2<=medn_c));
    medn2 = median(desv2(desv2>medn_c));   
    
    % Define os subgrupos.
    gp1 = desv2(desv2<=medn1); [mg1,~]  = size(gp1);
    gp2 = desv2(desv2>medn1 & desv2<=medn_c); [mg2,~]  = size(gp2);
    gp3 = desv2(desv2>medn_c & desv2<=medn2); [mg3,~]  = size(gp3);
    gp4 = desv2(desv2>medn2); [mg4,~]  = size(gp4);    
    tic;
    for i = 1:ms
        for j = 1:ns    
            
            if (desv1(i,j) <= medn1) % Primeiro grupo.
                
                for k = 1:mg1                    
                    dif = abs(desv1(i,j) - gp1(k));
                    
                    if (dif < minv)
                        minv = dif;
                        [ln,col] = find(abs(desv2-gp1(k)) < 0.00001);                        
                        % Caso haja mais de um pixel com caracter�sticas iguais (desv e ilu) qualquer um
                        % dos pixels serve para associar a cor, por isso o ln(1) e col(1).
                        saida(i,j,2:3) = imagem2(ind2x(ln(1),col(1)),ind2y(ln(1),col(1)),2:3);
                        if (minv <= c_stop)
                            break
                        end
                    end
                end 
            
            elseif (desv1(i,j) > medn1 && desv1(i,j) <= medn_c) % Segundo grupo.
                
                for k = 1:mg2                    
                    dif = abs(desv1(i,j) - gp2(k));
                    
                    if (dif < minv)
                        minv = dif;
                        [ln,col] = find(abs(desv2-gp2(k)) < 0.00001);                        
                        saida(i,j,2:3) = imagem2(ind2x(ln(1),col(1)),ind2y(ln(1),col(1)),2:3);
                        if (minv <= c_stop)
                            break
                        end
                    end
                end     
            
            elseif (desv1(i,j) > medn_c && desv1(i,j) <= medn2)  % Terceiro grupo.
                for k = 1:mg3                    
                    dif = abs(desv1(i,j) - gp3(k));
                    
                    if (dif < minv)
                        minv = dif;
                        [ln,col] = find(abs(desv2-gp3(k)) < 0.00001);                                               
                        saida(i,j,2:3) = imagem2(ind2x(ln(1),col(1)),ind2y(ln(1),col(1)),2:3);
                        if (minv <= c_stop)
                            break
                        end
                    end
                end  
                
            elseif (desv1(i,j) > medn2) % Quarto grupo.
                for k = 1:mg4                    
                    dif = abs(desv1(i,j) - gp4(k));
                    
                    if (dif < minv)
                        minv = dif;
                        [ln,col] = find(abs(desv2-gp4(k)) < 0.00001);                                                
                        saida(i,j,2:3) = imagem2(ind2x(ln(1),col(1)),ind2y(ln(1),col(1)),2:3);
                        if (minv <= c_stop)
                            break
                        end
                    end
                end
            end            
            minv = abs(max(desv1(:))-min(desv2(:)));
        end
    end    
    toc;    
    saida(:,:,1) = ilu1;
    saida = lab2rgb(saida);
    
    subplot(221); imshow(lab2rgb(imagem1)); title('Original');
    subplot(222); imshow(lab2rgb(imagem2)); title('Refer�ncia');
    subplot(223); imshow(saida); title('Colorido');
    subplot(224); imshow(medianafilt(saida)); title('Colorido (Filtro de mediana)');
end
end