% Function Derivatives

%learn: syms, diff, subs, pretty


%% derivative of sin(x) using symbolic variables

figure(1),clf

syms x
f = sin(x);
df = diff(f); %discrete derivative : Difference and approximate derivative.

subplot(211)
fplot(f), hold on
fplot(df)
legend(['f(x) = ' char(f)],['df = ' char(df)])


% Evaluate function and derivative at a specific point : Symbolic substitution.
a = pi/3;
subs(f,a)%sin(pi/3) = sqrt(3)/2
subs(df,a)%cos(pi/3) = 1/2

%% derivative of sin(t) using numeric variables

t = -5:.001:5;
q = sin(t);
dq = diff(q)*1000; %multiplied with sampling rate

subplot(212)
plot(t,q), hold on
plot(t(1:end-1),dq)
legend({'q','dq'})

%% more difficult problems
figure(2),clf

f = (exp(sin(x))^x) / (3^x*cos(x));
df = diff(f);

pretty(df)%Pretty print a symbolic expression. Human readable

fplot(f,LineWidth=2),hold on
fplot(df,LineWidth=2)

legend({'f(x)';'df'})
set(gca,'ylim',[-300,300])


