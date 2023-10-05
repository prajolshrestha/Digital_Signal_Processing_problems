clear, clf
%% Irregular sampled data

srate = 1324;
peakfreq = 7;
fwhm = 5;
npnts = srate*2;
timevec = (0:npnts-1)/srate;

%freq
hz = linspace(0,srate,npnts);
s = fwhm*(2*pi-1)/(4*pi); %normalized width
x = hz - peakfreq; %shifted freq
fg = exp(-.5*(x/s).^2); %gaussian

%Fourier coeff of random spectrum
fc = rand(1,npnts) .* exp(1i*2*pi*rand(1,npnts));

%taper with gaussian
fc = fc .* fg;

% go back to time domain to get signal
signal = 2*real(ifft(fc))*npnts;


figure(1),clf,hold on
plot(timevec,signal,'k')
xlabel('Time')

%% now randomly sample from this "continuous" time series

%initialize
sampSig = [];

%random sampling intervals
sampintervals = cumsum([1; ceil(exp(4*rand(npnts,1)))]);
sampintervals(sampintervals>npnts) = []; %remove points beyond the data


%loop through sampling points and "measure" data
for i=1:length(sampintervals)
    %real world measurement
    nextdat = [signal(sampintervals(i)); timevec(sampintervals(i))];

    %put in data matrix
    sampSig = cat(2,sampSig,nextdat);
end

plot(sampSig(2,:),sampSig(1,:),'ro')

%% upsample to original sampling rate

F = griddedInterpolant(sampSig(2,:),sampSig(1,:),'spline');
newsignal = F(timevec);

plot(timevec,newsignal,'ms')
legend({'Analog';'Measured';'Upsampled'})












