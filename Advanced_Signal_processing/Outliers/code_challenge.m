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

win = 0:.5:20;
rms_ts = zeros(length(win),n);

for wi = 1:length(win)
    k = round(n * wi/2/100);
    for ti=1:n
        
        % boundary points   
        low_bnd = max(1,ti-k);
        upp_bnd = min(n,ti+k);
        
        % signal segment (and mean-center!)
        tmpsig = signal(low_bnd:upp_bnd);
        tmpsig = tmpsig - mean(tmpsig);
        
        % compute RMS in this window
        rms_ts(wi,ti) = sqrt(sum( tmpsig.^2 ));
    end

end


% plot RMS
figure(2), clf, hold on
time = 0:1:2000;
imagesc(time,win,rms_ts)
clim([20 100])
colormap hot
xlim([0 2000])
ylim([2 20])














