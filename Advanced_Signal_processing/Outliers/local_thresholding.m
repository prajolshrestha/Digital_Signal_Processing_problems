clear,clf
%% Data
load forex.mat
N = length(forex);
time = (0:N-1)'/N;

%plot
figure(1),clf,hold on
plot(time,forex)
xlabel('Time'),ylabel('EUR/USD')

%% Global Threshold
plot(get(gca,'xlim'),[1 1]*(mean(forex)+3*std(forex)),'r--')
plot(get(gca,'xlim'),[1 1]*(mean(forex)-3*std(forex)),'k--')
legend({'EUR/USD';'M+3std';'M-3std'})

%% local threshold

%window size as percent of total  signal length
pct_win = 20; %in percentage %change gardai herne

%convert to indices
k = round(length(forex)*pct_win/2/100); %half kernel jasto

%initialize
mean_ts = ones(size(time)) * mean(forex);
std3_ts = ones(size(time)) * std(forex);

for i = 1:N
    %boundries
    lo_bnd = max(1,i-k);
    up_bnd = min(i+k,N);

    %compute local mean and std
    mean_ts(i) = mean(forex(lo_bnd:up_bnd));
    std3_ts(i) = 2*std(forex(lo_bnd:up_bnd));
end

%plot
figure(2),clf,hold on

h = patch([time; time(end:-1:1)],[mean_ts+std3_ts; mean_ts(end:-1:1)-std3_ts(end:-1:1)],'m');

plot(time,forex,'k')

%compute local outliers
outliers = forex > (mean_ts + std3_ts) | forex < (mean_ts-std3_ts);

plot(time(outliers),forex(outliers),'ro')
legend({'Mean +/- 3std';'EUR/USD';'Outliers'})
set(h,'linestyle','none','facealpha',.4)
xlabel('Time (year)'), ylabel('EUR/USD')
title([ 'Using a ' num2str(pct_win) '% window size' ])









