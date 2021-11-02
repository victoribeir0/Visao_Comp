function vc1 = extr_dig()

L = 28;
load('dig0.mat');
img = train(1:200,2:785);
vc1 = zeros(1,12);

for d = 1:200
    imagem = reshape(img(d,:),[28 28])';   % A linha da matriz img define a imagem (1 até 10000).
    
    %% Limiarização em 127.
    
    for i = 1:L
        for j = 1:L
            if (imagem(i,j) > 127)
                imagem(i,j) = 255;
            else
                imagem(i,j) = 0;
            end
        end
    end
    imagem = uint8(imagem);
    %% Projeção horizontal
    
    phor = zeros(1,L);
    soma = 0;
    
    for i = 1:L
        for j = 1:L
            if (imagem(i,j) == 255)
                soma = soma+1;
            end
        end
        phor(i) = soma;
        soma=0;
    end
    
    phor = phor/28;  %Normalização, dividindo pelo maior elemento possível.
    
    j = 1;
    c1 = zeros(1,4); c2 = zeros(1,4); c3 = zeros(1,4);
    
    for i = 1:7:22
        c1(j) = sum(phor(i:i+6));
        c2(j) = mean(phor(i:i+6));
        c3(j) = std(phor(i:i+6));
        j = j + 1;
    end
    
    vc0(d,:) = [c1 c2 c3];
end

end