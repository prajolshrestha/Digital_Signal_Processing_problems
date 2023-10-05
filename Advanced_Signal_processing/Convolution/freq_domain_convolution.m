clear,clf
%%
signal = zeros(1,20);
signal(8:15) = 1;

kernel = [1 .8 .6 .4 .2];

%convolution size
nSign = length(signal);
nKern = length(kernel);
nConv = nSign + nKern - 1;
half_kern = floor(nKern/2);

%fft
signalX = fft(signal,nConv);
kernelX = fft(kernel,nConv);%same size huna parxa  signalX and kernelX

% multiplication
sigXkern = signalX .* kernelX;

%ifft
conv_resFFT = ifft(sigXkern);

%cut off edges
conv_resFFT = conv_resFFT(half_kern+1:end-half_kern);

%% plot
figure(1),clf,hold on
plot(signal)
plot(kernel)
plot(conv_resFFT)
title('Frequency domain Convolution')



