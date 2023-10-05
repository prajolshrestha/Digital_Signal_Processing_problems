%%
srate = 1024;
nyquist = srate/2;
frange = [20 45];
order = round(5*srate/frange(1));

filtkern = fir1(order,frange/nyquist);

figure(1), clf,hold on
subplot(131)
plot(filtkern)


hz = linspace(0,srate/2,floor(length(filtkern)/2)+1);
filtpow = abs(fft(filtkern)).^2;
filtpow = filtpow(1:length(hz));

subplot(132),hold on
plot(hz,filtpow)
plot([0 frange(1) frange frange(2) nyquist],[0 0 1 1 0 0],'ro-')
xlim([0,100])

subplot(133)
plot(hz,10*log10(filtpow))
