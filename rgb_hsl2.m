function saida = rgb_hsl2(img)
% Transforma uma imagem RGB para HSL.

% Converte a imagem para double.
img = double(img);

% Normaliza os valores entre 0 e 1.
img(:,:,1) = img(:,:,1)/255;
img(:,:,2) = img(:,:,2)/255;
img(:,:,3) = img(:,:,3)/255;

% Obtém as dimensões da imagem.
[m,n,~] = size(img);

% Inicializa a variáveis.
H = zeros(m,n);
S = zeros(m,n);
L = zeros(m,n);

for i = 1:m
    for j = 1:n
        
        [maxx,l] = max([img(i,j,1) img(i,j,2) img(i,j,3)]);
        minn = min([img(i,j,1) img(i,j,2) img(i,j,3)]);
        
        L(i,j) = 100*maxx;
        
        if maxx == 0
            S(i,j) = 0;
        else
            S(i,j) = 100*(maxx-minn)/maxx;
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
            H(i,j) = H(i,j) + 360;
        end
        
    end
end

saida(:,:,1) = H;
saida(:,:,2) = S;
saida(:,:,3) = L;

end

