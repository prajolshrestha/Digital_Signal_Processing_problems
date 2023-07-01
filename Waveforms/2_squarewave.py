from scipy import signal
import numpy as np 
import matplotlib.pyplot as plt

t = np.linspace(0,1,500,endpoint=False)
square_wave = signal.square(2*np.pi*5*t)

plt.subplot2grid((2,2),(0,0))
plt.plot(t,square_wave)
plt.title('square wave')

#pulse width modulated sine wave
sine = np.sin(2*np.pi*t)
pwm = signal.square(2*np.pi*30*t, duty=(sine+1)/2)
plt.subplot2grid((2,2),(1,0))
plt.plot(t,sine)
plt.title('sine wave')

plt.subplot2grid((2,2),(1,1))
plt.plot(t,pwm)
plt.title('pulse width modulated sine wave')
plt.show()
