clear, clf
%% bandpass filter
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

%% create freq domain planck taper


hz = linspace(0,srate,n);

%edge decay, must be between 0 and .5
%best to leave at .5
eta = .15;

%fwhm 
fwhm = 13;
peakf = 20;

%convert fwhm into incides
np = round(2*fwhm*n/srate);
pt = 1:np;
%find center point index
fidx = dsearchn(hz',peakf);

%define left and right exponentials
zl = eta*(np-1) * (1./pt + 1./(pt-eta*(np-1)));
zr = eta*(np-1) * (1./(np-1-pt) + 1./((1-eta)*(np-1)-pt));
 
%create a taper
bounds = [floor(eta*(np-1))-mod(np,2) ceil((1-eta)*(np-~mod(np,2)))];%ceil(X) rounds each element of X to the nearest integer greater than or equal to that element.
plancktaper = [1./(exp(zl(1:bounds(1)))+1)...
                ones(1,diff(bounds)) ...
                1./(exp(zr(bounds(2):end-1))+1)
                ];

%put the taper inside zeros
px = zeros( size(hz) );
pidx = max(1,fidx-floor(np/2)+1 : fidx+floor(np/2)-mod(np,2));
px(pidx) = plancktaper(end-length(pidx)+1:end);


%% convolution

dataX = fft(signal);

convres = 2*real(ifft(dataX .* px));
hz = linspace(0,srate,n);


%% time-domain plot

figure(1), clf, hold on

% lines
plot(time,signal,'r')
plot(time,convres,'k','linew',2)

% frills
xlabel('Time (s)'), ylabel('amp. (a.u.)')
legend({'Signal';'Smoothed'})
title('Narrowband filter')


%%% frequency-domain plot

figure(2), clf

% plot Gaussian kernel
subplot(511)
plot(hz,px,'k','linew',2)
set(gca,'xlim',[0 peakf*2])
ylabel('Gain')
title('Frequency-domain Planck taper')


% raw and filtered data spectra
subplot(5,1,[2:5]), hold on
plot(hz,abs(dataX).^2,'rs-','markerfacecolor','w','markersize',13,'linew',2)
plot(hz,abs(dataX.*px).^2,'bo-','linew',2,'markerfacecolor','w','markersize',8)

% frills
xlabel('Frequency (Hz)'), ylabel('Power (a.u.)')
legend({'Signal';'Convolution result'})
title('Frequency domain')
set(gca,'xlim',[0 peakf*2])










