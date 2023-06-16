from scipy import signal
import matplotlib.pyplot as plt
import numpy as np
from scipy.fftpack import fft, fftshift

#51 point boxcar window(Impulse Response)
window = signal.boxcar(51)

plt.plot(window)
plt.title("Boxcar window")

#Frequency Response
plt.figure()

A = fft(window,2048)/(len(window)/2.0)
hz = np.linspace(-0.5,0.5,len(A))
response = 20*np.log10(np.abs(fftshift(A/abs(A).max())))

plt.plot(hz,response)
plt.axis([-0.5,0.5,-120,0])
plt.title('Freq response of boxcar window')
plt.ylabel('Normalized magnitude')
plt.xlabel('Normalized Frequency')

plt.show()

