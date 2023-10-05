clear,clf
%% 

pnts = 1000;
time = linspace(0,5*pi,pnts);

% one signal
signal1 = 3+sin(time);
signal1 = signal1 + randn(1,pnts);

% another signal
signal2 = 5 + randn(1,pnts) .* (2+sin(time));



% compute SNR in sliding windows
k = round(pnts*.05); % one-sided window is 5% of signal length

% initialize
[snr_ts1,snr_ts2] = deal( zeros(1,pnts) );

% loop over time points
for i=1:pnts
    
    % time boundaries
    bndL = max(1,i-k);
    bndU = min(pnts,i+k);
    
    % extract parts of signals
    sigpart1 = signal1(bndL:bndU);
    sigpart2 = signal2(bndL:bndU);
    
    % compute windowed SNR
    snr_ts1(i) = mean(sigpart1) / std(sigpart1);
    snr_ts2(i) = mean(sigpart2) / std(sigpart2);
end



%%% some plotting
% plot the signals
figure(1), clf
subplot(211), hold on
plot(time,signal1+10,'linew',3)
plot(time,signal2,'linew',3)
set(gca,'ytick',[])
xlabel('Time (rad.)')
legend({'Signal 1';'Signal 2'})

% plot SNRs
subplot(212), hold on
plot(time,snr_ts1,'linew',3)
plot(time,snr_ts2,'linew',3)
legend({'SNR 1';'SNR 2'})
xlabel('Time (rad.)')



% plot SNRs
figure(2), clf
subplot(211), hold on
plot(time,snr_ts1,'linew',3)
plot(time,snr_ts2,'linew',3)
legend({'SNR 1';'SNR 2'})
ylabel('"Raw" SNR units')
xlabel('Time (rad.)')


subplot(212), hold on
plot(time,10*log10(snr_ts1),'linew',3)
plot(time,10*log10(snr_ts2),'linew',3)
legend({'SNR 1';'SNR 2'})
ylabel('dB SNR units')
xlabel('Time (rad.)')

%% real data

load SNRdata.mat

figure(3),clf
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
figure(4),clf
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






















