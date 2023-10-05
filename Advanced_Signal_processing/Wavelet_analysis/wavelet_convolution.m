clear, clf
%% wavelet convolution

% general simulation parameters
fs = 1024;
npnts = fs*5+1; %5 seconds (odd time vector for zero centered)

%centered time vector
timevec = (1:npnts)/fs;
timevec = timevec - mean(timevec);

%for pwr spectrum
hz = linspace(0,fs/2,floor(npnts/2)+1);

%% Morlet wavelet

%parameters
freq = 4; %peak freuency
csw = cos(2*pi*freq*timevec);%cosine wave
fwhm = .5; %(fwhm increase gardai herne--> wavelet in time domain is wider and in f domain,its narrower)
gaussian = exp( -(4*log(2)*timevec.^2) / (fwhm^2));%gaussian

morletWavelet = csw .* gaussian;

%amplitude spectrum 
morletWaveletPow = abs(fft(morletWavelet)/npnts);


%% Haar wavelet

HaarWavelet = zeros(npnts,1);
HaarWavelet(dsearchn(timevec',0):dsearchn(timevec',.5)) = 1;
HaarWavelet(dsearchn(timevec',.5):dsearchn(timevec',1-1/fs)) = -1;

%amplitude spectrum
HaarWaveletPow = abs(fft(HaarWavelet)/npnts);

%% Maxican hat Wavelet

%wavelet
s = .4;
MaxicanWavelet = (2/(sqrt(3*s)*pi^.25)) .* (1- (timevec.^2)/(s^2)) .* exp((-timevec.^2) ./ (2*s^2));

MaxicanWaveletPow = abs(fft(MaxicanWavelet)/npnts);



%% Difference of gaussian (DoG)
% approximation of Laplacian of Gaussian

%define sigmas
sPos = .1;
sNeg = .5; %wider shape in negative going gaussian

%create two gaussian
gaus1 = exp( (-timevec.^2) / (2*sPos^2)) / (sPos*sqrt(2*pi));
gaus2 = exp( (-timevec.^2) / (2*sNeg^2)) / (sNeg*sqrt(2*pi));

%difference
DoG = gaus1 - gaus2;

%amplitude spectrum
DoGPow = abs(fft(DoG)/npnts);

%% Convolve with random signal

%signal
signal = detrend(cumsum(randn(npnts,1)));

%convolve
morewav = conv(morletWavelet,signal,'same'); %order matters
haarwav = conv(HaarWavelet,signal,'same');
maxiwav = conv(MaxicanWavelet,signal,'same');
dogwav = conv(DoG,signal,'same');

%amplitude spectra
morewavX = abs(fft(morewav)/npnts);
haarwavX = abs(fft(haarwav)/npnts);
maxiwavX = abs(fft(maxiwav)/npnts);
DoGwavX = abs(fft(dogwav)/npnts);

%plot
figure(1),clf
subplot(5,1,1)
plot(timevec,signal)
title('Signal')

%convolved signal
subplot(5,1,2:3),hold on
plot(timevec, morewav)
plot(timevec, haarwav)
plot(timevec, maxiwav)
plot(timevec,dogwav)
legend({'Morvlet';'Haar';'Maxican Hat'})
title('convolved signal in time domain')


subplot(5,1,4:5),hold on
plot(hz, morewavX(1:length(hz)))
plot(hz, haarwavX(1:length(hz)))
plot(hz, maxiwavX(1:length(hz)))
plot(hz, DoGwavX(1:length(hz)))
legend({'Morvlet';'Haar';'Maxican Hat';'DoG'})
title('convolved signal in Freq. domain')
set(gca,'xlim',[0 40],'yscale','lo')









