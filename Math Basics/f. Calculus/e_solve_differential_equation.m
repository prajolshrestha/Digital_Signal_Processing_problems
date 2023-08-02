% Solving Differential Equations

% solve simple differential equation and plot general and perticular
% solutions given different initial values.

% learn: syms, diff, meshgrid, quiver,ezplot

%% state the problem

syms y(t)
% = diff(y) == exp(-t) -2*y;

eq = diff(y) == y;
%% Find the general solution
dsolve(eq)

%% Find the particular solution
dsolve(eq, y(0) == 2)

dsolve(eq,y(2) == pi)

%% Draw solutions : 

% QUIVER(X,Y,U,V) plots velocity vectors as arrows 
% with components (u,v) at the points (x,y).

%slope curves
[tt,yy] = meshgrid(linspace(-2,3,30),linspace(-1,2,32));

%sol = exp(-tt) - 2*yy;
sol = exp(-tt);
L = sqrt(1+sol.^2); % to normalize vectors


% divide by length for normalized vectors
figure(1), clf, hold on
h = quiver(tt,yy,1./L,sol./L,.5);% (x,y,orientation,length)
set(h,'linew',2,'color',[.8 .8 .8])

% specify initial values for solutions y at t=0
initvals = [2 1 .75 .5];
%draw solution curves for those initial values
h1 = zeros(size(initvals));
for i = 1:length(initvals)
    h1(i) = ezplot(dsolve(eq,y(0) == initvals(i)),[min(tt(:)) max(tt(:))]);
end

axis([min(tt(:)) max(tt(:)) min(yy(:)) max(yy(:))])
set(h1,linewidth=3)
















