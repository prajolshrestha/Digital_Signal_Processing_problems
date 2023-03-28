from scipy import signal
import numpy as np
from matplotlib import pyplot as plt
from matplotlib import style

#signal sampling rate 2000Hz

t = np.linspace(0,1.0,2001) #Return evenly spaced numbers over a specified interval.
#print(t,len(t))

signal_1Hz = np.sin(2*np.pi*t)
signal_5Hz = np.sin(2*np.pi*5*t)
signal_250Hz = np.sin(2*np.pi*250*t)

#add two singal
sig_5Hz_250Hz = signal_5Hz + signal_250Hz


#plotting
figure, plt_arr = plt.subplots(4, sharex= True)
figure.suptitle('Multiple Sine Waves')
plt_arr[0].plot(signal_1Hz)
plt_arr[0].set_title('1 Hz signal')
plt_arr[1].plot(signal_5Hz)
plt_arr[1].set_title('5 Hz signal')
plt_arr[2].plot(signal_250Hz)
plt_arr[2].set_title('250 Hz signal')
plt_arr[3].plot(sig_5Hz_250Hz)
plt_arr[3].set_title('Mixed signal')


#plt.plot(t,signal_1Hz)
#plt.plot(t,signal_5Hz)
plt.show()

