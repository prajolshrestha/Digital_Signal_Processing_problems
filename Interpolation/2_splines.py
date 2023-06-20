import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import UnivariateSpline

# Signal
x = np.linspace(-3,3,50)
y = np.exp(-x**2) + 0.1*np.random.randn(50)

#plot
plt.figure(1)
plt.plot(x,y,'ro',ms=5,label='signal')


#spline
spl = UnivariateSpline(x,y)#returns function
xnew = np.linspace(-3,3,1000)
plt.plot(xnew,spl(xnew),'b',lw=3,label='spline')

#smooth
spl.set_smoothing_factor(0.4)

plt.plot(xnew,spl(xnew),'g',lw=3,label='spline (smooth = 0.4)')
plt.legend()
plt.show()