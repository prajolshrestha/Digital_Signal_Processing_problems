clear,clf
%% define filter parameters and construct filter kernel
samprate = 2048; %hz

lower_bnd = 10; %hz
upper_bnd = 18;

lower_trans = .1;
upper_trans = .1; %try changing

filtorder = 14*round(samprate/lower_bnd);%try changing

filter_shape = [0 0 1 1 0 0];
filter_freqs = [0 lower_bnd*(1-lower_trans) ...
                lower_bnd upper_bnd...
                upper_bnd*(1+upper_trans) (samprate/2)] / (samprate/2);

filterkern = firls(filtorder,filter_freqs,filter_shape);%filter kernel
hz = linspace(0,samprate/2,floor(length(filterkern)/2)+1);
filtpow = abs(fft(filterkern)).^2;

figure(1),clf
subplot(2,2,1)
plot(filterkern)
title('Filter kernel(firls)')

subplot(2,2,2),hold on
plot(hz,filtpow(1:length(hz)))
plot(filter_freqs*samprate/2,filter_shape)
xlim([0,40])
legend({'Actual';'Ideal'})
title('Freq. Response(firls)')


%% filtering

filtnoise = filtfilt(filterkern,1,randn(samprate*14,1));
timevec = (0:length(filtnoise)-1)/samprate;

subplot(2,4,5:7)
plot(timevec,timevec,filtnoise)
title('Filtered noise in time domain')

subplot(2,4,8)
noisepower = abs(fft(filtnoise)).^2;
plot(linspace(0,samprate,length(noisepower)),noisepower)
xlim([0 30])



