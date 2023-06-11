from scipy import signal
import matplotlib.pyplot as plt
import numpy as np


triang_window = signal.get_window('triang',30)
kaiser_window = signal.get_window(('kaiser',4.0),30)#method 1
kaiser_window2 = signal.get_window(4.0,30)#method 2
hamm_window = signal.get_window('hamming',30)
black_window = signal.get_window('blackman',30)

f,a = plt.subplots(4,sharex=True)
f.suptitle('Window')

a[0].plot(triang_window,'r')
a[0].set_title('Triangular Window')

a[1].plot(kaiser_window,'r')
a[1].set_title('Kaiser Window')

a[2].plot(hamm_window,'r')
a[2].set_title('Hamming Window')

a[3].plot(black_window,'r')
a[3].set_title('Blackman Window')

plt.show()