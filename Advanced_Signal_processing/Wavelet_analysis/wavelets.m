clear, clf
%% Wavelets

% general simulation parameters
fs = 1024;
npnts = fs*5+1; %5 seconds (odd time vector for zero centered)

%centered time vector
timevec = (1:npnts)/fs;
timevec = timevec - mean(timevec);

%for pwr spectrum
hz = linspace(0,fs/2,floor(npnts/2)+1);

%% Morlet wavelet
% Morlet wavelets are frequently used for time-frequency analysis 
% of non-stationary time series data, such as neuroelectrical signals 
% recorded from the brain. 
% The crucial parameter of Morlet wavelets is the width of the Gaussian 
% that tapers the sine wave. This width parameter controls 
% the trade-off between temporal precision and frequency precision.
% It is typically defined as the “number of cycles,” but this parameter is opaque,
% and often leads to uncertainty and suboptimal analysis choices, 
% as well as being difficult to interpret and evaluate.

%parameters
freq = 4; %peak freuency
csw = cos(2*pi*freq*timevec);%cosine wave
fwhm = .5; %(fwhm increase gardai herne--> wavelet in time domain is wider and in f domain,its narrower)
gaussian = exp( -(4*log(2)*timevec.^2) / (fwhm^2));%gaussian

morletWavelet = csw .* gaussian;

%amplitude spectrum 
morletWaveletPow = abs(fft(morletWavelet)/npnts);

figure(1),clf
subplot(421)
plot(timevec,morletWavelet)
title('Morlet wavelet in time domain')

subplot(422)
plot(hz,morletWaveletPow(1:length(hz)))
xlim([0 12])
title('Morlet wavelet in freq. domain ')

%% Haar wavelet

HaarWavelet = zeros(npnts,1);
HaarWavelet(dsearchn(timevec',0):dsearchn(timevec',.5)) = 1;
HaarWavelet(dsearchn(timevec',.5):dsearchn(timevec',1-1/fs)) = -1;

%amplitude spectrum
HaarWaveletPow = abs(fft(HaarWavelet)/npnts);


subplot(423)
plot(timevec,HaarWavelet)
title('Haar wavelet in time domain')
ylim([-1.3 1.3])

subplot(424)
plot(hz,HaarWaveletPow(1:length(hz)))
xlim([0 12]),ylim([0 .2])
title('Haar wavelet in freq. domain ')

%% Maxican hat Wavelet

%wavelet
s = .4;
MaxicanWavelet = (2/(sqrt(3*s)*pi^.25)) .* (1- (timevec.^2)/(s^2)) .* exp((-timevec.^2) ./ (2*s^2));

MaxicanWaveletPow = abs(fft(MaxicanWavelet)/npnts);


subplot(425)
plot(timevec,MaxicanWavelet)
title('Maxican Hat wavelet in time domain')
ylim([-1.3 1.5])

subplot(426)
plot(hz,MaxicanWaveletPow(1:length(hz)))
xlim([0 12]),ylim([0 .4])
title('Maxican Hat in freq. domain ')


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

subplot(427)
plot(timevec,DoG)
title('DoG wavelet in time domain')
ylim([-1.3 4])

subplot(428)
plot(hz,DoGPow(1:length(hz)))
xlim([0 12]),ylim([0 .4])
title('DoG wavelet in freq. domain ')




















