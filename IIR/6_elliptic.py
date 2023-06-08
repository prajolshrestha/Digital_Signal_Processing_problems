from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

b,a = signal.ellip(4,5,40,100,'low',analog=True)#ripples allowed = 5
w,h = signal.freqs(b,a)

plt.plot(w,20*np.log10(abs(h)))

plt.title('Elleptic Filter Freq Response')
plt.xscale('log')
plt.axhline(-40,color='g')#attenuation = 40db
plt.axvline(100,color='g')#cutoff freq = 100
plt.show()