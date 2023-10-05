clear , clf
%% Narrowband filtering ( convolve(signal,morlet))

%% create signal 
%parameters
srate = 4352; %hz
npnts = 8425;
time = (0:npnts-1)/srate;
hz = linspace(1,srate/2,floor(npnts/2)+1);

%pure noise signal
signal = exp(.5*randn(1,npnts));

%fft
signalX = 2*abs(fft(signal));

%plot
figure(1),clf,hold on
subplot(211)
plot(time,signal,'k')
title('time domain')

subplot(212)
plot(hz,signalX(1:length(hz)),'k')
set(gca,'xlim',[1 srate/6],'YLim',[0 350])
title('Freq domain')

%% create wavelet

%wavelet parameters
ffreq = 34;
timevec = -3:1/srate:3;
fwhm = .12;
morwav = cos(2*pi*ffreq*timevec) .* exp( -(4*log(2)*timevec.^2)/fwhm.^2);

%fft
wavehz = linspace(1,srate/2,floor(length(timevec)/2)+1);
morwavX = abs(fft(morwav));

figure(2),clf
subplot(211)
plot(timevec,morwav,'k')
xlim([-.6 .6])
title('Morlet wavelet in time domain')

subplot(212)
plot(wavehz,morwavX(1:length(wavehz)))
xlim([0 70])
title('Morlet wavelet in freq domain')

%% Convolution

convres = conv(signal,morwav,'same');
convresX = 2*abs(fft(convres));

%plot
figure(1)
subplot(211),hold on
plot(time,convres,'r') %we see filtered signal is really large in amplitude than original signal

subplot(212),hold on
plot(hz,convresX(1:length(hz)))

%problem: morlet wavelet is not normalized!
%1. time domain ma difficult
%2. freq domain ma easy

%% manual convolution
nconv = npnts+ length(timevec) - 1;
halfw = floor(length(timevec)/2)+1;

%spectrum of wavelet
morwavX = fft(morwav,nconv);
morwavX = morwavX ./ max(morwavX); %normalize

convres = ifft(morwavX .* fft(signal,nconv));
convres = real(convres(halfw:end-halfw+1));

%plot
figure(1)
subplot(211)
plot(time,convres,'b')

subplot(212)
convresX = 2*abs(fft(convres));
plot(hz,convresX(1:length(hz)),'b')

figure(2)
subplot(212)
wavehz_norm = linspace(0,srate/2,floor(nconv/2)+1);
plot(wavehz_norm,abs(morwavX(1:length(wavehz_norm))))
xlim([0,70])

%% to preserve DC offset, compute and add back

convres = convres + mean(signal);

figure(1)
subplot(211)
plot(time,convres,'m')
legend({'original';'filtered (no normalize)';'Filtered (norm.)';'Filteres(norm and mean added)'})

%% hilbert transfom to see spectrum envelop
% Hilbert transform in signal processing is a way to 
% convert a real-valued signal into an analytic signal

convres = convres - mean(signal);
hilbts = hilbert(convres);

figure(3)
plot(time,convres,time,abs(hilbts),'r')
title('Hilbert transform of result')









