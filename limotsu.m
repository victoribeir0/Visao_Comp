function [mvari,ind] = limotsu(imagem)
L = histo(imagem, 0, 1); % Obtém o histograma da imagem.
tam = length(L);

mg = mean(imagem(:));
varc = zeros(1,tam);
m1 = 0; m2 = 0; var1 = 0; var2 = 0;

for k = 1:tam            % Iteração para encontrar o k* ótimo.
    p1 = sum(L(1:k));    % Definição do p1(k).
    p2 = 1-p1;           % Definição do p2(k).
    
    for i = 1:k          % Iteração para calcular a média da classe 1.
        m1 = m1 + i*L(i);
    end
    
    for i = k+1:tam      % Iteração para calcular a média da classe 2.
        m2 = m2 + i*L(i);
    end
    
    for i = 1:k          % Iteração para calcular a variância 1 (classe 1).
        var1 = var1 + (m1 - mg)^2;
    end
    %var1 = var1/p1;
    
    for i = k+1:tam      % Iteração para calcular a variância 2 (classe 2).
        var2 = var2 + (m2 - mg)^2;
    end
    %var2 = var2/p2;
    
    varc(k) = var1 + var2;
    %varc(k) = ((mg*p1 - m1)^2)/(p1*p2);
    m1 = 0; m2 = 0; var1 = 0; var2 = 0;
end

[mvari,ind] = max(varc);
subplot(1,3,1); imshow(pb(imagem,ind)); title(sprintf('Método de Otsu (Limiar %d)', ind));
subplot(1,3,2); imshow(pb(imagem,127)); title('Limiar 127');
subplot(1,3,3); plot(varc/max(varc)); xlim([0 256]); title('Variância intra-classe de 1 até 256 (normalizado)'); %114
end