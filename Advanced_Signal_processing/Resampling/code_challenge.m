clear,clf

load resample_codeChallenge.mat
whos

figure(1),clf
plot(time,signal,'ks-')
hold on
plot(origT,origS,'r')

% find NAN
% interpolation
% excessive noise burst(outlier detection-RMS)
% spectral interpolation
% resample to regularly spaced

%% NAN
s = signal;
nans = isnan(signal);
t = 1:numel(signal);

s(nans) = interp1(t(~nans),s(~nans),t(nans),'linear');

figure(2),clf
plot(signal,'ks-', 'linew',3)
hold on
plot(s+0.5,'r','linew',3) % offset for better visualization with the solution
legend({'With NaNs';'Without NaNs'})
title('Dealing with NaNs')

%% detect bad segments using rms( small window used to detect energy)

pct_win = 1.1;
k = round(size(s,1)*pct_win/2/100);

rms_ts = zeros(1,size(s,1));
for ti=1:size(s,1)
      % boundary points
     low_bnd = max(1,ti-k);
     upp_bnd = min(size(s,1),ti+k);

    % signal segment (and mean-center!)
     tmpsig = s(low_bnd:upp_bnd);
     tmpsig = tmpsig - mean(tmpsig);

    % compute RMS in this window
     rms_ts(ti) = sqrt(sum( tmpsig.^2 ));
end


% plot RMS
figure(3), clf, hold on
subplot(211)
plot(rms_ts,'s-')

thresh = 100;

signalR = s;
signalR(rms_ts>thresh) =NaN; %compare energy of signal with threshold

subplot(212)
plot(signalR,'r')

%% Spectral Interpolation
indbeg = []; indend = [];
for i = 2: size(signalR,1)-1
    if isnan(signalR(i))  && ~isnan(signalR(i-1))
        indbeg = [indbeg i];
    elseif isnan(signalR(i)) && ~isnan(signalR(i+1))
        indend = [indend i];
    end
end


        
filtsig = signalR;
 
% I assume each empty window has a beginning and an end
% for i = 2: length(indbeg)
%     fftPre = fft(signalR(indbeg(i)-diff([indbeg(i) indend(i)])-1:indbeg(i)-1));
%     fftPst = fft(signalR(indend(i)+1:indend(i)+diff([indbeg(i) indend(i)])+1));
% 
%     mixeddata = detrend(ifft((fftPre + fftPst)/2));
% 
%     linedata = linspace(0,1,diff([indbeg(i) indend(i)])+1)'*(signalR(indend(i)+1)-signalR(indbeg(i)-1)) + signalR(indbeg(i)-1);
%     
%     linterp = mixeddata + linedata;
% 
%     filtsig(indbeg(i):indend(i)) = linterp;
% end



for i = 1: length(indbeg)
    % FFTs of pre- and post-window data
     fftPre = fft(signalR( indbeg(i)-diff([indbeg(i) indend(i)])-1:indbeg(i)-1) );
     fftPst = fft(signalR( indend(i)+1:indend(i)+diff([indbeg(i) indend(i)])+1) );
    % interpolated signal is a combination of mixed FFTs and straight line
     mixeddata = detrend(ifft( ( fftPre+fftPst )/2 ));
    % formula for a line: x*m +b
    % m (slope: 1st valid point after the missing data chunk - first valid point before the missing point)
    % b (offset: first point)
     linedata = linspace(0,1,diff([indbeg(i) indend(i)])+1)'*(signalR(indend(i)+1)-signalR(indbeg(i)-1)) + signalR(indbeg(i)-1);
    % sum together for final result
     linterp = mixeddata + linedata;
    % put the interpolated piece into the signal
    %filtsig = signal;
     filtsig(indbeg(i):indend(i)) = linterp;
end
 
figure(5), clf
plot(1:length(signalR),[signal signalR filtsig+8],'linew',2)
legend({'Original';'With gap';'Filtered (+ offset)'})
zoom on

%% Resample regularly spaced

%% Resample to regularly spaced
% With the derivative of the time vector we see that data is not regularly spaced data
% plot(diff(time)*1000)
% To interpolate, we choose the highest frequency (minimum time)
new_fs =1/min(diff(time));
npnts = new_fs*time(end);
new_time = (0:npnts-1)/new_fs;

%method 1
% F = griddedInterpolant(time,filtsig','linear');
% interp_s = F(new_time);

%method 2
interp_s = interp1(time,filtsig',new_time,'linear');
 
figure(6)
plot(time, filtsig, 'k', 'linew',3)
hold on
plot(new_time, interp_s+0.3,'r','linew',3)
legend({'Irregular srate';'Regular srate+offset'})



