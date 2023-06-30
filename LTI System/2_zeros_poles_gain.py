from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

#Linear Time Invariant system class in zeros, poles, gain form.
# System H(s) = 5(s-1)(s-2) / (s-3)(s-4)

simple_lti = signal.ZerosPolesGain([1,2],[3,4],5)
print(simple_lti)

# Discrete
simple_dlti = signal.ZerosPolesGain([1,2],[3,4],5,dt=0.1)
print(simple_dlti)