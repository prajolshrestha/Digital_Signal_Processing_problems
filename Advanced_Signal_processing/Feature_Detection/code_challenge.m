clear,clf
%% smooth signal without loosing info and upsample

%generate asymetric distribution
stretch = .5;
[fx,x] = hist(exp( stretch*randn(10000,1)),150);

%normalize necessary here!
fxNorm = fx ./ max(fx);

figure(1),clf, hold on
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

%% smoothing

fwhmg = 15; 

%normalized time vector in indices
k = 2;
gtime = -k:k;

%create gaussian window
gauswin = exp(- (4*log(2)*gtime.^2) / fwhmg^2);
gauswin = gauswin / sum(gauswin);

%initialize filtered signal vector
fxSmoothed = zeros(size(fx));

%implement the weighted running mean filter
for i = k+1:length(fx)-k-1
    fxSmoothed(i) = sum(fx(i-k:i+k).*gauswin);
end

plot(x,fxSmoothed,'b',LineWidth=4)

%% upsample
npnts = length(fxSmoothed);

upsampleFactor = 6;
newNpnts = npnts*upsampleFactor;
newX = linspace(x(1),x(end),newNpnts);
newX(newX>x(end)) = [];

%define interpolation object
F = griddedInterpolant(x,fxSmoothed,'linear');
upXI = F(newX);
upXINorm = upXI ./ max(upXI);

plot(newX,upXI,'rs-')

%% ploting

%find peak
peakpnt = find( upXINorm == max(upXINorm));
prepeak = dsearchn(upXINorm(1:peakpnt)',.5);
pstpeak = dsearchn(upXINorm(peakpnt:end)',.5);
pstpeak = peakpnt + pstpeak - 1;

%find fwhm
fwhmEs = newX(pstpeak) - newX(prepeak);

%plot
plot(newX(peakpnt),upXI(peakpnt),'ro',MarkerFaceColor='r',MarkerSize=10)
plot(newX(pstpeak),upXI(pstpeak),'go',MarkerFaceColor='b',MarkerSize=10)
plot(newX(prepeak),upXI(prepeak),'ro',MarkerFaceColor='b',MarkerSize=10)


plot(newX([prepeak pstpeak]),upXI([prepeak pstpeak]),'k--')
plot([1 1]*newX(prepeak), [0 upXI(prepeak)],'k:')
plot([1 1]*newX(pstpeak), [0 upXI(pstpeak)],'k:')

title(['Empherical FWHM: ' num2str(fwhmE),'Empherical new FWHM: ' num2str(fwhmEs)])


















