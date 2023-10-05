clear,clf
%% Create sinc filter
srate = 1000;
time = -4:1/srate:4;
pnts = length(time);

f = 8;
sincfilt = sin(2*pi*f*time) ./ time;

%adjust NaN and normalize filter to unit gain
sincfilt(~isfinite(sincfilt)) = max(sincfilt);
sincfilt = sincfilt ./ sum(sincfilt);

%% Create windowed sinc filtered

sincfiltW = sincfilt .* hann(pnts)';

%% fft
hz = linspace(0,srate/2,floor(pnts/2)+1);
sincfiltX = abs(fft(sincfilt));
sincfiltWX = abs(fft(sincfiltW));

%% plot
figure(1),clf
subplot(221)
plot(time,sincfilt)
title('Sinc function')

subplot(222)
plot(time,sincfiltW)
title(' Windowed sinc function')

subplot(223)
plot(hz,sincfiltX(1:length(hz)))
xlim([0,20]),ylim([10e-7 10])
set(gca,"YScale","log")

subplot(224)
plot(hz,sincfiltWX(1:length(hz)))
xlim([0 20])
set(gca,"YScale","log")
ylim([10e-7 10])

%% apply filter to noise

%generate data
data = cumsum(randn(pnts,1));

%reflection
datacat = [data; data(end:-1:1)];

%filtering
dataf = filter(sincfiltW,1,datacat);
dataf = filter(sincfiltW,1,dataf(end:-1:1));
dataf = dataf(end:-1:pnts+1); %flipped and remove reflection

%fft
hz = linspace(0,srate/2,floor(pnts/2)+1);
powOrig = abs(fft(data)/pnts).^2;
powFilt = abs(fft(dataf)/pnts).^2;

%plot
figure(2),clf
subplot(211)
plot(time,data,time,dataf)
legend({'Original signal';'Windowed sinc filtered'})

subplot(212),hold on
plot(hz,powOrig(1:length(hz)),hz,powFilt(1:length(hz)))
set(gca,'YScale','log','XLim',[0 40])
legend({'Original signal';'Windowed sinc filtered'})


%% Filter with different filters

sincfiltW = cell(3,1);

tapernames = {'Hann';'Hamming';'Gauss'};

%hann
%sincfiltW{1} = sincfilt .* hann(pnts)'; %shortcut
hannw = .5 - cos(2*pi*linspace(0,1,pnts))./2;
sincfiltW{1} = sincfilt .* hannw;



%hamming
%sincfiltW{2} = sincfilt .* hamming(pnts)'; %shortcut
hammingw = .54 - .46*cos(2*pi*linspace(0,1,pnts));
sincfiltW{2} = sincfilt .* hammingw;



%gaussian
sincfiltW{3} = sincfilt .* exp(-time.^2);

figure(3),clf
for i = 1:length(sincfiltW)
    %plot time
    subplot(211),hold on
    plot(time,sincfiltW{i})
    xlabel('Time (s)'), title('Time domain')

    %plot fft
    subplot(212),hold on
    pw = abs(fft(sincfiltW{i}));
    plot(hz,pw(1:length(hz)))
    set(gca,'xlim',[f-3 f+10],'YScale','lo','ylim',[10e-7 10])
    xlabel('Frequency (Hz)'), ylabel('Gain')
    title('Frequency domain')


end
legend(tapernames)















