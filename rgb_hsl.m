function saida = rgb_hsl(img)

img = normali(img);
[m,n,~] = size(img);

H = zeros(m,n);
S = zeros(m,n);
L = zeros(m,n);

for i = 1:m
    for j = 1:n
        [maxx,l] = max([img(i,j,1) img(i,j,2) img(i,j,3)]);
        minn = min([img(i,j,1) img(i,j,2) img(i,j,3)]);
        L(i,j) = 100*round((maxx+minn)/2);
        
        if maxx == minn
            S(i,j) = 0;
            H(i,j) = 0;
        else
            if L(i,j) <= 0.5
                S(i,j) = 100*round((maxx-minn)/(maxx+minn));
            else
                S(i,j) = 100*round((maxx-minn)/(2-maxx-minn));
            end
            
            if l == 1
                H(i,j) = (img(i,j,2) - img(i,j,3))/(maxx-minn);                
            elseif l == 2
                H(i,j) = 2+(img(i,j,3) - img(i,j,1))/(maxx-minn);  
            else
                H(i,j) = 4+(img(i,j,1) - img(i,j,2))/(maxx-minn);                  
            end
            
            H(i,j) = round(H(i,j)*60);
            
            if H(i,j) < 0
                H(i,j) = H(i,j) + 60;
            end
            
        end                        
    end
end

saida(:,:,1) = H;
saida(:,:,2) = S;
saida(:,:,3) = L;
end