%% create signal
%generate random spikes

%number of spikes
n = 300;

% inter-spike intervels (exponential distribution for bursts)
isi = round(exp(rand(n,1))*10);

%genereate spike time series
spikets = 0;
for i = 1:n
    spikets(length(spikets)+isi(i)) = 1;
end

% plot
figure(1), clf, hold on

h = plot(spikets);
set(gca,'ylim',[0 1.01],'xlim',[0 length(spikets)+1])
set(h, 'color',[1 1 1]*.7)
xlabel('Time')


%% create and implement gaussian window

fwhm = 15; %try different points(5---95)

%normalized time vector in indices
k = 100;
gtime = -k:k;

%create gaussian window
gauswin = exp(- (4*log(2)*gtime.^2) / fwhm^2);
gauswin = gauswin / sum(gauswin);

%% initialize filtered signal vector
filtsigG = zeros(size(spikets));

%implement the weighted running mean filter
for i = k+1:length(spikets)-k-1
    filtsigG(i) = sum(spikets(i-k:i+k).*gauswin);
end


plot(filtsigG)
legend({'Spikes','spike p.d.'})
title('Spikes and spike porbability density')

