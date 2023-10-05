clear
%% create signal 
N = 500;
hz = linspace(0,1,N);
gx = exp( -(4*log(2)*(hz-.1)/.1).^2)*N/2;
%signal with a lot of random numbers within some frequency boundries
signal = real(ifft( gx .* exp(1i*rand(1,N)*2*pi))) + randn(1,N);

figure(1),clf
subplot(311)
plot(1:N,signal,'k')
xlim([0 N+1])
title('Original Signal')

subplot(324)
plot(hz,abs(fft(signal)).^2,'k')
xlim([0 0.5])
title('f-domain')

%% apply zero-phase shift filter

%generate filter kernel
order = 150;
fkern = fir1(order,.6,'low');

%zero-phase shift filter
fsignal = filter(fkern,1,signal); %forward
fsignal = filter(fkern,1,fsignal(end:-1:1)); %reverse
fsignal = fsignal(end:-1:1); %flip 

%plot
subplot(323),hold on
plot(1:N,signal,'k')
plot(1:N,fsignal,'m')
legend({'Original';'Filtered, no reflection'})
title('Time domain')

subplot(324),hold on
plot(hz,abs(fft(fsignal)).^2,'m')
legend({'Original';'Filtered, no reflection'})

%% practice to cut signal and flip
a = 1:2:10 % 5 ota signal xa
b = a(5:-1:1)
%% Reflection

reflectsig = [signal(order:-1:1) signal signal(end:-1:end-order+1)];

reflectsig = filter(fkern,1,reflectsig);
reflectsig = filter(fkern,1,reflectsig(end:-1:1));
reflectsig = reflectsig(end:-1:1);

fsignal = reflectsig(order+1:end-order);

subplot(325),hold on
plot(1:N,signal,'k')
plot(1:N,fsignal,'r')
legend({'Original';'Filtered, with reflection'})
title('Time domain')

subplot(326),hold on
plot(hz,abs(fft(signal)).^2,'k')
plot(hz,abs(fft(fsignal)).^2,'r')
legend({'Original';'Filtered, with reflection'})
xlim([0 0.5])
title('Fdomain')

%% shortcut

fsignal1 = filtfilt(fkern,1,signal);

figure(2)
plot(1:N, signal,1:N,fsignal1)
legend({'Original';'Filtered, with reflection'})










