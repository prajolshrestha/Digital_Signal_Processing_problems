%% 
% data
srate = 1024;
nyquist = srate/2;
frange = [20 25];
trans = 0.1;
order = round( 9*srate/frange(1));

shape = [0 0 1 1 0 0];
freqx = [0 frange(1)-frange(1)*trans frange frange(2)+frange(2)*trans nyquist]/nyquist;

%filter kernel (impulse response)
filtkern = firls(order,freqx,shape);

%fft
hz = linspace(0,srate/2,floor(length(filtkern)/2)+1);
filtpow = abs(fft(filtkern)).^2;
filtpow = filtpow(1:length(hz));

figure(1),clf
subplot(131)
plot(filtkern)
title('Filter Kernel (firls)')
axis square

subplot(132),hold on
plot(hz,filtpow,'ks-',LineWidth=2,MarkerFaceColor='w')
plot(freqx*nyquist, shape,'ro-',LineWidth=2,MarkerFaceColor='w')
axis square
xlim([0,80])
legend({'Actual';'Ideal'})
axis square
title('Frequency response of filter (firls)')

subplot(133), hold on
plot(hz,10*log10(filtpow),'ks-','linew',2,'markersize',10,'markerfacecolor','w')
plot([1 1]*frange(1),get(gca,'ylim'),'k:')
set(gca,'xlim',[0 frange(1)*4],'ylim',[-50 2])
xlabel('Frequency (Hz)'), ylabel('Filter gain (dB)')
title('Frequency response of filter (firls)')
axis square

%% effects of filter kernel order

ordersF = ( 1*srate/frange(1)) / (srate/1000);
ordersL = (15*srate/frange(1)) / (srate/1000);

orders = round(linspace(ordersF,ordersL,10));
n = zeros(length(orders),1);

fkX = zeros(length(orders),1000);
hz = linspace(0,srate,1000);
figure(2), clf
for i = 1:length(orders)
    fk = firls(orders(i),freqx,shape);
    n(i) = length(fk);

    fkX(i,:) = abs(fft(fk,1000)).^2;
    
    subplot(211), hold on
    plot((1:n(i))-n(i)/2,fk+.01*i,'linew',2)
end
xlabel('Time (ms)')
set(gca,'ytick',[])
title('Filter kernels with different orders')

subplot(223), hold on
plot(hz,fkX,'linew',2)
plot(freqx*nyquist,shape,'k','linew',4)
set(gca,'xlim',[0 100])
xlabel('Frequency (Hz)'), ylabel('Attenuation')
title('Frequency response of filter (firls)')


subplot(224)
plot(hz,10*log10(fkX),'linew',2)
set(gca,'xlim',[0 100])
xlabel('Frequency (Hz)'), ylabel('Attenuation (log)')
title('Frequency response of filter (firls)')


%% effects of the filter transition width

% range of transitions
transwidths = linspace(.01,.4,10);


% initialize
fkernX = zeros(length(transwidths),1000);
hz = linspace(0,srate,1000);

figure(3), clf
for ti=1:length(transwidths)
    
    % create filter kernel
    frex  = [ 0 frange(1)-frange(1)*transwidths(ti) frange(1) frange(2) frange(2)+frange(2)*transwidths(ti) nyquist ] / nyquist;
    fkern = firls(400,frex,shape);
    n(ti) = length(fkern);

    % take its FFT
    fkernX(ti,:) = abs(fft(fkern,1000)).^2;
    
    % show in plot
    subplot(211), hold on
    plot((1:n(ti))-n(ti)/2,fkern+.01*ti,'linew',2)
end
xlabel('Time (ms)')
set(gca,'ytick',[])
title('Filter kernels with different transition widths')


subplot(223), hold on
plot(hz,fkernX,'linew',2)
plot(frex*nyquist,shape,'k','linew',4)
set(gca,'xlim',[0 100])
xlabel('Frequency (Hz)'), ylabel('Attenuation')
title('Frequency response of filter (firls)')


subplot(224)
plot(hz,10*log10(fkernX),'linew',2)
set(gca,'xlim',[0 100])
xlabel('Frequency (Hz)'), ylabel('Attenuation (log)')
title('Frequency response of filter (firls)')







