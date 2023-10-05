%% butter
srate = 1024;
frange = [20 45];
nyquist = srate/2;

[b,a] = butter(4,[20,45]/nyquist);% b = original signal ko value , a = prev. value of already filtered signal

filtpow = abs(fft(b)).^2;
hz = linspace(0,srate/2,floor(length(b)/2)+1);

figure(1),clf,hold on
subplot(231),hold on
plot(b*1e5,'ks-')
plot(a,'rs-')
legend({'B';'A'})
title('Time domain filter')

subplot(232),hold on
stem(hz,filtpow(1:length(hz)),'ks-');
title('Power spectrum freq')



%% filter

%impulse
impulse = [zeros(1,500) 1 zeros(1,500)];

%impulse response
impulse_res = filter(b,a,impulse);

%fft
impulse_resX = abs(fft(impulse_res)).^2;
hz = linspace(0,nyquist,floor(length(impulse_res)/2)+1);

subplot(234),cla,hold on
plot(impulse,'k')
plot(impulse_res,'r')
legend({'impulse';'Impulse response'})
xlim([1 length(impulse_res)])
ylabel([-0.06 0.06])
title('Filtering an impulse')


subplot(235), hold on
plot(hz,impulse_resX(1:length(hz)),'ks-','linew',2,'markerfacecolor','w','markersize',10)
plot([0 frange(1) frange frange(2) nyquist],[0 0 1 1 0 0],'r','linew',4)
set(gca,'xlim',[0 100])
legend({'Freq response';'Ideal filter'})
xlabel('Frequency (Hz)'), ylabel('Attenuation')
title('Frequency response of filter (Butterworth)')

subplot(236),hold on
plot(hz,10*log10(impulse_resX(1:length(hz))))
xlim([0 100])
title('Frequency response (db)')


%% effects of order parameter

orders = 2:7;

fkernX = zeros(length(orders),1001);
hz = linspace(0,srate,1001);
n = zeros(length(orders),1);

figure(2), clf
for oi=1:length(orders)
    
    % create filter kernel
    [fkernB,fkernA] = butter(orders(oi),frange/nyquist);
    n(oi) = length(fkernB);
    
    % filter the impulse response and take its power
    fimp         = filter(fkernB,fkernA,impulse_res);
    fkernX(oi,:) = abs(fft(fimp)).^2;
    
    
    % show in plot
    subplot(221), hold on
    plot((1:n(oi))-n(oi)/2,zscore(fkernB)+oi,'linew',2)
    
    subplot(222), hold on
    plot((1:n(oi))-n(oi)/2,zscore(fkernA)+oi,'linew',2)
end

% add plot labels
subplot(221)
xlabel('Time points')
title('Filter coefficients (B)')

subplot(222)
xlabel('Time points')
title('Filter coefficients (A)')


% plot the spectra
subplot(223), hold on
plot(hz,fkernX,'linew',2)
plot([0 frange(1) frange frange(2) nyquist],[0 0 1 1 0 0],'r','linew',4)
set(gca,'xlim',[0 100])
xlabel('Frequency (Hz)'), ylabel('Attenuation')
title('Frequency response of filter (Butterworth)')

% in log space
subplot(224)
plot(hz,10*log10(fkernX),'linew',2)
set(gca,'xlim',[0 100],'ylim',[-80 2])
xlabel('Frequency (Hz)'), ylabel('Attenuation (log)')
title('Frequency response of filter (Butterworth)')





