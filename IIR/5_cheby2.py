from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

b,a = signal.cheby2(4,40,100,'low',analog=True)# 40 db attenuation (change and see the difference)
w,h = signal.freqs(b,a)#To filter noisy signals

plt.plot(w,20*np.log10(abs(h)))
plt.xscale('log')
plt.title('Chebyshev type II low pass freq response (attenuation=40)')
plt.xlabel('Frequency')
plt.ylabel('Amplitude')
plt.margins(0,0.1)
plt.grid(which='both',axis='both')
plt.axvline(100,color='green')#100 ma veritical line banauxa
plt.axhline(-40,color='g')#-40 ma horizontal line banauxa

plt.show()