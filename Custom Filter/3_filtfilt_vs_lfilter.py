import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import lfilter,lfilter_zi,filtfilt,butter

# Create signal
t = np.linspace(-1,1,201)

x1 = np.sin(2*np.pi*0.75*t*(1-t))
x2 = 2.1 + 0.1*np.sin(2*np.pi*1.25*t+1)
x3 = 0.18*np.cos(2*np.pi*3.85*t)

x = x1+x2+x3

xn = x + np.random.randn(len(t)) * 0.08

# Filter
b,a = butter(3,0.05)
zi = lfilter_zi(b,a)#Construct initial conditions for lfilter for step response steady-state

# method 1
z,_ =lfilter(b,a,xn,zi=zi*xn[0])#Filter data along one-dimension with an IIR or FIR filter.
# Method 2
z2,_ =lfilter(b,a,z,zi=zi*z[0]) # using lfilter twice
# Method 3
y = filtfilt(b,a,xn)

#Plot
figure = plt.figure(figsize=(10,5))
plt.plot(t,xn,'b',linewidth=1.75)
plt.plot(t,z,'r--',linewidth=1.75)
plt.plot(t,z2,'r',linewidth=1.75)
plt.plot(t,y,'g',linewidth=2.75)
plt.legend(['noisy signal', 'lfilter once', 'lfilter twice', 'filtfilt'])
plt.grid()
plt.show()


