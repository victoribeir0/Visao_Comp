function [a,dilat,ci,li] = detects(Imgg, reducao)
% Detectar placas de trânsito em imagens, de acordo com a cor.

if nargin < 1
    Imgg = imread('test (1).png');
end

% Subamostra a imagem, para otimizar o processamento.
a = Imgg;
Imgg = Imgg(1:reducao:end,1:reducao:end,:);

Img = Imgg;

Img = autoescala(Img,0);

% Inicia a imagem auxiliar 'aux'.
Aux = zeros(size(Img,1),size(Img,2));

% Converte de RGB para HSV (este formato facilita muito a seleção da cor).
img_hsv = rgb2hsv(Img);
img_hsv(:,:,1) = round(img_hsv(:,:,1)*360);
img_hsv(:,:,2) = round(img_hsv(:,:,2)*100);
img_hsv(:,:,3) = round(img_hsv(:,:,3)*100);

% Encontra os índices (L e C) onde a cor da placa está.
[L,C] = find((img_hsv(:,:,1) >= 35 & img_hsv(:,:,1) <= 55 | (img_hsv(:,:,1) >= 350 | img_hsv(:,:,1) <= 10)) & img_hsv(:,:,2) >= 60 & img_hsv(:,:,3) >= 60);

% Caso haja índices selecionados, o processo é realizado.
if ~isempty(L) && ~isempty(C)
    
    % Os píxels com a cor selecionadas são segmentados.
    for i = 1:length(L)
        Aux(L(i),C(i)) = 255;
    end
    
    res = bitcmp(normali_uint(Aux));
    est = ones(5,5);     
    dilat = dilata(res,est);
    
    res = bitcmp(normali_uint(dilat));
    est = ones(3,3);    
    dilat = dilata(res,est);    
    
    dilat = normali_uint(dilat);
    
    %[B,L] = bwboundaries(dilat);    
    [li,ci] = find(dilat == 255);
         
%         % Segmenta a imagem em diferentes regiões baseado na intensidade do pixel.
%         [Seg, Reg] = segmentacao3(Aux,0,0);
%
%         % Determina a área de cada região maracada da imagem.
%         area = areaim(Seg,Reg);
%
%         % Determina as regiões possíveis.
%         idx = find(area >= max(area)*0.1);
%
%         desv = zeros(1,length(idx));
%
%         % Marca as regiões com um tom verde.
%         for C = 1:length(idx)
%             % Encontra os índices (L2 e C2) que foram considerados como placas.
%             [L2,C2] = find(Seg==idx(C));
%             % Determina o desvio padrão de cada região.
%             desv(C) = std2(Seg(L2,C2));
%         end
%
%         for C = 1:length(idx)
%             [L2,C2] = find(Seg==idx(C));
%             if (desv(C) <= min(desv)*2)
%                 Imgg(L2,C2,3) = 255;
%                 a((L2*2),(C2*2),2) = 200;
%                 a((L2*2)+1,(C2*2),2) = 200;
%                 a((L2*2),(C2*2)+1,2) = 200;
%                 a((L2*2)+1,(C2*2)+1,2) = 200;
%             end
%         end
else
    ci = 0;
    li = 0;
end
end