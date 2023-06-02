from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

filter = signal.firwin(80,0.5,window=('kaiser',8))
w,h = signal.freqz(filter)#Digital Filter

print(filter)

f,ax = plt.subplots(2,sharex=True)
ax[0].plot(filter)
ax[0].set_title('Filter (kaiser) (Impulse Response)')

ax[1].semilogy(w,np.abs(h),'g')
ax[1].set_title('Frequency Response')
plt.show()