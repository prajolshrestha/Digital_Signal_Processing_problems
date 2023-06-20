import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d

#signal 
x = np.linspace(0,4,12)
y = np.cos(x**2/3 + 4)

plt.figure(1)
plt.plot(x,y,'o') # See the data

# Linear interpolation
f1 = interp1d(x,y,kind='linear')

#Cubic interpolation
f2 = interp1d(x,y,kind='cubic')

#plot
plt.figure(2)
plt.plot(x,y,'o',x,f1(x),'-',x,f2(x),'--')
plt.legend(['data','linear','cubic'])


# using more samples
xnew = np.linspace(0,4,30)

plt.figure(3)
plt.plot(x,y,'o',xnew,f1(xnew),'-',xnew,f2(xnew),'--')
plt.legend(['data','linear','cubic'])

plt.show()