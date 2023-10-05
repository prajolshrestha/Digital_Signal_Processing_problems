clear
%% create data

%create event (derivative of gaussian)
k = 100; %duration of event
x = linspace(-2,2,k+1);
event = diff(exp( -x.^2));
event = event./max(event); %normalize to max = 1

figure(1), clf
plot(event)
title('one Event')

% event onset times
Nevents = 30;
onsettimes = randperm(10000-k);
onsettimes = onsettimes(1:Nevents);%starting point of event

% put event into data
data = zeros(1,10000);
for ei = 1:Nevents
    data(onsettimes(ei):onsettimes(ei)+k-1) = event;
end

figure(2), clf,hold on
subplot(211)
plot(data)
title('Data')

%add noise to data
data = data + .5*randn(size(data));

subplot(212)
plot(data)
title('Data + noise')

%plot one event

figure(3),clf
plot(1:k, data(onsettimes(3):onsettimes(3)+k-1),...
    1:k, event)
legend({'One event with noise';'Ground-Truths'})

%% Extract all events into matrix

datamatrix = zeros(Nevents,k);

for ei = 1:Nevents
    datamatrix(ei,:) = data(onsettimes(ei):onsettimes(ei)+k-1);
end

figure(4), clf
subplot(4,1,1:3)
imagesc(datamatrix)
title('All events')

subplot(414)
plot(1:k, mean(datamatrix),...
    1:k,event)
legend({'Averaged';'Ground-Truths'})
title('Average events')

figure(5),clf
plot(1:k, datamatrix(11,:),1:k,event)
legend({'11th event in noisy signal';'original event'})