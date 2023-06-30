from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

# Transfer function H(s) = s^^2 / s^^2+s

s1 = signal.lti([1],[1,1])#low pass filter ho

w,mag,phas = s1.bode()

plt.semilogx(w,mag)
plt.figure()
plt.semilogx(w,phas)
plt.show()