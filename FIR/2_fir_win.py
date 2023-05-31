import matplotlib.pyplot as plt
from scipy import signal
import numpy as np
import scipy.fftpack

# Sampling rate of 2000Hz then, Nyquist freq = 1000Hz
t = np.linspace(0,1.0,2001)

sig_5Hz = np.sin(2*np.pi*5*t)
sig_50Hz = np.sin(2*np.pi*50*t)
sig_250Hz = np.sin(2*np.pi*250*t)

sig_5hz_50hz_50hz = sig_5Hz + sig_50Hz + sig_250Hz

fig,ax = plt.subplots(9,sharex=True)
ax[0].plot(sig_5hz_50hz_50hz)
ax[0].set_title('sig_5hz_50hz_250hz')

numtaps = 101 #less vayo vane aftifacts dekhinxa
lpf_cutoff = 7
hpf_cutoff = 100
bp_cutoff1 = 40
bp_cutoff2 = 100

#Low pass Filter ##################################################
lowpass_coeff = signal.firwin(numtaps,lpf_cutoff,nyq = 1000)

ax[1].plot(lowpass_coeff)
ax[1].set_title('Low pass Filter (Impulse Response)')

#
low_pass_output = np.convolve(lowpass_coeff,sig_5hz_50hz_50hz)

ax[2].plot(low_pass_output)
ax[2].set_title('Low pass * signal = (only 5 Hz)')

#High pass filter ###################################################
highpass_coeff = signal.firwin(numtaps,hpf_cutoff,pass_zero=False,nyq=1000)#pass zero helps to define high pass
highpass_output = np.convolve(highpass_coeff,sig_5hz_50hz_50hz)

ax[3].plot(highpass_coeff)
ax[3].set_title('High pass Filter')

ax[4].plot(highpass_output)
ax[4].set_title('Highpass * signal = (only 250 Hz)')

#Band pass filter ###################################################
bandpass_coeff = signal.firwin(numtaps,[bp_cutoff1,bp_cutoff2],pass_zero=False,nyq=1000)
bandpass_output = np.convolve(bandpass_coeff,sig_5hz_50hz_50hz)

ax[5].plot(bandpass_coeff)
ax[5].set_title('Band pass Filter')

ax[6].plot(bandpass_output)
ax[6].set_title('Bandpass * signal = (only 50 Hz)')

fft_bandpass = scipy.fftpack.fft(bandpass_output)
ax[7].plot(np.real(fft_bandpass))
#ax[7].set_xlim([0,60])

# #Band Reject filter ###################################################
# bandr_coeff = signal.firwin(numtaps,[bp_cutoff1,bp_cutoff2],pass_zero=False,nyq=1000)
# bandr_output = np.convolve(bandr_coeff,sig_5hz_50hz_50hz)

# ax[7].plot(bandr_coeff)
# ax[7].set_title('Band Reject Filter')

# ax[8].plot(bandr_output)
# ax[8].set_title('Bandreject * signal = (only 50 Hz)')


plt.show()