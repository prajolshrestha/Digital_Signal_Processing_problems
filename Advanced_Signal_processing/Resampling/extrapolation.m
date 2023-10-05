clear,clf
%% extrapolation

%signal
signal = [1 4 3 6 2 19];
timevec = 1:length(signal);

figure(1),clf,hold on
plot(timevec,signal,'ks-')

%% Extrapolate

% 
times2extrap = -length(signal):2*length(signal);

Flin = griddedInterpolant(timevec,signal,'linear');
Fspl = griddedInterpolant(timevec,signal,'spline');

%query datapoints
extrapLin = Flin(times2extrap);
extrapSpl = Fspl(times2extrap);

%plot
plot(times2extrap,extrapLin,'ro-')
plot(times2extrap,extrapSpl,'bp-')


legend({'original';'linear';'spline'})







