clear,clf
%% data with outlier
N = 10000;
time = (1:N)/N;
signal = exp(.5*randn(N,1));

%add some random outliers
nOutliers = 50;
randpnts = randi(N, [nOutliers,1]);
signal(randpnts) = rand(nOutliers,1) * range(signal) * 10;

%plot
figure(1),clf,hold on
plot(time,signal,'ko-')

%% auto threshold based  on mean and std
threshold = mean(signal) + 3*std(signal);
plot(time([1 end]), [1 1]*threshold,'k--')


%% interpolate outlier points

%remove supra- threshold points
outliers = signal > threshold;

%interpolate missing points
F = griddedInterpolant(time(~outliers),signal(~outliers));
signal(outliers) = F(time(outliers));

plot(time,signal,'ro-')
















