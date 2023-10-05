clear
%%
dataN = 10000;
filtN = 5001;

%generate data
signal = randn(dataN,1);

% filter kernel
fkern = fir1(filtN,.01,'low');

%filter
%fdata = filtfilt(fkern,1,signal);


%plot
figure(1),clf
%plot(1:dataN,signal, 1:dataN,fdata)

%error
%Data length must be larger than 15003 samples.

%%
% use reflection to increase signal length!
signalRefl = [ signal(end:-1:1); signal; signal(end:-1:1) ];


% apply filter kernel to data
fdataR = filtfilt(fkern,1,signalRefl);

% and cut off edges
fdata = fdataR(dataN+1:end-dataN);

figure(2),clf
plot(1:dataN,signal, 1:dataN,fdata)
