clear,clf
%% data
load wavelet_codeChallenge.mat
whos

timevec = (0:length(signal)-1)/srate;

%plot
figure(1),clf
subplot(311)
plot(timevec,signal)
title('Original Signal')

subplot(312),hold on
plot(timevec,signalFIR)
plot(timevec,signalMW)
legend({'FIR-Filterd';'Morlet wavelet filtered'})
title('Filtered Signal')

subplot(313),hold on
hz = linspace(0,srate/2,floor(length(timevec)/2)+1);
signalFIRX = abs(fft(signalFIR));
signalMWX = abs(fft(signalMW));
plot(hz,signalFIRX(1:length(hz)))
plot(hz,signalMWX(1:length(hz)))
xlim([0,20])
legend({'FIR-Filterd';'Morlet wavelet filtered'})
title('Amplitude Spectra')


%% self code

%% FIR Filter
lower_bnd = 9; %hz
upper_bnd = 17;

lower_trans = .1;
upper_trans = .1; %try changing

filtorder = 14*round(srate/lower_bnd);%try changing

filter_shape = [0 0 1 1 0 0];
filter_freqs = [0 lower_bnd*(1-lower_trans) ...
                lower_bnd upper_bnd...
                upper_bnd*(1+upper_trans) (srate/2)] / (srate/2);

filterkern = firls(filtorder,filter_freqs,filter_shape);%filter kernel
hz = linspace(0,srate/2,floor(length(filterkern)/2)+1);
filtpow = abs(fft(filterkern)).^2;

figure(2),clf
subplot(2,2,1)
plot(filterkern)
title('Filter kernel(firls)')

subplot(2,2,2),hold on
plot(hz,filtpow(1:length(hz)))
plot(filter_freqs*srate/2,filter_shape)
xlim([0,40])
legend({'Actual';'Ideal'})
title('Freq. Response(firls)')

filtnoise = filtfilt(filterkern,1,signal);
timevec = (0:length(filtnoise)-1)/srate;

% subplot(2,4,5:7)
% plot(timevec,filtnoise)
% title('Filtered noise in time domain')

subplot(2,4,5:8)
noisepower = abs(fft(filtnoise));
plot(linspace(0,srate,length(noisepower)),noisepower)
xlim([0 30])



%% Morlet filter

%wavelet parameters
ffreq = 14;
timevec = -3:1/srate:3;
fwhm = .12;
morwav = cos(2*pi*ffreq*timevec) .* exp( -(4*log(2)*timevec.^2)/fwhm.^2);

%fft
wavehz = linspace(1,srate/2,floor(length(timevec)/2)+1);
morwavX = abs(fft(morwav));

figure(3),clf
subplot(221)
plot(timevec,morwav,'k')
xlim([-.6 .6])
title('Morlet wavelet in time domain')

subplot(222)
plot(wavehz,morwavX(1:length(wavehz)))
xlim([0 40])
title('Morlet wavelet in freq domain')

nconv = length(signal)+ length(timevec) - 1;
halfw = floor(length(timevec)/2)+1;

%spectrum of wavelet
morwavX = fft(morwav,nconv);
morwavX = morwavX ./ max(morwavX); %normalize

convres = ifft(morwavX .* fft(signal,nconv));
convres = real(convres(halfw:end-halfw+1));

%plot
% subplot(241)
% plot(time,convres,'b')

subplot(2,4,5:8)
convresX = 2*abs(fft(convres));
plot(hz,convresX(1:length(hz)),'b')

figure(4)
subplot(212)
wavehz_norm = linspace(0,srate/2,floor(nconv/2)+1);
plot(wavehz_norm,abs(morwavX(1:length(wavehz_norm))))
xlim([0,70])








