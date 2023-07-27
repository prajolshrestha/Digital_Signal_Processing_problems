%% Sigmoid Function / Inflection point / Equivalence point

% learn: exp, linspace, get

% a = height / amplitude
% b = temperature/heat parameter -- how fast slope rises (steepness)
% c = center point / inflection point (x-axis shift)

%%
a = 1.4;
b = 2;
c = -1;

x = linspace(-5,5,400);
y = a ./ (1 + exp(-b*(x-c)));

figure(1),clf, hold on
plot(x,y)
plot([0 0], get(gca,'ylim'),'k--')
plot([c c],get(gca,'ylim'),'r--')
plot(get(gca,'xlim'),[a/2 a/2],'r--')
title('Sigmoid function')