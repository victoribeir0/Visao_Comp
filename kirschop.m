function [saida] = kirschop(x)
x = normali(x);
x = grays(x);

y1 = [5 -3 -3; 5 0 -3; 5 -3 -3];
y2 = [-3 -3 -3; 5 0 -3; 5 5 -3];
y3 = [-3 -3 -3; -3 0 -3; 5 5 5];
y4 = [-3 -3 -3; -3 0 5; -3 5 5];
y5 = [-3 -3 5; -3 0 5; -3 -3 5];
y6 = [-3 5 5; -3 0 5; -3 -3 -3];
y7 = [5 5 5; -3 0 -3; -3 -3 -3];
y8 = [5 5 -3; 5 0 -3; -3 -3 -3];

[m,n] = size(x);
[t,k] = size(y1);
saida = zeros(m-round(t/2),n-round(t/2));

sum1 = 0; sum2 = 0; sum3 = 0; sum4 = 0; 
sum5 = 0; sum6 = 0; sum7 = 0; sum8 = 0; 

for q = round(t/2):m-(round(t/2)-1)
    for w = round(t/2):n-(round(t/2)-1)
        for i = 1:t
            for j = 1:k
                sum1 = sum1 + x((i+q)-2,(j+w)-2)*y1(i,j);
                sum2 = sum2 + x((i+q)-2,(j+w)-2)*y2(i,j);
                sum3 = sum3 + x((i+q)-2,(j+w)-2)*y3(i,j);
                sum4 = sum4 + x((i+q)-2,(j+w)-2)*y4(i,j);
                sum5 = sum5 + x((i+q)-2,(j+w)-2)*y5(i,j);
                sum6 = sum6 + x((i+q)-2,(j+w)-2)*y6(i,j);
                sum7 = sum7 + x((i+q)-2,(j+w)-2)*y7(i,j);
                sum8 = sum8 + x((i+q)-2,(j+w)-2)*y8(i,j);
            end
        end
        sum = [sum1 sum2 sum3 sum4 sum5 sum6 sum7 sum8];
        saida(q-1,w-1) = max(sum);    
        
        sum1 = 0; sum2 = 0; sum3 = 0; sum4 = 0; 
        sum5 = 0; sum6 = 0; sum7 = 0; sum8 = 0; 
    end
end

saida = normali_uint(saida);
saida = pb(saida);

end