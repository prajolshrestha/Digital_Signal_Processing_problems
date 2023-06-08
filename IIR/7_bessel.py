from scipy import signal
import matplotlib.pyplot as plt
import numpy as np


b,a = signal.butter(4,100,btype='low',analog=True)
w,h = signal.freqs(b,a)

plt.plot(w,20*np.log10(abs(h)),color='silver',label='Butterworth')


b,a = signal.bessel(4,100,btype='low',analog=True)
w,h = signal.freqs(b,a)

plt.plot(w,20*np.log10(abs(h)),label='Bessel freq response')
plt.axvline(100)
plt.legend()
plt.show()