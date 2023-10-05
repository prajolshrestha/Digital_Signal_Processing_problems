clear,clf
%% create windowed sinc filter
srate =1000;
time = -4:1/srate:4;
pnts = length(time);

%fft parameters
nfft = 10000;
hz = linspace(0,srate/2,floor(nfft/2)+1);

filtcut = 15;
sincfilt = sin(2*pi*filtcut*time) ./ time;

%adjust NaN and normalize
sincfilt(~isfinite(sincfilt)) = max(sincfilt);
sincfilt = sincfilt ./ sum(sincfilt);

% windowed sinc filter
hannw = .5 - cos(2*pi*linspace(0,1,pnts))./2;
sincfiltW = sincfilt .* hannw;

%spectrum of filter
sincX = 10*log10(abs(fft(sincfiltW,nfft)).^2);
sincX = sincX(1:length(hz));

%% create butterworth low pass filter

[b,a] = butter(5,filtcut/(srate/2),'low');

%test impulse response function
impulse = [zeros(1,500) 1 zeros(1,500)];
fimpulse = filtfilt(b,a,impulse);

%spectrum of filter response
butterX = 10*log10(abs(fft(fimpulse,nfft)).^2);
butterX = butterX(1:length(hz));

%% plot freq response


figure(1), clf, hold on
plot(hz,sincX,hz,butterX,'linew',2)
plotedge = dsearchn(hz',filtcut*3);
set(gca,'xlim',[0 filtcut*3],'ylim',[min([butterX(plotedge) sincX(plotedge)]) 5])
plot([1 1]*filtcut,get(gca,'ylim'),'k--','linew',2)

%find -3dB after filter edge
filtcut_idx = dsearchn(hz',filtcut);
sincX3dB = dsearchn(sincX',-3);
butterX3dB = dsearchn(butterX',-3);

plot([1 1]*hz(sincX3dB),get(gca,'ylim'),'b--','linew',2)
plot([1 1]*hz(butterX3dB),get(gca,'ylim'),'r--','linew',2)

%double freq
sincXoct = dsearchn(hz',hz(sincX3dB)*2);
butterXoct = dsearchn(hz',hz(butterX3dB)*2);

plot([1 1]*hz(sincXoct),get(gca,'ylim'),'b--','linew',2)
plot([1 1]*hz(butterXoct),get(gca,'ylim'),'r--','linew',2)

% find attenuation from that point to double ots frequency
sincXatten = sincX(sincX3dB*2);
butterXatten = butterX(butterX3dB*2);

sincXrolloff = (sincX(sincX3dB)-sincX(sincXoct)) / (hz(sincXoct)-hz(sincX3dB));
butterXrolloff = (butterX(butterX3dB)-butterX(butterXoct)) / (hz(butterXoct)-hz(butterX3dB));

% report!
title([ 'Sinc: ' num2str(sincXrolloff) ', Butterworth: ' num2str(butterXrolloff) ])
legend({'Windowed sinc';'Butterworth'})
xlabel('Frequency (Hz)'), ylabel('Gain (dB)')




