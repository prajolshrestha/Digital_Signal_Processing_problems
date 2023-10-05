clear, clf
%%  DATA
%Taken from video 'Averaging multiple repetitions'

N = 10000; %total number of timepoints

%create event (Derivative of gaussian)
k = 100;
event = diff(exp(-linspace(-2,2,k+1).^2));
event = event ./ max(event); %normalize

% event onset times
Nevents = 30;
onsettimes = randperm(N/10-k); % 900 ota starting points
onsettimes = onsettimes(1:Nevents)*10; %30 ota event

% put event into data
data = zeros(1,N);
for ei = 1:Nevents
    data(onsettimes(ei):onsettimes(ei)+k-1) = event;
end

%add noise
data = data + 1*randn(size(data));

figure(1), clf
subplot(211)
plot(event)
title('Event (Derivative of Gaussian)')

subplot(212),hold on
plot(data)
plot(onsettimes,data(onsettimes),'ro')
title('Data with event + noise')

%% convolve with event (as template)

convres = conv(data,event,'same');

% plot
figure(2),clf
subplot(211), hold on
plot(convres)
title('Convolution (data,event)')
plot(onsettimes,convres(onsettimes),'o') % result ho , we dont know

%% Find a threshold
subplot(212)
hist(convres,N/20)

%pick a threshold based on histogram and visual inspection
thresh = -30;

%plot threshhold
subplot(211)
plot(get(gca,'xlim'),[1 1]*thresh,'k--')

%find local minima
thresh_ts = convres;
thresh_ts(thresh_ts>thresh) = 0;

%plot
figure(3),clf
plot(thresh_ts,'s-')
title('threshold vanda talako value bata local min nikalne')

% find local minima
localmin = find(diff(sign(diff(thresh_ts)))>0)+1;

figure(1)
subplot(212)
plot(localmin,data(localmin),'ks',MarkerFaceColor='m')

figure(2)
subplot(211)
plot(localmin,convres(localmin),'ks',MarkerFaceColor='m')

%% extract time series for windowing

%remove local minima that are too close to the edges
localmin(localmin < round(k/2)) = [];
localmin(localmin > N-round(k/2)) = [];

% initialize data matrix
datamatrix = zeros(length(localmin),k);

%enter data to matrix
for ei = 1:length(localmin)
    datamatrix(ei,:) = data(localmin(ei)-round(k/2):localmin(ei)+round(k/2)-1);
end

%plot
figure(4),clf
subplot(4,1,1:3)
imagesc(datamatrix)
xlabel('Time'),ylabel('Event number')
title('All events')

%averaged data
subplot(414)
plot(1:k,mean(datamatrix), ...
    1:k,event,'k')
legend({'Averaged';'Ground Truth'})
title('Average events')










