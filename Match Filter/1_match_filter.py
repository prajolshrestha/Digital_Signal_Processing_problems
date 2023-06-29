from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

#Create signal
original_signal = np.repeat([0.,1.,1.,0.,1.,0.,0.,1.],128) #square wave len = 1024, each element is repeated 128 times ie 8*128
noise = np.random.randn(len(original_signal))

noisy_signal = original_signal + noise

#now, identify square signal in noisy signal

rectangular_pulse = np.ones(128)

#correlate noisy signal and rectangular pulse

correlated_output = signal.correlate(noisy_signal,rectangular_pulse,mode='same')

# we didnt get perfect signal after correlation

#lets plot feature out

clock = np.arange(64,len(original_signal),128) #64 - 1024 range ma int multiples of 128th value dine
print(clock)#[ 64 192 320 448 576 704 832 960]

#take clock to get various features
f,(ax_orig, ax_noise, ax_corr) = plt.subplots(3,1,sharex=True)
ax_orig.plot(original_signal)
ax_orig.plot(clock,original_signal[clock],'ro')
print(original_signal[clock]) #[0. 1. 1. 0. 1. 0. 0. 1.]

ax_noise.plot(noisy_signal)

ax_corr.plot(correlated_output)
ax_corr.plot(clock,correlated_output[clock],'ro')

ax_orig.margins(0,0.1)
f.tight_layout()
f.show()

#plt.plot(correlated_output)

plt.show()

# Used in radar technology