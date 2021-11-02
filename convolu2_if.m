function [saida] = convolu2_if(x,y)
[dilat,~,~] = detects(x, 4);
dilat = normali(dilat);
y = normali(y);
y = grays(y);

dilat = round(dilat);
y = round(y);

[m,n] = size(dilat);
[t,k] = size(y);

add = floor(t/2);
dilat = [zeros(m,add) dilat];
dilat = [dilat zeros(size(dilat,1),add)];
dilat = [zeros(add,size(dilat,2)); dilat];
dilat = [dilat; zeros(add,size(dilat,2))];

saida = zeros(m,n);
%saida = zeros(m-round(t/2),n-round(t/2));

sum = 0;

for q = round(t/2):size(dilat,1)-(round(t/2)-1)
    for w = round(t/2):size(dilat,2)-(round(t/2)-1)
        for i = 1:t
            for j = 1:k
                if dilat((i+q)-(floor(t/2)+1),(j+w)-(floor(t/2)+1)) == y(i,j)
                    sum = sum + 1;
                end
            end
        end
        
        saida(q-(round(t/2)-1),w-(round(t/2)-1)) = sum;
        sum = 0;
    end
    
end

end