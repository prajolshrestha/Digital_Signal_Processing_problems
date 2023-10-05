clear,clf
%% create signal ,fft , plot
fs = 350;
timevec = (0:fs*7-1)/fs;
npnts = length(timevec);

yOrig = cumsum(randn(npnts,1)); %brownian noise
y = yOrig + 50*randn(npnts,1) + 40*sin(2*pi*50*timevec)';%brownian noise + white noise + sine wave

%fft and power spectrum
yX = abs(fft(y)/npnts).^2;
hz = linspace(0,fs/2,floor(npnts/2)+1);

% plot
figure(1),clf
subplot(211)
h = plot(timevec,y,timevec,yOrig);
set(h(1),'color',[1 1 1]*.7)
set(h(2),'linewidth',2)
xlabel('Time')
legend({'Measured';'Original'})
title('Time domain')


subplot(2,1,2)
plot(hz,yX(1:length(hz)))
%set(gca,"YScale","linear")
set(gca,"YScale","log")
title("F domain")

%% low pass filter kernel

fcutoff = 30;
transw = .2;
order = round(7*fs/fcutoff);

shape = [1 1 0 0];
frex = [0 fcutoff fcutoff+fcutoff*transw fs/2]/(fs/2);

%filter kernel
fkern = firls(order,frex,shape);

%power spectrum
fkernX = abs(fft(fkern,npnts)).^2;

figure(2),clf
subplot(321)
plot(fkern)
title('Filter kernel')

subplot(322),hold on
plot(frex*fs/2, shape, 'r')%expected
plot(hz,fkernX(1:length(hz)),'k')
title('Frequency response')
xlim([0 60])

%% filtering

filty = filtfilt(fkern,1,y);

%fft 
filtyX = abs(fft(filty)/npnts).^2;

yOrigX = abs(fft(y)/npnts).^2;


subplot(312),hold on
plot(timevec,y,'k',timevec,filty)
legend({'signal';'Filtered'})

subplot(313),hold on
plot(hz,yX(1:length(hz)))
plot(hz,filtyX(1:length(hz)))
legend({'signal';'Filtered'})
set(gca,'YScale','log')
xlim([0 fs/5])













