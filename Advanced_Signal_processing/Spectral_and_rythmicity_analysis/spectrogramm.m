clear
%% load data
%bird call sound
[bc,fs] = audioread("XC403881.mp3");

%lets hear it
%soundsc(bc,fs)

%% create time vector
n = length(bc);
time = (0:n-1)/fs;

%plot
figure(1),clf,hold on
subplot(211)
plot(time,bsxfun(@plus,bc,[.2 0]));
title('Time domain')

%% FFT
dataX = abs(fft(detrend(bc(:,1)))/n).^2;
hz = linspace(0,fs/2,floor(n/2)+1);

subplot(212)
plot(hz,dataX(1:length(hz)))
title('Frequency domain')

%% Spectogram

[sfft,frex,time] = spectrogram(detrend(bc(:,2)),hann(1000),100,[],fs);

figure(2),clf
imagesc(time,frex,abs(sfft).^2)
axis xy
set(gca,'clim',[0 1]*2,'ylim', frex([1 dsearchn(frex,15000)]),'xlim',time([1 end]))
xlabel('Time'),ylabel('Frequency')
colormap hot
