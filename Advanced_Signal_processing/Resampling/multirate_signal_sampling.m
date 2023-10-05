clear,clf
%% multirate signal

%% data
[fs,timez,signals] = deal(cell(3,1));

%sampling rate 
fs{1} = 10;
fs{2} = 40;
fs{3} = 83;

for i = 1:3
    signals{i} = cumsum(sign(randn(fs{i},1)));
    timez{i} = (0:fs{i}-1)/fs{i};
end

figure(1),clf,hold on
color='kbr';
shape = 'os^';
for i = 1:3

    plot(timez{i},signals{i},[color(i) shape(i) '-'])
end
axlims= axis;
xlabel('Time')

%% Upsample to fastest frequency

[newSrate, whichIsFastest] = max(cell2mat(fs));
newNpnts = round(length(signals{whichIsFastest}) * (newSrate/fs{whichIsFastest}));
newTime = (0:newNpnts-1)/newSrate;

%interpolate
newsignals = zeros(length(fs),length(newTime));

for si = 1:length(fs)
    F = griddedInterpolant(timez{si},signals{si},'spline');
    newsignals(si,:) = F(newTime);

end

figure(2),clf,hold on
for si = 1:3
    plot(newTime,newsignals(si,:),[color(si) shape(si) '-'])
end




























