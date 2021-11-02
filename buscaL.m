function s = buscaL(L)

s = zeros(1,length(L)-1);
t = diff(sort(L));
sL = sort(L);
inc = 0;
m = 1;

for k = 1:(length(L)-1)
    if (t(k) == 1 || t(k) == 0)
        s(k) = sL(k);
        inc = inc + 1;
    else
        val(m) = inc;
        m = m+1;
        inc = 0;
    end    
    
end
end