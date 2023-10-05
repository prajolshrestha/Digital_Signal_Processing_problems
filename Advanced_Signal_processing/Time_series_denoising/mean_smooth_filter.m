% create signal%%%%%%%%%%%%%%%%%%%%%%%%%%%
srate = 1000;
time = 0:1/srate:3
n = length(time)
p = 15 %poles for random interpolation

% noise level, measured in standard deviations
noiseamp = 5

% amplitude modulator and noise level
ampl = interp1(rand(p,1)*30, linspace(1,p,n)) %signal

noise = noiseamp * randn(size(time)) %noise

signal = ampl + noise %noisy signal



%% % Running mean filter %%%%%%%%%%%%%%%

% initialize filtered signal vector
filtsig = zeros(size(signal)); %ignore edge effect
%filtsig = signal; 

% implement filter
k = 20 %filter window is actually k*2+1
for i = k+1:n-k-1 %from 21 to 2080
    % each point is average of k surrounding points
    surrounding_signal = signal(i-k:i+k);
    filtsig(i) = mean(surrounding_signal);
end

% compute window size in ms
windowsize = 1000*(k*2+1) / srate;

% plot noisy and filtered signals
figure(1), clf, hold on
plot(time,signal,time,filtsig,'LineWidth',2)

% draw a patch to indicate the window size
tidx = dsearchn(time',1);
ylim = get(gca,'ylim');
patch(time([tidx-k tidx-k tidx+k tidx+k]), ylim([1 2 2 1]),'k','facealpha',.2)
plot(time([tidx tidx]),ylim,'k--')







