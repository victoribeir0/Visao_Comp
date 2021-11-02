function [saida, reg] = segmentacao2(imagem)
imagem = grays(imagem);   % Transforma para escala de cinza.
imagem = pb(imagem,127);
imagem = normali(imagem); % Normaliza para ficar com 0 ou 1.

[m,n,~] = size(imagem); % Obtém as dimensões da imagem.
saida = zeros(m,n);     % Inicializa a saída.
fator = 50;             % Define o fator usado para diferencias as regiões.

reg = 0; % Iniciliza o contador de regiões.

for i = 1:m
    for j = 1:n
        ativo = 0;
        % Caso o pixel da img seja ativo e não marcado na saída.
        if imagem(i,j) == 1 && saida(i,j) == 0
            
            % Checa os pixels à esquerda.
            for k = -1:0
                if (i+k > 0 && i+k <= m && j-1 > 0)
                    % Caso haja pixel ativo associa a região.
                    if imagem(i+k,j-1) == 1
                        saida(i,j) = saida(i+k,j-1);
                        ativo = 1; % Indica que já está ativado.
                        break;     % Para de procurar.
                    end
                end
            end
            
            % Checa os pixels acima.
            if (ativo == 0) % Só checa se ainda não estiver ativo.
                for k = -1:1
                    if (j+k > 0 && j+k <= n && i-1 > 0)
                        % Caso haja pixel ativo associa a região.
                        if imagem(i-1,j+k) == 1
                            saida(i,j) = saida(i-1,j+k);
                            ativo = 1; % Indica que já está ativado.
                            break;     % Para de procurar.
                        end
                    end
                end
                
                % Caso não haja pixels ativos à esq. ou acima add uma nova reg.
                if (ativo == 0)
                    reg = reg + 1;
                    saida(i,j) = reg*fator;
                    
                    % Checa os pixels à direita e marca os ativos.
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

% Checa se há erros na segmentação.
% Caso haja pixels vizinhos associados a regiões diferentes,
% a região com o número maior prevalece.

for i = 1:m
    for j = 1:n
        if saida(i,j) ~= 0
            % Checa os pixels à esquerda.
            for k = -1:1
                if (i+k > 0 && i+k <= m && j-1 > 0)
                    % Caso haja pixel com reg. diferente, altera a região.
                    if saida(i+k,j-1) ~= 0 && saida(i,j) ~= saida(i+k,j-1)
                        
                        % Checa qual é o maior:
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
                    % Caso haja pixel com reg. diferente, altera a região.
                    if saida(i-1,j+k) ~= 0 && saida(i,j) ~= saida(i-1,j+k)
                        
                        % Checa qual é o maior:
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
            
            % Checa os pixels à direita.
            for k = -1:1
                if (i+k > 0 && i+k <= m && j+1 <= n)
                    % Caso haja pixel com reg. diferente, altera a região.
                    if saida(i+k,j+1) ~= 0 && saida(i,j) ~= saida(i+k,j+1)
                        
                        % Checa qual é o maior:
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
                    % Caso haja pixel com reg. diferente, altera a região.
                    if saida(i+1,j+k) ~= 0 && saida(i,j) ~= saida(i+1,j+k)
                        
                        % Checa qual é o maior:
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