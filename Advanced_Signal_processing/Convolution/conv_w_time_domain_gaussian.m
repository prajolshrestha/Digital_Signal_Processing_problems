clear, clf
%% 
% create signal

srate = 1000;
time = 0:1/srate:3;
n = length(time);
p = 15; %poles for random interpolation

% noise level, measured in standard deviation
noiseamp = 5;

% amplitude modulator and noise level
ampl = interp1(rand(p,1)*30,linspace(1,p,n));
noise = noiseamp * randn(size(time));
signal = ampl + noise;

%substract mean to eliminate DC
signal = signal - mean(signal);

%% create time domain gaussian 

fwhm = 25;
k = 100;
gtime = 1000*(-k:k)/srate; %noramalized time vector

%create normalized gaussian
gauswin = exp(-(4*log(2)*gtime.^2)/fwhm^2);
gauswin = gauswin / sum(gauswin);



figure(1), clf
subplot(211)
plot(time,signal)

subplot(212)
plot(gtime,gauswin)
title('Time domain')

%% Filter as time domain convolution

%initialize filtered signal
filtsigG = signal;

%running mean filter
for i = k+1:n-k-1
    %each point is weighted avg of surrounding points
    filtsigG(i) = sum(signal(i-k:i+k) .* gauswin);
end
%% repeat in frequency domain

%computze N's
nConv = n + 2*k+1 -1;

%FFT
dataX = fft(signal,nConv);
gausX = fft(gauswin,nConv);

%multiplication and then iFFT
convres = ifft(dataX .* gausX);

%cut wings
convres = convres(k+1:end-k);
%freq vector
hz = linspace(0,srate,nConv);

%% plot
figure(2),clf,hold on
plot(time,signal)
plot(time,filtsigG,LineWidth=2)
plot(time,convres)
legend({'Signal';'Mean Filtered';'Smothing Filtered done in freq. domain'})
title('Gaussian smoothing filter')


figure(3),clf
subplot(511)
plot(hz,abs(gausX).^2)
xlim([0 25])
title('Power spectrum of Gaussian')

subplot(5,1,[2:5]),hold on
plot(hz,abs(dataX).^2,'rs-')
plot(hz,abs(dataX .* gausX).^2,'bo-')
xlim([0 25])
xlabel('Frequency (Hz)'), ylabel('Power (a.u.)')
legend({'Signal';'Convolution result'})
title('Frequency domain')