clear,clf
%% Data
load EMGRT.mat
N = length(rts);

%example trials
trials2plot = [4 23];

figure(1),clf
%rts (button presses)
subplot(221)
plot(rts,'s-','MarkerFaceColor','w')
xlabel('Trials')
ylabel('Reaction times')
title('200 ota reaction time(rts)')

%histogram of rts
subplot(222)
histogram(rts,40)% this is log normal
xlabel('count')
ylabel('Reaction times')

subplot(212)
[~,sidx] = sort(rts,'descend');%sorted acc to dec. reaction time
plot(timevec,bsxfun(@plus,emg(sidx,:),(1:200)'*1500),'k')%bsxfun stacks each reaction time with 1500 offset in y axis
xlabel('Time'),yticks([])
axis tight

figure(2), clf
%two example trials
for i = 1:2
    subplot(2,1,i),hold on
    %plot EMG trace
    plot(timevec, emg(trials2plot(i),:),'r',LineWidth=1)
    %overlay button press time
    plot([1 1]*rts(trials2plot(i)),get(gca,'ylim'),'k--')

    xlabel('Time')
    legend({'EMG';'Button press'})
end
%% Detect EMG onset

% Define baseline timewindow for normalization
baseidx = dsearchn(timevec',[-500 0]');

%pick z threshold
zthresh = 100;

%initialize outputs
emgonsets = zeros(N,1);

%try printing one step first and go to for loop
for triali = 1:N
    % convert to energy via TKEO
    tkeo = emg(triali,2:end-1).^2 - emg(triali,1:end-2) .* emg(triali,3:end);

    %convert to zscore from pre-0 activity(zscore ralative to pre-stimulus baseline)
    tkeo = (tkeo - mean(tkeo(baseidx(1):baseidx(2)))) ./ std(tkeo(baseidx(1):baseidx(2)));
    
    % find first suprathreshold point
    tkeoThresh = tkeo>zthresh;
    tkeoThresh(timevec<0) = 0; 
    tkeoPnts = find(tkeoThresh);%Find indices and values of nonzero elements

    %grab the first suprathreshold point
    emgonsets(triali) = timevec(tkeoPnts(1));

end

%% plots

%back to EMG traces..
figure(2)
for i=1:2
    subplot(2,1,i),hold on
    plot([1 1]*emgonsets(trials2plot(i)), get(gca,'ylim'),'b--',LineWidth=2)
    legend({'EMG';'Button press';'EMG onset'})
end

%plot onsets by RTS
figure(3),clf

subplot(211),hold on
plot(emgonsets,'ks')
plot(rts,'bo')
xlabel('Trail'),ylabel('Time')
legend({'Button time';'EMG onsets'})

subplot(212)
plot(rts,emgonsets,'bo')
xlabel('Button press time')
ylabel('EMG onset time')
axis square














