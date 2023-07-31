% Same- length Differentiation

% Compute 1st and 2nd derivative

% learn: diff, error, isnumeric

%% derivative using default diff()

n = 100;
t = (0:n-1)/n;
x = randn(1,n) +linspace(0,10,n);

dx = diff(x);
ddx1 = diff(diff(x));
ddx2 = diff(x,2);

figure(1),clf, hold on
plot(t,x)
plot(t(1:end-1),dx)
plot(t(1:end-2),ddx1)
legend({'x', 'first derivative', 'Second derivative'})

%% derivative with our own diffx() for same length output.

dx = diffx(x);
ddx1 = diffx(diffx(x));


figure(2),clf, hold on
plot(t,x)
plot(t,dx)
h = plot(t,ddx1);
legend({'x', 'first derivative', 'Second derivative'})

