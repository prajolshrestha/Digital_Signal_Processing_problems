load emg4TKEO.mat

% initialize filtered signal
emgf = emg;

% loop version for interpretability
for i = 2:length(emgf)-1
    emgf(i) = emg(i)^2 - emg(i-1)*emg(i+1);
end

%vectorized form for speed and elegence
emgf2 = emg;
emgf2(2:end-1) = emg(2:end-1).^2 - emg(1:end-2).*emg(3:end);

%% convert both signal into zscore

%find timepoint zero
time0 = dsearchn(emgtime',0);%The dsearchn function returns the index of the element in emgtime' that is closest to 0.

%convert original emg into zscore from time-zero
emgz = (emg-mean(emg(1:time0))) / std(emg(1:time0));

% same for filtered emg
emgzf = (emgf-mean(emgf(1:time0))) / std(emgf(1:time0));
%emgzf = (emgf-mean(emgf)) / std(emgf);
%% plot
figure(1), clf

% plot raw (normalized to max-1)
subplot(211),hold on
plot(emgtime, emg./max(emg),'b','LineWidth',2)
plot(emgtime, emgf./max(emgf),'m','linewidth',2)

xlabel('time (ms)'), ylabel('Amplitude or energy')
legend({'EMG'; 'EMG energy (TKEO)'})

%plot
subplot(212), hold on
plot(emgtime,emgz,'b','LineWidth',2)
plot(emgtime,emgzf,'m','Linewidth',2)
