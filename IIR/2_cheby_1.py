from scipy.signal import freqs, iirfilter
import matplotlib.pyplot as plt
import numpy as np

b,a = iirfilter(4,[1,10],1,60,analog=True,ftype='cheby1')#Analog filter

w,h = freqs(b,a,worN=np.logspace(-1,2,1000))#Freq response
#w=angular frequency , h = frequency response

fig,ax = plt.subplots(2,sharex=True)
fig.suptitle('Chebyseb I filter')

ax[0].semilogx(w,abs(h))
ax[0].set_title('Frequency response of cheby1')
ax[0].set_xlabel('Frequency')
ax[0].set_ylabel('Amplitude response')

plt.show()