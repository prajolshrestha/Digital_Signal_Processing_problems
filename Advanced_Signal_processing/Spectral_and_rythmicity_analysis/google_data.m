% data
data = readmatrix('multiTimeline.csv');
data1 = data(:,2);
n = length(data1);

%normalization
%method 1
%data1 = detrend(data1); %visual info lost

%method 2
data1 = data1 - mean(data1);

%FFT
dataPow = abs(fft(data1)/n).^2;
hz = linspace(0,233,n);

%plot
figure(1), clf
subplot(211)
plot(data1,'ko-')
title('Time domain (2004-2023)')

subplot(212)
plot(212)
plot(hz,dataPow,'ms-')
set(gca,'xlim',[0,6])
