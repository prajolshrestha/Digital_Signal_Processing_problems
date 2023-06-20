import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import UnivariateSpline, InterpolatedUnivariateSpline
from scipy.interpolate import Rbf

x = np.linspace(0,10,9)
y = np.sin(x)

plt.plot(x,y,'ro',label='signal')

# spline
x1 = np.linspace(0,10,101)
spl = UnivariateSpline(x,y)#returns a function
yspl = spl(x1)

plt.plot(x1,yspl,'b-',label='spline')

# spline with smoothing
spl.set_smoothing_factor(0.4)
yspl = spl(x1)

plt.plot(x1,yspl,'g-',label='spline (smooth = 0.4)')

# Interpolated spline
spl = InterpolatedUnivariateSpline(x,y)#returns a function
yspl = spl(x1)

plt.plot(x1,yspl,'k-',label='interpolated uni spline')

#rbf 
rbf = Rbf(x,y)#return function
yrbf = rbf(x1)
plt.plot(x1,yrbf,'r',label='rbf')


plt.legend()
plt.title('spline vs rbf')
plt.show()