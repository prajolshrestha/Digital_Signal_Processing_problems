clear,clf
%% define filter parameter and create filter kernel

samprate = 2048;

lower_bnd = 10;
upper_bnd = 60;

trans = .1;

filtorder = 8*round(samprate/lower_bnd);

filter_shape = [0 0 1 1 0 0 ];

filter_freqs = [ 0 lower_bnd*(1-trans) ...
                lower_bnd upper_bnd ...
                upper_bnd*(1+trans) (samprate/2)] / (samprate/2);

filterkern = firls(filtorder,filter_freqs,filter_shape);
hz = linspace(0,samprate/2,floor(length(filterkern)/2)+1);
filterpow = abs(fft(filterkern)).^2;

figure(1),clf
subplot(221)
plot(filterkern)
title('Filter kernel (firls)')

subplot(222),hold on
plot(hz,filterpow(1:length(hz)))
plot(filter_freqs*samprate/2,filter_shape)
xlim([0 100])
legend({'Actual';'Ideal'})
title('Freq. response')

%conclusion: this filter is vary bad!

%% generate white noise signal
N = samprate*4;
noise = randn(N,1);
timevec = (0:length(noise)-1)/samprate;

%% better filter (using two staged wide band filter)

% 1. High pass filter

forder = 14*round(samprate/lower_bnd);
filtkern = fir1(forder,lower_bnd/(samprate/2),'high');

%fft
subplot(212),hold on
hz = linspace(0,samprate/2,floor(length(filtkern)/2)+1);
filterpow = abs(fft(filtkern)).^2;
plot(hz,filterpow(1:length(hz)),'k')

% zerophase shift filtering with reflection
noiseR = [noise(end:-1:1); noise; noise(end:-1:1)]; %reflect
fnoise = filter(filtkern,1,noiseR);
fnoise = filter(filtkern,1,fnoise(end:-1:1));
fnoise = fnoise(end:-1:1);
fnoise = fnoise(N+1:end-N);


%2. Low pass filter
forder = 20*round(samprate/upper_bnd);
filtkern = fir1(forder,upper_bnd/(samprate/2),'low');

%fft
hz = linspace(0,samprate/2,floor(length(filtkern)/2)+1);
filterpow = abs(fft(filtkern)).^2;
plot(hz,filterpow(1:length(hz)),'r')
plot(repmat([lower_bnd upper_bnd],2,1),repmat([0; 1],1,2),'k--')
set(gca,'xlim',[0 upper_bnd*2])
title('Two staged wide band filter')


% zerophase shift filtering with reflection
noiseR = [fnoise(end:-1:1); fnoise; fnoise(end:-1:1)]; %reflect
fnoise = filter(filtkern,1,noiseR);
fnoise = filter(filtkern,1,fnoise(end:-1:1));
fnoise = fnoise(end:-1:1);
fnoise = fnoise(N+1:end-N);

%shortcut
%fnoise = filtfilt(filtkern,1,fnoise);
%% plotting

figure(2), clf
subplot(211)
plot(timevec,noise,timevec,fnoise)
legend({'Noise';'Filtered'})


subplot(212)
noisepow = abs(fft(noise)).^2;
fnoisepow = abs(fft(fnoise)).^2;
hz =linspace(0,samprate,length(fnoise));
plot(hz,noisepow,hz,fnoisepow)
xlim([0 upper_bnd*1.5])
legend({'noise power'; 'Filtered noise power'})










