clear,clf
%% signal

time = linspace(-4*pi,16*pi,1000);
signal = sin(time)./time + linspace(1,-1,length(time));

%plot
figure(1),clf,hold on
plot(time,signal,'k')
xlabel('Time')
set(gca,'XLim',time([1 end]),'YLim',[min(signal) max(signal)]*1.1)

% find global maximum
[maxval,maxidx] = max(signal);
plot(time(maxidx),maxval,'ko','MarkerFaceColor','g')

%% different methods

%local min
range4max = [0 5];
rangeidx = dsearchn(time',range4max');

[maxLval,maxLidx] = min(signal(rangeidx(1):rangeidx(2)));
plot(time(maxLidx+rangeidx(1)-1), maxLval,'ko')

%local maxima
peeks1 = find(diff(sign(diff(signal)))<0)+1;
plot(time(peeks1),signal(peeks1),'ro')

%local maxima in detrended signal
peeks2 = find(diff(sign(diff(detrend(signal))))<0)+1;
plot(time(peeks2),signal(peeks2),'bs')

%matlab function
[~,peeks3] = findpeaks(signal);
plot(time(peeks3),signal(peeks3),'gp')








