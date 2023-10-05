clear
%% Create signal
n = 2000;
signal = cumsum(randn(n,1)); % Brownian noise = integrated white noise

% porportion (5%) of time points to replace with noise(spikes)
propnoise = .05;

% find noise points
noisepnts1 = randperm(n); % returns a vector containing a random permutation of the integers 1:N.
noisepnts = noisepnts1(1:round(n*propnoise));

% generate signal and replace points with noise
signal(noisepnts) = 50 + rand(size(noisepnts))*100;

%% Implement median
% use histogram to pick threshold
figure(1), clf
histogram(signal,100)
zoom on

% threshold
threshold = 18;

%find data values above threshold
suprathresh = find(signal>threshold); %finds indices

% initialize filtered signal
filtsig = signal;

% apply meadian filter
k = 20; %actual window size = k*2+1
for i = 1:length(suprathresh)
    % bound
    low_bound = max(1,suprathresh(i)-k);% index negative naaaos vanerw
    up_bound = min(suprathresh(i)+k,n); % index n vanda thulo nahos vanerw
    

    % compute median of surrounding points
    filtsig(suprathresh(i)) = median(signal(low_bound:up_bound));

end

% plot
figure(2),clf
plot(1:n,signal,1:n,filtsig,'LineWidth',2)
zoom on


