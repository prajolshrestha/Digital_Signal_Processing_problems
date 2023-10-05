clear, clf
%% Downsample

%% laplace distribution
srate = 100;
tv = -5:1/srate:5;
npnts = length(tv);

laplace= 1-exp(-abs(tv));
fastsine = .25*sin(2*pi*tv*15);

%combine into one signal
signal  = laplace + fastsine;

%fft 
hzo = linspace(0,srate/2,floor(npnts/2)+1);
signalo_pow = abs(fft(signal)/npnts).^2;
signalo_pow = signalo_pow(1:length(hzo));

figure(1),clf
subplot(211)
plot(tv,signal,'ko-')
title('Time domain')

subplot(212)
plot(hzo,signalo_pow,'ko-')
title('Freq domain')
set(gca,'xlim',[0 50],'YScale','log')

%% downsample 
% Option 1: downsample by a factor

dnsampleFactor = 4;
newSrate = srate/dnsampleFactor;
newTv = -5:1/newSrate:5;
newPnts = length(newTv);

% 1.1: Downsample without lowpass filter (bad idea!)
signal_dsB = signal(1:dnsampleFactor:end);

hz_ds = linspace(0,newSrate/2,floor(newPnts/2)+1);
signal_dsB_pow = abs(fft(signal_dsB)/newPnts).^2;
signal_dsB_pow = signal_dsB_pow(1:length(hz_ds));

% 1.2: Downsample with lowpass filter (Good idea!)
fkern = fir1(14*newSrate/2, (newSrate/2)/(srate/2));
fsignal = filtfilt(fkern,1,signal);

signal_dsG = fsignal(1:dnsampleFactor:end);

signal_dsG_pow = abs(fft(signal_dsG)/newPnts).^2;
signal_dsG_pow = signal_dsG_pow(1:length(hz_ds));

fsignal_pow = abs(fft(fsignal)/npnts).^2;
fsignal_pow = fsignal_pow(1:length(hz_ds));


% plot in the time domain
subplot(211), hold on
plot(newTv,.02+signal_dsB,'m^-','markersize',8,'markerfacecolor','m')
plot(newTv,.04+signal_dsG,'gs-','markersize',8,'markerfacecolor','g')
legend({'Original';'DS bad';'DS good'})

% plot in the frequency domain
subplot(212), hold on
plot(hz_ds,signal_dsB_pow,'m^-','linew',1,'markerfacecolor','m','markeredgecolor','m')
plot(hz_ds,signal_dsG_pow,'gs-','linew',1,'markerfacecolor','g','markeredgecolor','g')



%% Shortcut

[p,q] = rat(newSrate/srate);
signal_dsM = resample(signal,p,q);
signal_dsM_pow = abs(fft(signal_dsM)/newPnts).^2;
signal_dsM_pow = signal_dsM_pow(1:length(hz_ds));

% and plot it.
subplot(211)
plot(newTv,.06+signal_dsM,'rs-','markersize',8,'markerfacecolor','r')

subplot(212)
plot(hz_ds,signal_dsM_pow,'rs-','linew',1,'markerfacecolor','r','markeredgecolor','r')
legend({'Original';'DS bad';'DS good';'Reshape function'})















