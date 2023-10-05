clear, clf
%% 
% create signal

srate = 1000;
time = 0:1/srate:3;
n = length(time);
p = 15; %poles for random interpolation

% noise level, measured in standard deviation
noiseamp = 5;

% amplitude modulator and noise level
ampl = interp1(rand(p,1)*30,linspace(1,p,n));
noise = noiseamp * randn(size(time));
signal = ampl + noise;

%substract mean to eliminate DC
signal = signal - mean(signal);

%% make a kernel
k = 100;
kern_len = 2*k+1;
kernel = ones(1,(kern_len))*1/(kern_len);

figure(1),clf
subplot(211)
plot(time,signal)
subplot(212)
plot(kernel)
ylim([0 0.02]),xlim([-10 250])

%%
% 1.convolution method
filtered_sig = fft(signal,n+kern_len-1) .* fft(kernel,n+kern_len-1);
fil_sig = ifft(filtered_sig);

% 2.running mean filter method
filtsig = zeros(size(signal));
for i=k+1:n-k-1
    % each point is the average of k surrounding points
    filtsig(i) = mean(signal(i-k:i+k));
end

figure(2),clf
hz = linspace(0,srate,n);
kernelX = abs(fft(kernel,n+kern_len-1)).^2;
plot(hz,kernelX(1:length(hz)))
xlim([0 50])
title('kernel in f domain')

figure(3),clf
plot(time,signal,time,fil_sig(k+1:end-k),time,filtsig)
legend({'Signal';'Convolution Smoothed';'mean smoothed'})





