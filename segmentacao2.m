function [saida, reg] = segmentacao2(imagem)
imagem = grays(imagem);   % Transforma para escala de cinza.
imagem = pb(imagem,127);
imagem = normali(imagem); % Normaliza para ficar com 0 ou 1.

[m,n,~] = size(imagem); % Obt�m as dimens�es da imagem.
saida = zeros(m,n);     % Inicializa a sa�da.
fator = 50;             % Define o fator usado para diferencias as regi�es.

reg = 0; % Iniciliza o contador de regi�es.

for i = 1:m
    for j = 1:n
        ativo = 0;
        % Caso o pixel da img seja ativo e n�o marcado na sa�da.
        if imagem(i,j) == 1 && saida(i,j) == 0
            
            % Checa os pixels � esquerda.
            for k = -1:0
                if (i+k > 0 && i+k <= m && j-1 > 0)
                    % Caso haja pixel ativo associa a regi�o.
                    if imagem(i+k,j-1) == 1
                        saida(i,j) = saida(i+k,j-1);
                        ativo = 1; % Indica que j� est� ativado.
                        break;     % Para de procurar.
                    end
                end
            end
            
            % Checa os pixels acima.
            if (ativo == 0) % S� checa se ainda n�o estiver ativo.
                for k = -1:1
                    if (j+k > 0 && j+k <= n && i-1 > 0)
                        % Caso haja pixel ativo associa a regi�o.
                        if imagem(i-1,j+k) == 1
                            saida(i,j) = saida(i-1,j+k);
                            ativo = 1; % Indica que j� est� ativado.
                            break;     % Para de procurar.
                        end
                    end
                end
                
                % Caso n�o haja pixels ativos � esq. ou acima add uma nova reg.
                if (ativo == 0)
                    reg = reg + 1;
                    saida(i,j) = reg*fator;
                    
                    % Checa os pixels � direita e marca os ativos.
                    for k = -1:1
                        if (i+k > 0 && i+k <= m && j+1 <= n)
                            if imagem(i+k,j+1) == 1
                                saida(i+k,j+1) = reg*fator;
                            end
                        end
                    end
                    
                    % Checa os pixels abaixo e marca os ativos.
                    for k = -1:1
                        if (j+k > 0 && j+k <= n && i+1 <= m)
                            if imagem(i+1,j+k) == 1
                                saida(i+1,j+k) = reg*fator;
                            end
                        end
                    end
                end
            end
        end
    end
end

% Checa se h� erros na segmenta��o.
% Caso haja pixels vizinhos associados a regi�es diferentes,
% a regi�o com o n�mero maior prevalece.

for i = 1:m
    for j = 1:n
        if saida(i,j) ~= 0
            % Checa os pixels � esquerda.
            for k = -1:1
                if (i+k > 0 && i+k <= m && j-1 > 0)
                    % Caso haja pixel com reg. diferente, altera a regi�o.
                    if saida(i+k,j-1) ~= 0 && saida(i,j) ~= saida(i+k,j-1)
                        
                        % Checa qual � o maior:
                        if saida(i,j) > saida(i+k,j-1)
                            % Altera todos os da reg. menor para reg. maior.
                            saida(saida==saida(i+k,j-1)) = saida(i,j);
                            reg = reg - 1;
                        else
                            saida(saida==saida(i,j)) = saida(i+k,j-1);
                            reg = reg - 1;
                        end
                    end
                end
            end
            
            % Checa os pixels acima.
            for k = -1:1
                if (j+k > 0 && j+k <= n && i-1 > 0)
                    % Caso haja pixel com reg. diferente, altera a regi�o.
                    if saida(i-1,j+k) ~= 0 && saida(i,j) ~= saida(i-1,j+k)
                        
                        % Checa qual � o maior:
                        if saida(i,j) > saida(i-1,j+k)
                            % Altera todos os da reg. menor para reg. maior.
                            saida(saida==saida(i-1,j+k)) = saida(i,j);
                            reg = reg - 1;
                        else
                            saida(saida==saida(i,j)) = saida(i-1,j+k);
                            reg = reg - 1;
                        end
                    end
                end
            end
            
            % Checa os pixels � direita.
            for k = -1:1
                if (i+k > 0 && i+k <= m && j+1 <= n)
                    % Caso haja pixel com reg. diferente, altera a regi�o.
                    if saida(i+k,j+1) ~= 0 && saida(i,j) ~= saida(i+k,j+1)
                        
                        % Checa qual � o maior:
                        if saida(i,j) > saida(i+k,j+1)
                            % Altera todos os da reg. menor para reg. maior.
                            saida(saida==saida(i+k,j+1)) = saida(i,j);
                            reg = reg - 1;
                        else
                            saida(saida==saida(i,j)) = saida(i+k,j+1);
                            reg = reg - 1;
                        end
                    end
                end
            end
            
            % Checa os pixels abaixo.
            for k = -1:1
                if (j+k > 0 && j+k <= n && i+1 <= m)
                    % Caso haja pixel com reg. diferente, altera a regi�o.
                    if saida(i+1,j+k) ~= 0 && saida(i,j) ~= saida(i+1,j+k)
                        
                        % Checa qual � o maior:
                        if saida(i,j) > saida(i+1,j+k)
                            % Altera todos os da reg. menor para reg. maior.
                            saida(saida==saida(i+1,j+k)) = saida(i,j);
                            reg = reg - 1;
                        else
                            saida(saida==saida(i,j)) = saida(i+1,j+k);
                            reg = reg - 1;
                        end
                    end
                end
            end
        end
    end   
end

saida = normali_uint(saida);
subplot(121); imshow(imagem);
subplot(122); imshow(saida);
end