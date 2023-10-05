clear,clf
%% code challange

load SNRdata.mat

figure(1),clf
subplot(211)
plot(timevec,mean(eegdata,3),'LineWidth',3)
xlabel('Time'),ylabel('Voltage')
legend({'chan_1';'chan_2'})
title('Average time series')

subplot(212)
plot(timevec,std(eegdata,[],3),'LineWidth',3)
xlabel('Time'),ylabel('Voltage')
legend({'chan_1';'chan_2'})
title('STD')

snR = mean(eegdata,3) ./ std(eegdata,[],3);
figure(2),clf
plot(timevec,10*log10(snR),'linewidth',3)
xlabel('Time'),ylabel('SNR log')
legend({'chan_1';'chan_2'})
title('SNR')


%% SNR at a point

%pick time point
timepoint = 375;
basetime = [-500 0];

%average over repetation
erp = mean(eegdata,3);

%snr components
snr_num = erp(:,dsearchn(timevec',timepoint));
snr_den = std(erp(:,dsearchn(timevec',basetime(1)):dsearchn(timevec',basetime(2))));

for i = 1:2
    disp(['SNR at ' num2str(timepoint) 'ms in channel' num2str(i) '= ' num2str(snr_num(i)./snr_den(i))])
end

figure(3),clf
plot(timevec,erp(1,:))
%% challange: What is the effect of temporal filtering on SNR at 375?
%low pass filter(cut off 4-31 hz) and compute SNR of erp
% see at what cutoff, SNR starts to stay constant(ie, no imp info lost)

erp = double(erp);

%lets make low pass filter
n = 50;
fcutoff = linspace(3,32,n);
transw = .2;
shape = [1 1 0 0];
fs = 1000;
order = round(4*fs/4);

fkern = zeros(order+1,length(fcutoff));

for i = 1:length(fcutoff)
    frex = [0 fcutoff(i) fcutoff(i)+fcutoff(i)*transw fs/2]/(fs/2);
    fkern(:,i) = firls(order,frex,shape);
    %fkern(:,i) = fir1(order,fcutoff(i)/fs,"low");
end

%Filter the signal
r_erp = cat(2,flip(erp),erp, flip(erp)); %reflection

filtered_erp1 = zeros(length(fcutoff),length(r_erp));
filtered_erp2 = zeros(length(fcutoff),length(r_erp));

for i = 1:length(fcutoff)
    filtered_erp1(i,:) = filtfilt(fkern(:,i),1,r_erp(1,:));
    filtered_erp2(i,:) = filtfilt(fkern(:,i),1,r_erp(2,:));
end

%truncate
filtered_erp1 = filtered_erp1(:,length(erp):length(erp)+length(erp)-1);
filtered_erp2 = filtered_erp2(:,length(erp):length(erp)+length(erp)-1);

% compute SNR

snr1 = zeros(n,1);
snr2 = zeros(n,1);

snr_num1 = filtered_erp1(:,dsearchn(timevec',timepoint));
snr_num2 = filtered_erp2(:,dsearchn(timevec',timepoint));

snr_den1 = filtered_erp1(:,dsearchn(timevec',basetime(1)):dsearchn(timevec',basetime(2)));
snr_den2 = filtered_erp2(:,dsearchn(timevec',basetime(1)):dsearchn(timevec',basetime(2)));

for i = 1:n
    snr1(i) = snr_num1(i) ./ std(snr_den1(i,:));
    snr2(i) = snr_num2(i) ./ std(snr_den2(i,:));
end
figure(4),clf,hold on
plot(fcutoff,snr1,'ks-',LineWidth=2)
plot(fcutoff,snr2,'rs-',LineWidth=2)
ylim([6 20])
xlim([4 32])
xlabel('low pass filter(cutoff)')
ylabel('SNR')





















