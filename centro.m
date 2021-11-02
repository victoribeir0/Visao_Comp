function [x,y] = centro(imagem)
% Calcula o centro de área de uma imagem binária.
% Pixels ativos = 1.
area = areaim(imagem);

x = 0; y = 0;

if area ~= 0
    [m,n,~] = size(imagem);
    x = 0;
    y = 0;
    
    for i = 1:m
        for j = 1:n
            if imagem(i,j) == 1 || imagem(i,j) == 255
                x = x + i;
                y = y + j;
            end
        end
    end
    
    x = (x/area);
    y = (y/area);
    
    %imshow(imagem); hold on; plot(x,y,'r*'); legend('Centro de Massa');
    
else
   disp('A área de imagem é zero.');
end

end