function desv = desvpad(img,tam_mask)
[m,n,~] = size(img);
desv = zeros(m,n);
ini = ceil(tam_mask/2);
indx = floor(tam_mask/2);

add = floor(tam_mask/2);
img = [zeros(m,add) img];
img = [img zeros(size(img,1),add)];
img = [zeros(add,size(img,2)); img];
img = [img; zeros(add,size(img,2))];

for i = ini:m+(ini-1)
    for j = ini:n+(ini-1)
        desv(i-(ini-1),j-(ini-1)) = (std2(img(i-indx:i+indx,j-indx:j+indx)));
    end
end

end