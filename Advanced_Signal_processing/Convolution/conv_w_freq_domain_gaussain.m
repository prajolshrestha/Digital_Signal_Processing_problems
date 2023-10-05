clear, clf
%% Narrow-band filter
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

%% Create frequency domain Gaussain

peakf = 11; %change gardai herne
fwhm = 5.2;

%vector of frequencies
hz = linspace(0,srate,n);

%freq- domain Gaussian
s = fwhm*(2*pi-1)/(4*pi); % normalized width
x = hz - peakf; %shifted frequencies
fx = exp(-.5*(x/s).^2); % gaussian


figure(1), clf

% plot Gaussian kernel
plot(hz,fx,'k','linew',2)
set(gca,'xlim',[0 30])
ylabel('Gain')
title('Frequency-domain Gaussian')
%% Now for convolution

%fft
dataX = fft(signal);

%ifft
convres = 2*real(ifft(dataX .* fx));

hz = linspace(0,srate,n);

%% plot

figure(2), clf, hold on

% lines
plot(time,signal,'r')
plot(time,convres,'k','linew',2)

% frills
xlabel('Time (s)'), ylabel('amp. (a.u.)')
legend({'Signal';'NRROW BAND filtered'})
title('Narrowband filter')

figure(3),clf
% plot Gaussian kernel
subplot(5,1,1)
plot(hz,fx,'k','linew',2)
set(gca,'xlim',[0 30])
ylabel('Gain')
title('Frequency-domain Gaussian')
% raw and filtered data spectra
subplot(5,1,2:5),hold on
plot(hz,abs(dataX).^2,'rs-','markerfacecolor','w','markersize',13,'linew',2)
plot(hz,abs(dataX.*fx).^2,'bo-','linew',2,'markerfacecolor','w','markersize',8)

% frills
xlabel('Frequency (Hz)'), ylabel('Power (a.u.)')
legend({'Signal';'Convolution result'})
title('Frequency domain')
set(gca,'xlim',[0 25])


















