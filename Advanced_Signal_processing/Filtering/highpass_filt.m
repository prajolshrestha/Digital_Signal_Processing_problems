clear, clf
%% Generate signal + noise

%% Noise creation
N = 8000;
fs = 1000;

as = rand(1,N) .* exp(-(0:N-1)/200);%decaying random noise
fc = as .* exp(1i*2*pi*rand(size(as)));%random fourier coeff
noise = real(ifft(fc)) * N;

figure(1),clf
subplot(3,3,1)
plot(rand(1,N))
title('rand(1,N)')

subplot(332)
plot(exp(-(0:N-1)/200))
title('exp(-(0:N-1)/200)')
subplot(333)
plot(as)
title('as (Decaying Random Num.')

subplot(334)
plot(exp(1i*2*pi*rand(size(as))))
title('complex plane (unit (random) phase vector)')

subplot(335)
plot(fc)
title('as * complex plane = fc')

subplot(336)
plot(real(ifft(fc)))
title('real(ifft(fc))')

subplot(3,3,[7,8,9])
plot(noise)
title('Noise')

%% Signal Generation

hz = linspace(0,fs,N);
s = 4 *(2*pi-1)/(4*pi); %normalized width
x = hz - 30; % shifted frequencies
fg = exp(-.5*(x/s).^2); %gaussain

fc = rand(1,N) .* exp(1i*2*pi*rand(1,N)); %fourier coeff
fc = fc .* fg;
signal = real(ifft(fc)) * N;

% plot signal 
figure(2), clf
subplot(2,2,1)
plot(fg)
title('Gaussian')
xlim([0 600])

subplot(2,2,2)
plot(fc)
title('random fourier coeff')

subplot(2,2,[3,4])
plot(signal)
title('Signal')
%% Data

data = signal + noise;
time = (0:N-1)/fs;

% plot data
figure(3),clf
subplot(2,1,1)
plot(time,data)
title('original data = signal + noise')

subplot(212), hold on
plot(hz,abs(fft(signal)/N).^2)
plot(hz,abs(fft(noise)/N).^2)
legend({'Signal';'Noise'})
xlim([0 100])
title('Fdomain')

%% build filter kernel(butter) and test with impulse 

filtcut = 25;

[b,a] = butter(7,filtcut/(fs/2),'high');

%test impulse response function
impulse = [zeros(1,500) 1 zeros(1,500)];
fimpulse = filtfilt(b,a,impulse);
imptime = (0:length(impulse)-1)/fs;

figure(4),clf
subplot(321)
plot(imptime,impulse,imptime,fimpulse./max(fimpulse))
legend({'Impulse';'Impulse Response'})

subplot(322),hold on
hz = linspace(0,fs/2,3000);
imppow = abs(fft(fimpulse,2*length(hz))).^2;
plot(hz,imppow(1:length(hz)));
ylim([0 1])
xlim([0 60])
plot([1 1]*filtcut,get(gca,"YLim"),'r--')

%% filtering using butterworth (IIR filter)

fdata = filtfilt(b,a,data);

figure(5),clf
subplot(211)
plot(time,signal,time,fdata)
legend({'signal';'Filtered data'})
title('time domain')

subplot(212)
hz = linspace(0,fs,N);
plot(hz,abs(fft(data)/N).^2,hz,abs(fft(fdata)/N).^2)
legend({'Data(signal+noise)';'Filtered data(only signal)'})
xlim([0 100])
title('F domain')

































