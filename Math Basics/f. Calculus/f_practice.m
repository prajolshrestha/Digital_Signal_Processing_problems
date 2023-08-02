% Practice differential equations

%% diff of sin
syms y(t)
eq = diff(y) == cos(t);

dsolve(eq, y(0)==0)

[tt,yy] = meshgrid(linspace(-2,15,30),linspace(-2,3,32));

sol = cos(tt);
L = sqrt(1+sol.^2); %length of the arrows in the quiver plot

figure(1),clf,hold on
h = quiver(tt,yy,1./L,sol./L,.5);
set(h,linewidth=2,color=[.8 .8 .8])

h1 = ezplot(dsolve(eq, y(0)==1),[min(tt(:)) max(tt(:))]);
set(h1,LineWidth=2)


xlabel('t');
ylabel('y(t)');
title('Direction Field (dy/dt = cos(t)) and Solution Curve');
grid on;
legend('Direction Field', 'Solution Curve');
%% diff of x^3

syms y(t) 

eq = diff(y) == t^3;

dsolve(eq)

[tt,yy] = meshgrid(linspace(-5,5,30),linspace(-5,5,30));
sol = tt.^4 / 4;
L = sqrt(1+sol.^2);

figure(2),clf,hold on
h = quiver(tt,yy,1./L,sol./L,0.5);
set(h,linewidth=2, color=[.8 .8 .8])

h1 = ezplot(dsolve(eq, y(0) == 2),[min(tt(:)) max(tt(:))]);
set(h1, LineWidth=2)


xlabel('t');
ylabel('y(t)');
title('Direction Field (dy/dt = t^3) and Solution Curve');
grid on;
legend('Direction Field', 'Solution Curve');

















