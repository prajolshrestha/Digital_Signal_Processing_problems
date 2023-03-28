import mysignals as sig
from matplotlib import pyplot as plt
from matplotlib import style

style.use('ggplot')

#dividing data to 3 plots
f,plt_arr = plt.subplots(3, sharex = True)
f.suptitle('Multiplot')
#print(plt_arr)


#plot
plt_arr[0].plot(sig.InputSignal_1kHz_15kHz)
plt_arr[1].plot(sig.InputSignal_1kHz_15kHz)
plt_arr[2].plot(sig.InputSignal_1kHz_15kHz)

plt.show()