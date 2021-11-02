function saida = col(img)
%div = 256/3;
[m,n,~] = size(img);
saida = uint8(zeros(m,n,3));

for c = 1:3
    for i = 1:m
        for j = 1:n
            
            if img(i,j) > 200
                if c == 1
                    saida(i,j,c) = img(i,j) + 2;
                elseif c == 2
                    saida(i,j,c) = img(i,j) + 2;
                elseif c == 3
                    saida(i,j,c) = img(i,j) + 100;
                end
                
            elseif img(i,j) > 80 && img(i,j) <= 200
                if c == 1
                    saida(i,j,c) = img(i,j) + 2;
                elseif c == 2
                    saida(i,j,c) = img(i,j) + 30;
                elseif c == 3
                    saida(i,j,c) = img(i,j) + 200;
                end
                
            elseif img(i,j) <= 80
                if c == 1
                    saida(i,j,c) = img(i,j) + 170;
                elseif c == 2
                    saida(i,j,c) = img(i,j) + 2;
                elseif c == 3
                    saida(i,j,c) = img(i,j) + 2;
                end
            end
            
        end
    end
end
subplot(121); imshow(img);
subplot(122); imshow(saida);
end