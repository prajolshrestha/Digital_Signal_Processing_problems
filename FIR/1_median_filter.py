import matplotlib.pyplot as plt
import mysignals as sigs
from scipy import signal

#median filter reduces noise
eleven_point_median_filter_output = signal.medfilt(sigs.InputSignal_1kHz_15kHz,11) #11 is length of filter
three_point_median_filter_output = signal.medfilt(sigs.InputSignal_1kHz_15kHz,3) 
twenty_one_point_median_filter_output = signal.medfilt(sigs.InputSignal_1kHz_15kHz,21) 


fig,ax = plt.subplots(4,sharex=True)
fig.suptitle('Median Filter')

ax[0].plot(sigs.InputSignal_1kHz_15kHz,color='b')
ax[0].set_title('Input Signal')

ax[1].plot(eleven_point_median_filter_output,color='r')
ax[1].set_title('Output with 11 point')


ax[2].plot(three_point_median_filter_output,color='k')
ax[2].set_title('Output with 3 point')
ax[3].plot(twenty_one_point_median_filter_output,color='k')
ax[3].set_title('Output with 21 point')
plt.show()
