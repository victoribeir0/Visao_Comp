function limdup = canny(img,limsup,liminf)
    img = convolu2(img,gaussmask()); % Filtro gaussiano.
    [img,ang] = mascara(img, @sobel, 0); % Aplicação do operador de Sobel.
        
    % Transforma de radianos para graus.
    ang = (ang*180)/pi; 
    
    % Determina que angulos negativos seja somados com 180.
    [m,n] = size(ang);
    for i = 1:m
        for j = 1:n
            if (ang(i,j) < 0)
                ang(i,j) = ang(i,j) + 180;
            end
        end
    end

    % Non-maximal supression
    nonsup = zeros(m,n);
    
    for i = 2:m-1
        for j = 2:n-1
            
            % Aqui é determinado quais pixel adjacentes serão utilizados (de acordo com o ângulo).            
                        
            % Ângulo 0 (ou 180 ou -180).
            if (0 <= ang(i,j) < 22.5 && ang(i,j) >= 0 || ang(i,j) <= 180 && ang(i,j) >= 157.5)
                    q = img(i, j+1);
                    r = img(i, j-1);            
            
            % Ângulo 45.
            elseif (ang(i,j) < 67.5 && ang(i,j) >= 22.5)
                    q = img(i-1, j-1);
                    r = img(i+1, j+1);
                        
            % Ângulo 90.
            elseif (ang(i,j) < 112.5 && ang(i,j) >= 67.5)
                    q = img(i+1, j);
                    r = img(i-1, j);
            
            % Ângulo 135.        
            elseif (ang(i,j) < 157.5 && ang(i,j) >= 112.5)                    
                    q = img(i+1, j-1);
                    r = img(i-1, j+1);
            end    
            
            % Caso o pixel atual seja maior que os pixel adjacentes determinados.
            if (img(i,j) > q && img(i,j) > r)
                nonsup(i,j) = img(i,j); % Mantém o pixel.
                
            % Caso o pixel atual seja menor o pixel é zerado..
            else
                nonsup(i,j) = 0; % Zera o valor.
            end
        end
    end       
        
    % Limiarização dupla    
    
    limdup = (zeros(m,n));
    
    for i = 1:m
        for j = 1:n
            
            % Caso o pixel seja maior que o limsup é considerado como forte (255).
            if (nonsup(i,j) >= limsup)
                limdup(i,j) = (255); % Forte.
            
            % Caso o pixel seja menor que o limsup é considerado como fraco (0).
            elseif (nonsup(i,j) < limsup && nonsup(i,j) >= liminf)
                limdup(i,j) = (100); % Fraco
                
            else
                limdup(i,j) = (0);
            end
            
        end
    end
    
    limdup = normali_uint(limdup);
    [m2,n2] = size(limdup);
    
    % Histerese    
    for i = 1:m2
        for j = 1:n2
            
            if(limdup(i,j) == uint8(100))
                
                if(limdup(i-1,j-1) == uint8(255) || limdup(i-1,j) == uint8(255) || limdup(i-1,j+1) == uint8(255) || limdup(i,j-1) == uint8(255) || limdup(i,j+1) == uint8(255) || limdup(i+1,j-1) == uint8(255) || limdup(i+1,j) == uint8(255) || limdup(i+1,j+1) == uint8(255))
                    limdup(i,j) = uint8(255);
                    
                else
                    limdup(i,j) = uint8(0);
                end
                
            end
            
        end
    end
end