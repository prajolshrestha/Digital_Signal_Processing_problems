clear 
%% create signal

signal = [zeros(1,100) cos(linspace(pi/2, 5*pi/2, 10)) zeros(1,100)];
n = length(signal);

figure(1),clf
subplot(221)
plot(1:n,signal)
title('Original Signal')

subplot(222),hold on
plot(linspace(0,1,n),abs(fft(signal)))
xlim([0 0.5])

title('F-domain signal representation')

%% low pass causal filter (phase shift hunxa)

%filter kernel
fkern = fir1(50,.6,'low');
%filter gareko
fsignal = filter(fkern,1,signal);

subplot(234)
plot(1:n,signal, 1:n,fsignal)
legend({'Original';'Forward filtered (causal)'})


subplot(222)
plot(linspace(0,1,n),abs(fft(fsignal)),'r')


%% backward filter

%signal flip garne
fsignalFlip = fsignal(end:-1:1);

%flipped signal filter garne
fsignalF =filter(fkern,1,fsignalFlip);


subplot(235)
plot(1:n, signal,1:n,fsignalF )
legend({'Original';'backward filtered'})

%%  flipped signal lai flip garne 

fsignalFiltFlip =fsignalF(end:-1:1);

subplot(2,3,6)
plot(1:n,signal, 1:n, fsignalFiltFlip)
legend({'original';'zero phase shift'})

subplot(222)
plot(linspace(0,1,n),abs(fft(fsignalFiltFlip)))
legend({'original signal';'filtered signal';'zero-phase shift'})

%% shortcut

fsignal_shortcut = filtfilt(fkern,1,signal);
figure(2),clf
plot(1:n,signal,1:n,fsignal_shortcut)
legend({'original';'zero phase shift'})