function [E,theta,a,b,c] = orientacao(imagem)
res = grays(imagem);

[m,n,~] = size(res);

a = 0; c = 0; b = 0;

[x,y] = centro(res);

for i = 1:m
    for j = 1:n
        if res(i,j) == 1 || res(i,j) == 255
            a = a + ((i-x)^2);
            b = b + ((i-x)*(j-y));
            c = c + ((j-y)^2);
        end
    end
end
b = 2*b;

aux_sen = b/(sqrt((b^2)+(a-c)^2));
theta = 0+(asind(aux_sen)/2);

aux_cos = (a-c)/(sqrt((b^2)+(a-c)^2));
E = ((a+c)/2) - ((a-c)/2) * aux_cos - (b/2) * aux_sen;

% Definição do ponto central da imagem (centro de massa).

x2 = x + (50*cosd(theta));
y2 = y + (50*sind(theta));

subplot(121);
imshow((normali_uint(res)));
hold on; plot(x,y,'r*');
hold on; plot([x x2],[y y2],'r--', 'LineWidth',2);

dim = [.2 .5 .3 .45];
str = sprintf('Ângulo: %f', -theta);
annotation('textbox',dim,'String',str,'FitBoxToText','on');

subplot(122);
plot([x x2],[y y2],'m--');

end