function saida = xyz2lab_c(imagem)
% Converte XYZ para CIELAB.

[m,n,~] = size(imagem);

Xn = 94.811;   % refrencia de branco.
Yn = 100;
Zn = 107.304;

var_x = (imagem(:,:,1)*100) / Xn;
var_y = (imagem(:,:,2)*100) / Yn;
var_z = (imagem(:,:,3)*100) / Zn;

for i = 1:m
    for j = 1:n
        if (var_x(i,j) > 0.008856)
            var_x(i,j) = var_x(i,j)^(1/3);
        else
            var_x(i,j) = (7.787*var_x(i,j) + (16/116));
        end
    end
end

for i = 1:m
    for j = 1:n
        if (var_y(i,j) > 0.008856)
            var_y(i,j) = var_y(i,j)^(1/3);
        else
            var_y(i,j) = (7.787*var_y(i,j) + (16/116));
        end
    end
end

for i = 1:m
    for j = 1:n
        if (var_z(i,j) > 0.008856)
            var_z(i,j) = var_z(i,j)^(1/3);
        else
            var_z(i,j) = (7.787*var_z(i,j) + (16/116));
        end
    end
end

L = (116 * var_y) - 16;
A = 500 * (var_x - var_y);
B = 200 * (var_y - var_z);

saida(:,:,1) = L;
saida(:,:,2) = A;
saida(:,:,3) = B;
end