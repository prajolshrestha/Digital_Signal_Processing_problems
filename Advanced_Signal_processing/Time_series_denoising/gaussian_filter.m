% create signal%%%%%%%%%%%%%%%%%%%%%%%%%%%
srate = 1000
time = 0:1/srate:3
n = length(time)
p = 15 %poles for random interpolation

% noise level, measured in standard deviations
noiseamp = 5

% amplitude modulator and noise level
ampl = interp1(rand(p,1)*30, linspace(1,p,n)); %signal

noise = noiseamp * randn(size(time)); %noise

signal = ampl + noise; %noisy signal


%% create gaussian kernel

%full width half maximum: key gaussian parameter
fwhm = 25; % in ms

%normalized time vector in ms
k = 40;
gtime = 1000*(-k:k)/srate;

% create gaussian window
gauswin = exp( -(4*log(2)*gtime.^2) / fwhm^2);

%compute empherical FWHM
prePeakHalf = k + dsearchn(gauswin(k+1:end)',.5);
pstPeakHalf = dsearchn(gauswin(1:k)',.5);

empFWHM = gtime(prePeakHalf) - gtime(pstPeakHalf);

%show the gaussian 
figure(1), clf, hold on
plot(gtime, gauswin,'ko','MarkerFaceColor','w','LineWidth',2)
plot(gtime([prePeakHalf pstPeakHalf]), gauswin([prePeakHalf pstPeakHalf]),'m')

% normalize gaussian to unit energy
gauswin = gauswin / sum(gauswin);
title(['Gaussian kernel with requested FWHM ' num2str(fwhm) ' ms (' num2str(empFWHM) ' ms achieved)'])
xlabel('Time (ms)'), ylabel('Gain')

%% implement the filter

% initialize filtered signal vector
filtsigG = signal;
for i = k+1:n-k-1
    filtsigG(i) = sum(signal(i-k:i+k).*gauswin);
end

% plot
figure(2), clf, hold on
plot(time,signal,'r')
plot(time,filtsigG,'k','LineWidth',3)

xlabel('Time (ms)'),ylabel('amp. (a.u.)')
legend({'Original Signal';'Gaussian-filtered'})
title('Gaussain smotthing filter')

%% comparision with mean-smooth filter

filtersigMean = zeros(size(signal));
k = 20;
for i = k+1:n-k-1
    filtersigMean(i) = mean(signal(i-k:i+k));
end

plot(time,filtersigMean,'b')
legend({'Original signal';'Gaussian-filtered';'Mean  filtered'})

