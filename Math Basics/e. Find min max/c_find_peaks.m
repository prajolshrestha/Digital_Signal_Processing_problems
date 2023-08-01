%% Find local Maxima

% learn: max, dsearchn, diff, sign, detrend

%%

x = -4*pi : .01 : 16*pi;
fx = sin(x)./x + linspace(-1,1,length(x));

figure(1),clf
plot(x,fx,'k',LineWidth=2)

% global maxima
[maxval,maxidx] = max(fx);

hold on
plot(x(maxidx),fx(maxidx),'ro')

% local maxima is the global maxima in the restricted range


%% local maxima

peaks = find(diff(sign(diff(fx)))<0)+1;
plot(x(peaks),fx(peaks),'ro')


%% detrend and find local maxima

peaks = find(diff(sign(diff(detrend(fx))))<0)+1;
hold on
plot(x(peaks),fx(peaks),'bo')


%% shortcut

[~,peeks] = findpeaks(fx);
plot(x(peeks),fx(peeks),'bs')










