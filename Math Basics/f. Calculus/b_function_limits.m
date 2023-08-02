% Function limits

% Compute the limits of the several functions as they apporach interesting
% values.



% Symbolic variables(x, y, z, a, b, etc): Unlike numerical variables that hold specific values, 
% symbolic variables hold algebraic expressions or mathematical entities without assigning any specific numerical value to them.

% learn: syms, limit, fplot

%% Example 1
figure(1),clf

%create symbolic function
syms x
fx = (x-4)^2;
fplot(fx,[-2,8],LineWidth=2)
%compute the limit as x-->a
a = 3;
lim = limit(fx,x,a); 

% plot limit as red dashed cross-line
hold on
plot([1 1]*a, get(gca,'ylim'),'r--')
plot(get(gca,'xlim'),[1 1]*lim,'r--')

%% Example 2

figure(2), clf

%define function and plot it
fx = (x^2-25) / (x^2+x-30);
fplot(fx,[-10,10],LineWidth=2)

a = 5;
lim = limit(fx,x,a);
hold on
plot([1 1]*a, get(gca,'ylim'),'r--')
plot(get(gca,'xlim'),[1 1]*lim,'r--')

% limit approaches 0
lim0 = limit(fx)
% determine the limit of fx as it approaches x = -6 from left and right
lim6l = limit(fx,x,-6,'left')
lim6r = limit(fx,x,-6,'right')




