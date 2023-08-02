% Function Integration

% Compute the indefinite integral(anti derivative) of easy and hard functions. 

% Hard: no closed-form solutions.

%learn: syms, int, integral, fplot

%% Simple problem

syms x
f = x^4;
intf = int(f);

figure(1),clf
subplot(211)
fplot(f,LineWidth=2),hold on
fplot(intf,LineWidth=2)
legend({'f','intf'})

%% integral of e^x

syms x
f = exp(x);
intf = int(f);

subplot(212)
fplot(f,LineWidth=2),hold on
fplot(intf,LineWidth=2)
legend({'f','intf'})

%% partial integration

syms x y
fxy = x^2 * y^3;

% compute integral w.r.t x
intfx = int(fxy,x);

% compute integral w.r.t y
intfy = int(fxy,y);

% actual value if partial integral w.r.t x at x = 4 and y = -2.3
a = subs(intfx,[x y],[4 -2.3])
vpa(a,7) %Variable precision arithmetic.


%% Difficult problem

f = sec(x) * log(tan(x)*sin(x)+sin(x)) /exp(x);

figure(2),clf,hold on
fplot(f,[-20 10],linewidth=2)

% compute integral
intf = int(f) % no closed form solution

% compute integral numerically
intvec = linspace(-20,10,100); %over this integral
intf2 = zeros(size(intvec)); % initialize

% to do this, we need to implement the mathematical function as an anonymous function
funcf = @(x) sec(x) .* log(tan(x).*sin(x)+sin(x)) ./exp(x);

%loop over time points and compute integral up to that time point
for i = 1:length(intvec)
    intf2(i) = integral(funcf,intvec(1),intvec(i));
end

plot(intvec,real(intf2),'LineWidth',3)




