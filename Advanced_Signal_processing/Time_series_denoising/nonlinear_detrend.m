clear
%% polynomial intution

order = 5;

x = linspace(-15,15,100);
y = zeros(size(x));

for i = 1:order+1
    y = y + rand*x.^(i-1);
end

figure(1), clf
hold on 
plot(x,y)
title(['order-' num2str(order) ' polynomial'])

%% generate signal with slow polynomial artifact

n = 10000;
t = (1:n)';
k = 10; %number of poles for random amplitudes
slowdrift = interp1(100*randn(k,1), linspace(1,k,n),'pchip')';
signal = slowdrift + 20*randn(n,1);

figure(2), clf, hold on
h = plot(t,signal);
set(h,'color',[1 1 1]*.6)
xlabel('Time'),ylabel('Amplitude')

%% Fit a polynomial

% polynomial fit (returns coeffs)
p = polyfit(t,signal,5); %last arg is order of polynomial

% predicted data is evaluation of polynomial
yHat = polyval(p,t);

% compute residual (the cleaned signal)
residual = signal - yHat;

% now plot fit (the function that will be removed)
plot(t, yHat,'r')
plot(t,residual,'k')
legend({'Original';'Polyfit';'Filtered siganl'})

%% Bayes information criterion to find optimal order

% possible orders
orders = (5:40)';

% sum of squared errors (sse is reserved!)
ssel = zeros(length(orders), 1);

% loop through orders
for ri = 1:length(orders)

    %compute polynonmial 
    yHat = polyval(polyfit(t,signal,orders(ri)),t);

    %compute fit of model to data
    ssel(ri) = sum((yHat - signal).^2 )/n;
end

%bayes information criterion
bic = n*log(ssel) + order*log(n);

%best parameter has lowest bic
[bestP,idx] = min(bic);

%plot BIC
figure(3),clf,hold on
plot(orders,bic,'ks-')
plot(orders(idx),bestP,'ro')

%% Fit a optimal polynomial

% polynomial fit (returns coeffs)
pcoeff = polyfit(t,signal,orders(idx)); %last arg is order of polynomial

% predicted data is evaluation of polynomial
yHat = polyval(pcoeff,t);

% compute residual (the cleaned signal)
residual = signal - yHat;

% now plot fit (the function that will be removed)
figure(4),clf,hold on
plot(t,signal)
plot(t, yHat,'r')
plot(t,residual,'k')
legend({'Original';'Polyfit';'Filtered siganl'})









