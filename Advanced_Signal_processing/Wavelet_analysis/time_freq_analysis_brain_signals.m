clear,clf
%% data

load data4TF.mat

% plot the signal
figure(1), clf
subplot(411)
plot(timevec,data,'linew',1)
set(gca,'xlim',timevec([1 end]))
xlabel('Time (s)'), ylabel('Voltage (\muV)')
title('Time-domain signal')


%% create 50 complex morlet wavelet

nfrex = 50;
frex = linspace(8,70,nfrex);
fwhm = .2;

%time vector of wavelets
wavetime = -2:1/srate:2;

cmw = zeros(nfrex,length(wavetime));

for fi = 1:nfrex
    %create wavelet
    cmw(fi,:) = exp(1i*2*pi*frex(fi)*wavetime) .* exp( -(4*log(2)*wavetime.^2)/fwhm.^2);
    
end


% show the one wavelet
figure(2), clf
subplot(411)
plot(wavetime,real(cmw(10,:)), wavetime,imag(cmw(10,:)))
xlabel('Time')
legend({'Real';'Imaginary'})

%show all wavlet
subplot(4,1,2:4)
contourf(wavetime,frex,real(cmw),40,'linecolor','none')
xlabel('Time (s)'), ylabel('Frequency (Hz)')
title('Real part of wavelets')

%% convolution

%length
nConv = length(data) + length(wavetime) - 1;
wavehalf = floor(length(wavetime)/2);

%data fft
dataX = fft(data,nConv);

%initialize time freq matirx
tf = zeros(nfrex,length(data));

for fi = 1:nfrex
    %wavelet fft
    cmwX = fft(cmw(fi,:),nConv);
    cmwX = cmwX ./ max(cmwX);
    
    %convolution
    as = ifft( dataX .* cmwX);
    as = as(wavehalf:end-wavehalf);

    %extract power from complex signal
    tf(fi,:) = abs(as).^2;

end


%plot
figure(1)
subplot(4,1,[2 3 4])
contourf(timevec,frex,tf,40,'linecolor','none')
xlabel('Time (s)'), ylabel('Frequency (Hz)')
set(gca,'clim',[0 1e3])
title('Time-frequency power')
colormap hot


