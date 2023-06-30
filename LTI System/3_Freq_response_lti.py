from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

s1 = signal.lti([],[1,1,1],[5])

print(s1.zeros)
print(s1.poles)
print(s1.gain)

#Frequency response of s1
w,h = signal.freqresp(s1)

# COmplex plot
plt.plot(h.real,h.imag,'b')
plt.plot(h.real, -h.imag,'r')
plt.title('Complex plane of Freq resp of lti')
plt.show()

