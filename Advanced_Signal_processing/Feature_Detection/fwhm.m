clear,clf
%% 
% Gaussian

srate = 1000;
time = -2:1/srate:2;
fwhmA = .93; % seconds

gauswin = exp(-(4*log(2)*time.^2) / fwhmA^2);
gauswinNorm = gauswin ./ max(gauswin);

figure(1),clf, hold on
plot(time,gauswin,'k',LineWidth=3)

%find peak point
peakpnt = find(gauswin == max(gauswin));

%find 50% PRE peak point
prepeak = dsearchn(gauswinNorm(1:peakpnt)',.5);

%find 50% Post peak point
pstpeak = dsearchn(gauswinNorm(peakpnt:end)',.5);
pstpeak = pstpeak + peakpnt -1; % adjust

%compute empirical FWHM
fwhmE = time(pstpeak) - time(prepeak);

plot(time(peakpnt),gauswin(peakpnt),'ro',MarkerFaceColor='r',MarkerSize=10)
plot(time(pstpeak),gauswin(pstpeak),'go',MarkerFaceColor='g',MarkerSize=10)
plot(time(prepeak),gauswin(prepeak),'go',MarkerFaceColor='g',MarkerSize=10)

plot([1 1]*time(prepeak),[0 gauswinNorm(prepeak)],'k:')
plot([1 1]*time(pstpeak),[0 gauswinNorm(pstpeak)],'k:')
plot(time([prepeak pstpeak]),gauswinNorm([prepeak pstpeak]),'k--')
xlabel('Time (s)')
title(['Analytic: ' num2str(fwhmA) ',emprical: ' num2str(fwhmE)])

%% example with asymetric shape

%generate asymetric distribution
stretch = .5;
[fx,x] = hist(exp( stretch*randn(10000,1)),150);

%normalize necessary here!
fxNorm = fx ./ max(fx);

figure(2),clf, hold on
plot(x,fx,'ks-',linewidth=3,markerfacecolor='w')

%find peak
peakpnt = find( fxNorm == max(fxNorm));
prepeak = dsearchn(fxNorm(1:peakpnt)',.5);
pstpeak = dsearchn(fxNorm(peakpnt:end)',.5);
pstpeak = peakpnt + pstpeak - 1;

%find fwhm
fwhmE = x(pstpeak) - x(prepeak);

%plot
plot(x(peakpnt),fx(peakpnt),'ro',MarkerFaceColor='r',MarkerSize=10)
plot(x(pstpeak),fx(pstpeak),'go',MarkerFaceColor='g',MarkerSize=10)
plot(x(prepeak),fx(prepeak),'ro',MarkerFaceColor='g',MarkerSize=10)


plot(x([prepeak pstpeak]),fx([prepeak pstpeak]),'k--')
plot([1 1]*x(prepeak), [0 fx(prepeak)],'k:')
plot([1 1]*x(pstpeak), [0 fx(pstpeak)],'k:')

title(['Empherical FWHM: ' num2str(fwhmE)])


%% intresting aside

%a range standard deviations
sds = linspace(.1,.7,50);
fwhmE = zeros(size(sds));

for i = 1:length(sds)
    % new data
    [fx,x] = hist(exp(sds(i)*randn(10000,1)),150);

    %normalization necessary here!
    fxNorm = fx ./ max(fx);

    %find peaks
    peakpnt = find(fxNorm == max(fxNorm));
    prepeak = dsearchn(fxNorm(1:peakpnt)',.5);
    pstpeak = dsearchn(fxNorm(peakpnt:end)',.5);
    pstpeak = peakpnt + pstpeak -1;

    %fwhm
    fwhmE(i) = x(pstpeak(1)) - x(prepeak(1));
   
end

figure(3),clf
plot(sds,fwhmE,'s-')
xlabel('Stretch Parameter')
ylabel('FWHM E')

















