function saida = mediafilt(imagem, n)
[~,~,c] = size(imagem);

if (mod(n,2) == 1) % Caso n seja ímpar.
    mascara = (1/(n*n))*ones(n,n);
    
    if (c == 3)
        saida(:,:,1) = convolu2(imagem(:,:,1),mascara);
        saida(:,:,2) = convolu2(imagem(:,:,2),mascara);
        saida(:,:,3) = convolu2(imagem(:,:,3),mascara);
        
    elseif (c == 1)
        saida(:,:,1) = convolu2(imagem(:,:,1),mascara);
    end
       
    subplot(1,2,1); imshow(imagem); title('Original');
    subplot(1,2,2); imshow(saida); title('Filtrado');
else
    disp('n deve ser ímpar!');
    saida = imagem;
end
end
      