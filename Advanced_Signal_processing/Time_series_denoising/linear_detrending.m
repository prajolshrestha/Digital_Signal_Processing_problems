% create signal 
n = 2000;
signal = cumsum(randn(1,n)) + linspace(-30,30,n); %brownian noise + linearity

%detrend
dsignal = detrend(signal);

% plot
plot(1:n, signal, 1:n, dsignal)
legend({['Original (mean= ' num2str(mean(signal)) ')']; ['Detrend signal (mean=' num2str(mean(dsignal)) ')']})
