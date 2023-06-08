from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

b,a = signal.cheby1(4,5,100,'low',analog=True)
w,h = signal.freqs(b,a)#To filter noisy signals

plt.plot(w,20*np.log10(abs(h)))
plt.xscale('log')
plt.title('Chebyshev type I freq response (rp=5)')
plt.xlabel('Frequency')
plt.ylabel('Amplitude')
plt.margins(0,0.1)
plt.grid(which='both',axis='both')
plt.axvline(100,color='green')
plt.axhline(-5,color='g')

plt.show()