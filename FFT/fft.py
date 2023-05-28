import numpy as np
import matplotlib.pyplot as plt
import mysignals as sigs
from scipy.fftpack import fft,ifft

freq_domain_signal = fft(sigs.ecg_signal)
time_domain_signal = ifft(freq_domain_signal)

magnitude = np.abs(freq_domain_signal)

fig,ax = plt.subplots(4, sharex =True)
fig.suptitle('FFT')
ax[0].plot(sigs.ecg_signal,color='red')
ax[0].set_title('Time domain signal')

ax[1].plot(freq_domain_signal,color='cyan')
ax[1].set_title('Frequency domain signal(fft)')

ax[2].plot(magnitude,color='black')
ax[2].set_title('Magnitude')

ax[3].plot(time_domain_signal,color='red')
ax[3].set_title('Time domain signal(ifft)')

plt.show()
