clear,clf
%% signal
% generate signal with varying variability
n = 2000;
p = 15; % poles for random interpolation

% amplitude modulator
signal = interp1(randn(p,1)*3,linspace(1,p,n),'pchip');
signal = signal + randn(1,n);

% add some high-amplitude noise
signal(200:220)   = signal(200:220) + randn(1,21)*9;
signal(1500:1600) = signal(1500:1600) + randn(1,101)*9;


% plot
figure(1), clf, hold on
plot(signal)

%% detect bad segments using sliding RMS

%win size
pct_win = 2;
%convert to incides
k = round(n * pct_win/2/100);

rms_ts = zeros(1,n);


for ti=1:n
    
    % boundary points
    low_bnd = max(1,ti-k);
    upp_bnd = min(n,ti+k);
    
    % signal segment (and mean-center!)
    tmpsig = signal(low_bnd:upp_bnd);
    tmpsig = tmpsig - mean(tmpsig);
    
    % compute RMS in this window
    rms_ts(ti) = sqrt(sum( tmpsig.^2 ));
end



% plot RMS
figure(2), clf, hold on
plot(rms_ts,'s-')


% pick threshold manually based on visual inspection
thresh = 15;
plot(get(gca,'xlim'),[1 1]*thresh,'r')
legend({'Local RMS';'Threshold'})

%pick threshold manually
thresh = 15;
plot(get(gca,'xlim'),[1 1]*thresh,'r')
legend({'local RMS';'Threshold'})

%mark bad regions
signalR = signal;
signalR(rms_ts>thresh) = NaN;

figure(1)
plot(signalR,'r')















