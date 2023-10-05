%% Generate multispectral noisy signal
srate = 1234; % in hz
npnts = srate*2; % 2 seconds
time = (0:npnts-1)/srate; % in seconds

% frequencies to include
frex = [12 18 30];

signal = zeros(size(time));

for i = 1:length(frex)
    signal = signal + i*sin(2*pi*frex(i)*time);
end

%add some noise
signal = signal + randn(size(signal));

figure(1),clf
plot(time,signal)
title('time domain')

%% Spectral Analysis

%FFT
signalX = fft(signal);
% Magnitude
signalAmp = 2*abs(signalX)/npnts;
%freqency vector
hz = linspace(0,srate/2,floor(npnts/2)+1);
%hz = linspace(0,srate,npnts); %shortcut

figure(2),clf
subplot(211)
plot(hz,real(signalX(1:length(hz))))
title('Real Part')
subplot(212)
plot(hz,imag(signalX(1:length(hz))))
title('Imag part')

figure(3),clf
stem(hz,signalAmp(1:length(hz)))
title('Frequency domain')

% iFFT
figure(4),clf
plot(time,ifft(signalX))
title('iFFT')
