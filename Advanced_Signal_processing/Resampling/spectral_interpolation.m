clear, clf
%%

n =10000;
%create signal
[origsig, signal] = deal(cumsum(randn(n,1)));

%remove specified window
boundryPnts = [5000 6500];
signal(boundryPnts(1):boundryPnts(2)) = 0/0;

% FFt of pre and post window data
fftpre = fft(signal(boundryPnts(1)-diff(boundryPnts)-1:boundryPnts(1)-1));
fftpst = fft(signal(boundryPnts(2)+1:boundryPnts(1)+diff(boundryPnts)+ 1));

%interpolated signal is comb of mixed fft and straight line
mixeddata = detrend(ifft((fftpre + fftpst)/2));
linedata = linspace(0,1,diff(boundryPnts)+1)' * (signal(boundryPnts(2)+1) - signal(boundryPnts(1)-1)) + signal(boundryPnts(1)-1);

%sum together for final result
linterp = mixeddata + linedata;

%put interpolated piece into signal
filtsig = signal;
filtsig(boundryPnts(1) : boundryPnts(2)) = linterp;

figure(1),clf
plot(1:n, [origsig signal+5 filtsig+10])
legend({'original';' with gap';'Filterd'})











