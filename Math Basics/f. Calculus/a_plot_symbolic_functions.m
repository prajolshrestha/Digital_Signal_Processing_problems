% Plotting symbolic functions

% learn: ezplot(), fplot(), fimplicit3(), ezpolar()

%% using ezplot : (NOT RECOMMENDED) Easy to use function plotter

figure(1), clf

fx = '10*sin(x) + tan(x/2)/10';
h = ezplot(fx); %H = FPLOT(...) returns a handle to the function line object created by FPLOT.
set(h,'linew',2)

%% using fplot : Plot 2-D function
figure(2)

fy = @(y) 10*sin(y) + tan(y/2)/10;
h = fplot(fy,[-15,5]);
set(h,'LineWidth',2)

%% plotting implicit functions : Plot implicit surface
figure(3), clf
fts = @(r,t,s) 2.^(t.*s) + r.*s - t.*s.^(1/3); %define functions as anonymous

h = fimplicit3(fts);
rotate3d on, axis image
set(h,'LineStyle','none')

figure(4), clf
fts = @(t,a,b) 2*a.*(1-cos(t))+abs(b);%cardioid-inspired function
h = fimplicit3(fts);
rotate3d on, axis image
set(h,'LineStyle','none')

%% polar plot : EZPOLAR Easy to use polar coordinate plotter.

figure(5), clf
cardioid = @(t) 2*(1-cos(t));
h = ezpolar(cardioid);
set(h,'LineWidth',2,'color','r')










