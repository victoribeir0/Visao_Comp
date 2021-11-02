function saida = zerocross(img, lim)
[m,n] = size(img);
saida = zeros(m,n);
maxi = max(img(:));

for i = 2:m-1
    for j = 2:n-1
        if (img(i-1,j-1) >= 0 && img(i+1,j+1) < 0 || img(i-1,j-1) < 0 && img(i+1,j+1) >= 0)
            if (abs(img(i-1,j-1)-img(i+1,j+1)) > lim*maxi)
                saida(i,j) = 255;
            end
            
        elseif (img(i-1,j+1) >= 0 && img(i+1,j-1) < 0 || img(i-1,j+1) < 0 && img(i+1,j-1) >= 0)
            if (abs(img(i-1,j+1)-img(i+1,j-1)) > lim*maxi)
                saida(i,j) = 255;
            end
            
        elseif (img(i-1,j) >= 0 && img(i+1,j) < 0 || img(i-1,j) < 0 && img(i+1,j) >= 0)
            if (abs(img(i-1,j)-img(i+1,j)) > lim*maxi)
                saida(i,j) = 255;
            end
            
        elseif (img(i,j-1) >= 0 && img(i,j+1) < 0 || img(i,j-1) < 0 && img(i,j+1) >= 0)
            if (abs(img(i,j-1)-img(i,j+1)) > lim*maxi)
                saida(i,j) = 255;
            end                    
        end
    end
end

saida = normali_uint(saida);

end