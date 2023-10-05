clear, clf
%% time frequency analysis

%% data
equake = load('Solomon_Time_History.txt');

times = equake(:,1);
equake = equake(:,2);

srate = round(1./mean(diff(times)));

%plot
figure(1),clf
subplot(211)
plot(times/60/60,equake)
xlabel('Time')
title('Time domain')

subplot(212)
winsize = srate*60*10;%window size of 10 min
pwelch(equake,winsize,winsize/10,[],srate);


%% complex morlet wavlet

%parameters
numFrex = 40;
minFreq = 2;
maxFreq = srate/2;
npntsTF = 1000;

%frequencies in Hz
frex = linspace(minFreq,maxFreq,numFrex);

%wavelet widths (FWHM)
fwhms = linspace(5,15,numFrex)';

%time points to save
tidx = round(linspace(1,length(times),npntsTF));

%setup wavlets length and convolution parameters
wavet = (-10:1/srate:10);
halfw = floor(length(wavet)/2);
nConv = length(times) + length(wavet) - 1;

%create family of morlet wavlets
cmw = zeros(length(wavet),numFrex);

%loop over frequencies and create wavlets
for fi = 1:numFrex
    cmw(:,fi) = exp(1i*2*pi*frex(fi)*wavet) .* exp(-(4*log(2)*wavet.^2)/fwhms(fi).^2);

end

%plot
figure(2),clf
imagesc(wavet,frex,abs(cmw)')
xlabel('Time')
ylabel('Frequency')
set(gca,'ydir','normal')

%% convolution

%lets extract two sets of features

%initialize time-frequency matrix 
[tf,tfN] = deal( zeros(length(frex),length(tidx)));

%normalize to entire time window
basetidx = dsearchn(times, [-1000 0]');
basepow = zeros(numFrex,1);

%spectrum of data
dataX = fft(equake,nConv);

%loop over frequencies
for fi = 1: numFrex
    %create wavelet
    waveX = fft(cmw(:,fi),nConv);
    waveX = waveX ./ max(waveX); %normalize

    %convolve data and wavelet
    as = ifft(dataX .* waveX);
    as = as(halfw:end-halfw);
    
    %power time course at this frequency
    powts = abs(as) .^ 2;

    %baseline (pre-quake)
    basepow(fi) = mean(powts(basetidx(1):basetidx(2)));

    tf(fi,:) = 10*log10(powts(tidx));
    tfN(fi,:) = 10*log10(powts(tidx)/basepow(fi));

end

% plot time freq maps
% "raw" power
figure(3), clf
subplot(211)
contourf(times(tidx),frex,tf,40,'linecolor','none')
xlabel('Time'), ylabel('Frequency (Hz)')
title('Time-frequency plot')
set(gca,'clim',[-150 -70])

% pre-quake normalized power
subplot(212)
contourf(times(tidx),frex,tfN,40,'linecolor','none')
xlabel('Time'), ylabel('Frequency (Hz)')
title('Time-frequency plot (Normalized by baseline)')
set(gca,'clim',[-1 1]*15)

% normalized and non-normalized power

figure(4), clf

subplot(211)
plot(frex,mean(tf,2),'ks-','linew',2,'markersize',10,'markerfacecolor','w')
xlabel('Frequency (Hz)'), ylabel('Power (10log_{10})')
title('Raw power')


subplot(212)
plot(frex,mean(tfN,2),'ks-','linew',2,'markersize',10,'markerfacecolor','w')
xlabel('Frequency (Hz)'), ylabel('Power (norm.)')
title('Pre-quake normalized power')



























