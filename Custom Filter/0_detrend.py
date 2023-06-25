import numpy as np
import scipy.signal as signal
import matplotlib.pyplot as plt

# create signal
t = np.linspace(-10,10,10)
y = 1+t+0.01*t**2

# Remove constant terms in signal
yconst = signal.detrend(y,type='constant')
ylin = signal.detrend(y,type='linear')


plt.plot(t,y,'r-')#upward moving trend
plt.plot(t,yconst,'k')
plt.plot(t,ylin,'g')
plt.grid()
plt.legend(['signal','constant detrend','linear detrend'])
plt.show()
