from scipy import signal
import numpy as np 
import matplotlib.pyplot as plt

t = np.linspace(-1,1,2*100, endpoint=False)

#Return a Gaussian modulated sinusoid:
#   exp(-a t^2) exp(1j*2*pi*fc*t).
i,q,e = signal.gausspulse(t,fc=5,retquad=True, retenv=True) #i = real part , q = imag part , e = envelop of signal


plt.plot(t,i,t,q,t,e,'--')

plt.show()
