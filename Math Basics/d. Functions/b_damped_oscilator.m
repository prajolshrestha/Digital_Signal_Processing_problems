%% Damped oscilator
%
% Write an anonymous function that returns a damped oscilator,
% given inputs of frequency and decay.
%
% learn: function handle (@), contourf, func2str

%% Anonymous Function (in-line)
% h = @(input) function_def;

fun = @(x) x.^2;

fun(0)
fun(2)

%% Damped Oscillator

% define sampled time
fs = 1000;
time = 0:1/fs:2;

% define function
damposc = @(f,d) sin(2*pi*f*time).*exp(-d*time);

% get oscillation time series using f and d parameters
y = damposc(10,3);

figure(1),clf
plot(time,y)
xlabel('Time (s.)')
ylabel('Amplitude')
title(func2str(damposc))


%% image of parameter space

% range of decay parameters
taus = linspace(0,10,50);

% initialize
Y = zeros(length(taus),length(time));

% loop over decay parameters and compute damped oscillations
for ti = 1:length(taus)
        Y(ti,:) = damposc(25,taus(ti));
end

figure(2),clf
contourf(time,taus,Y)
xlabel('Time')
ylabel('Decay parameters')
colorbar
 
%% Damped Arcsine

% define sampled time
fs = 1000;
time = (0:1/fs:2)*pi;

% define function
damparc = @(f,d) asin(2*f*time).*exp(-d*time);

% get oscillation time series using f and d parameters
y = damparc(10,3);

figure(3),clf
plot(time,real(y),time,imag(y),time,abs(y))
xlabel('Time (s.)')
ylabel('Amplitude')
title(func2str(damparc))

% range of decay parameters
taus = linspace(0,3,50);

% initialize
Y = zeros(length(taus),length(time));

% loop over decay parameters and compute damped oscillations
for ti = 1:length(taus)
        Y(ti,:) = damparc(25,taus(ti));
end


figure(4),clf
surfh = surf(abs(Y));

xlabel('Time')
ylabel('Decay parameters')
zlabel('|f|')
colorbar




