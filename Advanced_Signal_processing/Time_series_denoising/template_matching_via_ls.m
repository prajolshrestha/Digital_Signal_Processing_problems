clear
%% dataset
load templateProjection.mat

%% see one data and artifact (total 707 data chha)
figure(1),clf,hold on
plot(timevec,EEGdat(:,1))
plot(timevec,eyedat(:,1))
legend({'Data';'Artifict from eye'})


%%
%initial residual data
resdat = zeros(size(EEGdat));

%loop over trials
for triali = 1:size(resdat,2)

    % Data matrix banako
    % build least squares model as intercept and EOG from this trial
    x = [ones(npnts,1) eyedat(:,triali)];

    %compute regression coefficients for EEG channel
    b = (x'*x) \ (x' * EEGdat(:,triali));

    %predicted data
    yHat = x*b;

    %residual
    resdat(:,triali) = (EEGdat(:,triali) - yHat)';

end

%% plot

%trial  averages
figure(2),clf
plot(timevec, mean(eyedat,2), timevec,mean(EEGdat,2),timevec,mean(resdat,2))
legend({'EOG';'EEG';'Residual'})
xlabel('Time')
%a=mean(eyedat,2); mean in each row

% show all trials in map
clim =[-1 1]*20;

figure(3),clf
subplot(131)
imagesc(timevec,[],eyedat')
title('EOG (Eye artifact)')

subplot(132)
imagesc(timevec,[],EEGdat')
title('EEG (Uncleaned data)')

subplot(133)
imagesc(timevec,[],resdat')
title('REsidual data (Artifact free)')

