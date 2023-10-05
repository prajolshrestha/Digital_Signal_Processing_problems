load spectral_codeChallenge.mat

figure(1),clf,hold on
subplot(211)
plot(time,signal)
title('Time domain')

[powspect,frex,timed] = spectrogram(signal,hann(1000),500,[],srate);
subplot(212)
imagesc(time,frex,(abs(powspect).^2))
set(gca,'ylim',[1 40],'xlim',[-3 3]);
axis xy
colormap hot

%% welch method
load spectral_codeChallenge.mat

winlen = srate;
noverlap = round(srate/2);
N = length(signal);
winonsets = 1:noverlap:N-winlen;
hzw = linspace(0,srate/2,floor(winlen/2)+1);

hannw = 0.5 - cos(2*pi*linspace(0,1,winlen))./2;

result = zeros(length(winonsets),length(hzw));

for i= 1:length(winonsets)
    win = signal(winonsets(i):winonsets(i)+winlen-1);

    win = win .* hannw;

    tempw = abs(fft(win)/winlen).^2;

    result(i,:) = result(i,:) + tempw(1:length(hzw));
end

figure(2)
imagesc(time,hzw,result')
axis xy
xlim([-3,3])
xticks(-3:0.5:3)
ylim([0, 40])
colormap hot
