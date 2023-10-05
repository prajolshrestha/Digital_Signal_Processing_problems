clear,clf
%%
%create signal
srate = 1000;
time = 0:1/srate:3;
n = length(time);
p = 20; %poles for random interpolation

%amplitude modulater and noise level
signal = interp1(randn(p,1)*30,linspace(1,p,n),'spline')'.^2;
signal(signal<100) = 0;

figure(1),clf
plot(time,signal)



% %Test signal 
% signal = zeros(1,n);
% signal(dsearchn(time',1):dsearchn(time',2)-1) = 1;
% 
% figure(1),clf
% plot(time,signal)
%% demarcate each lobe

% threshold each time series
threshts = logical(signal);

% find islands
islands = bwconncomp(threshts);

%color each island
for li = 1:islands.NumObjects
    patch(time([islands.PixelIdxList{li}; islands.PixelIdxList{li}(end-1:-1:1)]), ...
        [signal(islands.PixelIdxList{li}); zeros(numel(islands.PixelIdxList{li})-1,1)],...
        rand(1,3));
end



%% Compute Area under the curve

auc = zeros(islands.NumObjects,1);

for li = 1:islands.NumObjects
    auc(li) = sum(signal(islands.PixelIdxList{li}));
end

auc = auc * mean(diff(time));

% add text on each curve
for li = 1:islands.NumObjects

    text(mean(time(islands.PixelIdxList{li})),...
        50 + max(signal(islands.PixelIdxList{li})),...
        num2str(round(auc(li),2)),...
        'HorizontalAlignment','center');
end











