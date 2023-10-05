clear, clf
%% upsampling

% low sampling rate data to upsample

srate  = 10;
data = [1 4 3 6 2 19];
npnts = length(data);
time = (0:npnts-1)/srate;

%plot
figure(1),hold on
plot(time,data,'ko-','MarkerSize',15,'MarkerFaceColor','k','LineWidth',3);

%% option 1: Upsample by a factor

upsampleFactor = 4;
newNpnts = npnts*upsampleFactor;
newTime = (0:newNpnts-1)/(upsampleFactor*srate);

%option 2: upsample by desired frequency

newSrate = 37;
newNpnts = round(npnts * (newSrate/srate));
newTime = (0:newNpnts-1)/newSrate;

%% interpolation
% Method 1: griddedInterpolant()
newTime(newTime>time(end)) = [];%cut out extra time points
newSrateActual = 1/mean(diff(newTime));%new sampling rate

%define interpolation object
F = griddedInterpolant(time,data,'spline');

%query that object in requested time points
updateI = F(newTime);

plot(newTime,updateI,'rs-',MarkerSize=14,MarkerFaceColor='r')

% Method 2: Resample()

newSrate = 40;
[p,q] = rat(newSrate/srate);%2 value divide garda num ra denum k hunxa?
updateR = resample(data,p,q);
newTime = (0:length(updateR)-1)/newSrate;

updateR(newTime>time(end)) = [];
newTime(newTime>time(end)) = [];

plot(newTime,updateR,'b^-',MarkerSize=14,MarkerFaceColor='b')
legend({'Original';'Interpolated';'Resample'})
















