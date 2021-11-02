function [saida] = convolu2(x,y)
x = normali(x);
x = grays(x);
y = normali(y);
y = grays(y);

[m,n] = size(x);
[t,k] = size(y);

add = floor(t/2);
x = [zeros(m,add) x];
x = [x zeros(size(x,1),add)];
x = [zeros(add,size(x,2)); x];
x = [x; zeros(add,size(x,2))];

saida = zeros(m,n);
saida = zeros(m-round(t/2),n-round(t/2));

sum = 0;

for q = round(t/2):size(x,1)-(round(t/2)-1)
    for w = round(t/2):size(x,2)-(round(t/2)-1)
        for i = 1:t
            for j = 1:k
                sum = sum + x((i+q)-(floor(t/2)+1),(j+w)-(floor(t/2)+1))*y(i,j);
            end
        end
        saida(q-(round(t/2)-1),w-(round(t/2)-1)) = sum;
        sum = 0;
    end
end

end