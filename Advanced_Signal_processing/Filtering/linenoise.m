clear, clf
%%load data
load lineNoiseData.mat

%time vector
pnts = length(data);
time = (0:length(data)-1)/srate;

figure(1),clf
subplot(211)
plot(time,data)

dataX = abs(fft(data)/pnts).^2;
hz = linspace(0,srate,pnts);
title('Time domain')

subplot(212)
plot(hz,dataX)
xlim([0 400]),ylim([0 2])
title('F domain')

%%filter

freqs = [50 150 250];
filt_data = data;

for i = 1:length(freqs)
    %filter kernel
    order = round(150*srate/freqs(1));
    fcut = [freqs(i)-.5 freqs(i)+.5]/(srate/2);
    fkern  = fir1(order,fcut,'stop');
 
    figure(2)
    subplot(length(freqs),2,(i-1)*2+1)
    xlabel('Time points'),ylabel('Filter amplitude')
    plot(fkern)
    set(gca,'ylim',[-0.5 1.2])

    subplot(length(freqs),2,(i-1)*2+2)
    plot(linspace(0,srate,10000),abs(fft(fkern,10000)).^2)
    set(gca,'xlim',[freqs(i)-30 freqs(i)+30],'ylim',[0 1.2])
    xlabel('Frequency'),ylabel('Filter gain')

    %filtering
    filt_data = filtfilt(fkern,1,filt_data);

end

%plot
figure(3),clf
subplot(211),hold on
plot(time,data,'k')
plot(time,filt_data)
xlabel('Time')
legend({'Original';'Notched'})

subplot(212),hold on
plot(hz,abs(fft(filt_data)/pnts).^2)
set(gca,'xlim',[0 400],'ylim',[0 2])
xlabel('Frequency (Hz)'), ylabel('Power')
title('Frequency domain')





















