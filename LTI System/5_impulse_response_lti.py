from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

# Transfer function H(s) = s^^2 / s^^3+s^^2+s

system = ([1],[1,1,1])

#to compute the impulse response of a linear time-invariant (LTI) system.
# It calculates the system's output when an impulse function (Dirac delta function) is applied as the input. 
t,y = signal.impulse(system) #or, impulse2(system)

plt.plot(t,y)
plt.show()