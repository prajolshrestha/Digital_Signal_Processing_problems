%% Trig functions
fs = 1000;
time = 0:1/fs:2;
phase = pi / 3;

x = 5*sin(2*pi*5*time + phase);
y = 5*cos(2*pi*5*time + phase);
z = 5*tan(2*pi*5*time + phase);

figure(1), clf, hold on
subplot(311)
plot(time,x)
subplot(312)
plot(time,y)
subplot(313)
plot(time,z)

title('Trig Functions')







