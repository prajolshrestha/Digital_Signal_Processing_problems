from scipy import signal
import matplotlib.pyplot as plt
import numpy as np
from scipy.fftpack import fft, fftshift

#51 point bart-hann window(Impulse Response)###########################################
window = signal.barthann(51)

#Frequency Response
A = fft(window,2048)/(len(window)/2.0)
hz = np.linspace(-0.5,0.5,len(A))
response = 20*np.log10(np.abs(fftshift(A/abs(A).max())))

#51 point bartlett window(Impulse Response)###########################################
window1 = signal.bartlett(51)

#Frequency Response
A1 = fft(window1,2048)/(len(window1)/2.0)
hz = np.linspace(-0.5,0.5,len(A1))
response1 = 20*np.log10(np.abs(fftshift(A1/abs(A1).max())))

#51 point blackman window(Impulse Response)###########################################
window2 = signal.blackman(51)

#Frequency Response
A2 = fft(window2,2048)/(len(window2)/2.0)
hz = np.linspace(-0.5,0.5,len(A2))
response2 = 20*np.log10(np.abs(fftshift(A2/abs(A2).max())))

#51 point blackman harris window(Impulse Response)###########################################
window3 = signal.blackmanharris(51)

#Frequency Response
A3 = fft(window3,2048)/(len(window3)/2.0)
hz = np.linspace(-0.5,0.5,len(A3))
response3 = 20*np.log10(np.abs(fftshift(A3/abs(A3).max())))

#51 point bohman window(Impulse Response)###########################################
window4 = signal.bohman(51)

#Frequency Response
A4 = fft(window4,2048)/(len(window4)/2.0)
hz = np.linspace(-0.5,0.5,len(A4))
response4 = 20*np.log10(np.abs(fftshift(A4/abs(A4).max())))

######################## Plot ############################################################
fig,ax = plt.subplots(5,2)
fig.suptitle('Different Windows')

ax[0,0].plot(window)
ax[0,0].set_title("Bartlett-Hann window")

ax[0,1].plot(hz,response)
#ax[0,1].get_xaxis([-0.5,0.5,-120,0])
ax[0,1].set_title('Freq response of bartlett hann window')
ax[0,1].set_ylabel('Normalized magnitude')
ax[0,1].set_xlabel('Normalized Frequency')

ax[1,0].plot(window1)
ax[1,0].set_title("Bartlett window")

ax[1,1].plot(hz,response1)
#ax[0,1].get_xaxis([-0.5,0.5,-120,0])
ax[1,1].set_title('Freq response of bartlett window')
ax[1,1].set_ylabel('Normalized magnitude')
ax[1,1].set_xlabel('Normalized Frequency')

ax[2,0].plot(window2)
ax[2,0].set_title("Blackman window")

ax[2,1].plot(hz,response2)
#ax[0,1].get_xaxis([-0.5,0.5,-120,0])
ax[2,1].set_title('Freq response of blackman window')
ax[2,1].set_ylabel('Normalized magnitude')
ax[2,1].set_xlabel('Normalized Frequency')

ax[3,0].plot(window3)
ax[3,0].set_title("Blackman harris window")

ax[3,1].plot(hz,response3)
#ax[0,1].get_xaxis([-0.5,0.5,-120,0])
ax[3,1].set_title('Freq response of blackman harris window')
ax[3,1].set_ylabel('Normalized magnitude')
ax[3,1].set_xlabel('Normalized Frequency')

ax[4,0].plot(window4)
ax[4,0].set_title("Bohman window")

ax[4,1].plot(hz,response4)
#ax[0,1].get_xaxis([-0.5,0.5,-120,0])
ax[4,1].set_title('Freq response of bohman window')
ax[4,1].set_ylabel('Normalized magnitude')
ax[4,1].set_xlabel('Normalized Frequency')

plt.show()

