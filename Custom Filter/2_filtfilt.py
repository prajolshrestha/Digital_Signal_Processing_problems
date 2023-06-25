import matplotlib.pyplot as plt
import mysignals as sigs
from scipy import signal
import numpy as np

# Signal
t = np.linspace(0,1.0, 2001)
sig_5hz = np.sin(2*np.pi*5*t)
sig_250hz = np.sin(2*np.pi*250*t)

sig_5hz_250hz = sig_5hz + sig_250hz

# Filtfilt to get only 5hz signal
b,a = signal.butter(8,0.125)#cutoff freq = 125, we used normalized value(8*0.125 = 1)
filtered_signal = signal.filtfilt(b,a,sig_5hz_250hz,padlen=150)#linear filter twice(backward and forward)

#Plot
fig,ax = plt.subplots(4,sharex=True)
fig.suptitle('Filtfilt Filter')

ax[0].plot(sig_5hz,color='b')
ax[0].set_title('5hz Signal')

ax[1].plot(sig_250hz,color='r')
ax[1].set_title('250hz signal')

ax[2].plot(sig_5hz_250hz,color='yellow')
ax[2].set_title('combined signal')

ax[3].plot(filtered_signal,color='k')
ax[3].set_title('Filtered signal')

plt.show()
