function [res] = bitbit(img1,img2,operacao)
[M1,N1,c1] = size(img1);
[M2,N2,c2] = size(img2);

if (M1 == M2 && N1 == N2 && c1 == c2)
    if (strcmp(operacao, 'And'))
        res = bitand(img1,img2);
    elseif (strcmp(operacao, 'Or'))
        res = bitor(img1,img2);
    elseif (strcmp(operacao, 'Xor'))
        res = bitxor(img1,img2);
    elseif (strcmp(operacao, 'Cmp'))
        res = bitcmp(img1);
    end      
end

end