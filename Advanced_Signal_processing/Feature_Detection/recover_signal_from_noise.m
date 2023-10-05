clear,clf
%% create signal

srate = 1000;
time = 0:1/srate:3;
n = length(time);
p = 20; %poles for random interpolation

%amplitude modulator and noise level
ampmod = interp1(rand(p,1)*30,linspace(1,p,n),'nearest')';
signal = ampmod .* randn(size(ampmod));


figure(1),clf
subplot(211)
plot(time,signal,time,ampmod,'LineWidth',2)
xlabel('Time'),ylabel('Amplitude')
legend({'Signal';'Source'})

%% options for identifying original signal

subplot(212)

% method 1: Rectify and lowpass filter
rectsig = abs(signal);
k = 9;
rectsig = filtfilt(ones(1,k)/k,1,rectsig);
plot(time,rectsig,time,ampmod,'LineWidth',2)
legend({'Estimated';'True'})

% Method 2: TKEO
tkeosig = signal;
tkeosig(2:end-1) = signal(2:end-1).^2 - signal(1:end-2).*signal(3:end);
plot(time,tkeosig,time,ampmod,LineWidth=2)
legend({'Estimated';'True'})

% Method 3: Magnitude of Hilbert Transform
maghlib = abs(hilbert(signal));

%running mean filter
k = 9;
maghlib = filtfilt(ones(1,k)/k,1,maghlib);
plot(time,maghlib,time,ampmod,LineWidth=2)
legend({'Estimated';'True'})

% Method 4: Running Variance
k = 9;
runningVar = zeros(n,1);
for i= 1:n
    startp = max(1,i-k);
    endp = min(i+k,n);
    runningVar(i) = std(signal(startp:endp)); 
end
plot(time,runningVar,time,ampmod,LineWidth=2)
legend({'Estimated';'True'})

%plot all options
figure(2),clf,hold on
plot(time,rectsig,'b','LineWidth',2)
plot(time,maghlib,'r','LineWidth',2)
plot(time,runningVar,'g','LineWidth',2)
%plot(time,tkeosig,'k','LineWidth',2)
plot(time,ampmod,'k','LineWidth',2)
legend({'Rectified';'Hilbert';'Running variance';'True data'})

%% Compare different algorithm with ground truth

%rectify
r2rect = corrcoef(ampmod,rectsig);
r2rect = r2rect(2)^2;

% TKEO
r2tkeo = corrcoef(ampmod,tkeosig);
r2tkeo = r2tkeo(2)^2;

% Hilbert
r2hilb = corrcoef(ampmod,maghlib);
r2hilb = r2hilb(2)^2;

%Variance
r2varr = corrcoef(ampmod,runningVar);
r2varr = r2varr(2)^2;

% plot
figure(3),clf
bar([r2rect r2hilb r2tkeo r2varr])
ylabel('R^2 fit to truth')
title('Comparision of methods')
set(gca,'xtick',1:4,'xticklabel',{'Rectify';'Hilbert';'TKEO';'Variance'})








































