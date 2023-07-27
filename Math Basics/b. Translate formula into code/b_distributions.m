% Gaussian, Laplace and log-normal Distributions

% learn: pdf and cdf
%% Gaussian distribution

x = -10:.1:10;

% cent = 7;
% widt= .8;
%gaus = exp((-(x-cent).^2) ./ 2*widt^2);

gaus = exp(-x.^2 ./ 2);
gaus = gaus ./ sum(gaus); %normalize to probabiblity density

figure(1), clf
subplot(211)
plot(x,gaus)
title('Gaussian distribution (pdf)')
set(gca,"xlim",[-7 7])

subplot(212)
plot(x,cumsum(gaus))
title('Cumulative density function (cdf)')
%% Laplace distribution

x = -5:.1:5;
l = 3;

y = .5 * l *exp(-l*abs(x));
y = y ./ sum(y);

figure(2),clf
subplot(211)
plot(x,y)
title('Laplace distribution (pdf)')

subplot(212)
plot(x,cumsum(y))
title('Cumulative density function (cdf)')

%% log normal distribution

x = linspace(.0001,5,100); % log(0) = -inf
m = 0;
s = .5;

y = (exp(-(log(x)-m).^2) / (2*s^2) ) ./ (s*x*sqrt(2.*pi));
y = y / sum(y);

figure(3),clf
subplot(211)
plot(x,y)
title('Log-normal distribution (pdf)')

subplot(212)
plot(x,cumsum(y))
title('Cumulative density function (cdf)')









