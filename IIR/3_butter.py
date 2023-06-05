from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

#4th order low pass filter with cutoff freq = 100hz
b,a = signal.butter(4,100,'low',analog=True)

w,h = signal.freqs(b,a)

plt.plot(w,20*np.log10(abs(h)))
plt.xscale('log')
plt.title('Butterworth filter Frequency Response')
plt.xlabel('Frequency')
plt.ylabel('Amplitude (dB)')
plt.margins(0,0.2)
plt.grid()
plt.axvline(100,color='g')

plt.show()