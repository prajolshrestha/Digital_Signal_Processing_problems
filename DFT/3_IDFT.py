
import mysignals as sigs
import matplotlib.pyplot as plt
import math

sig_dest_imx_arr = []
sig_dest_rex_arr = []
sig_dest_mag_arr = []

def calc_dft(sig_src_arr):
    global sig_dest_imx_arr
    global sig_dest_rex_arr
    global sig_dest_mag_arr

    sig_dest_imx_arr = [None]*int((len(sig_src_arr)/2))
    sig_dest_rex_arr = [None]*int((len(sig_src_arr)/2))
    sig_dest_mag_arr = [None]*int((len(sig_src_arr)/2))


    for j in range(int(len(sig_src_arr)/2)):
        sig_dest_rex_arr[j] = 0
        sig_dest_imx_arr[j] = 0
    
    for k in range(int(len(sig_src_arr)/2)):
        for i in range(len(sig_src_arr)):
            sig_dest_rex_arr[k] = sig_dest_rex_arr[k] + sig_src_arr[i]*math.cos(2*math.pi*k*i/len(sig_src_arr))
            sig_dest_imx_arr[k] = sig_dest_imx_arr[k] - sig_src_arr[i]*math.sin(2*math.pi*k*i/len(sig_src_arr))

    for x in range(int(len(sig_src_arr)/2)):
        sig_dest_mag_arr[x] = math.sqrt(math.pow(sig_dest_rex_arr[x],2)+math.pow(sig_dest_imx_arr[x],2))

def plot_signals():
    plt.subplot(151)
    plt.plot(sig_dest_rex_arr)
    plt.title('Real')

    plt.subplot(152)
    plt.plot(sig_dest_imx_arr)
    plt.title('IMG')

    plt.subplot(153)
    plt.plot(sigs.InputSignal_1kHz_15kHz)
    plt.title('Input')

    plt.subplot(154)
    plt.plot(sig_dest_mag_arr)
    plt.title('Magnitude')

    plt.subplot(155)
    plt.plot(sig_dest_idft_arr)
    plt.title('IDFT')

    plt.show()

sig_dist_idft_Arr = []

def calc_idft(sig_src_rex_arr,sig_src_imx_arr):
    global sig_dest_idft_arr
    sig_dest_idft_arr = [None]*(len(sig_src_rex_arr)*2)
    
    for j in range(len(sig_src_rex_arr)*2):
        sig_dest_idft_arr[j] = 0
    
    for x in range(len(sig_src_imx_arr)):
        sig_src_rex_arr[x] = sig_src_rex_arr[x]/len(sig_src_rex_arr)
        sig_src_imx_arr[x] = sig_src_imx_arr[x]/len(sig_src_rex_arr)
        
    for k in range(len(sig_src_rex_arr)):
        for i in range(len(sig_src_rex_arr)*2):
            sig_dest_idft_arr[i] = sig_dest_idft_arr[i] + sig_src_rex_arr[k]*math.cos(2*math.pi*k*i/(len(sig_src_rex_arr)*2))
            sig_dest_idft_arr[i] = sig_dest_idft_arr[i] + sig_src_imx_arr[k]*math.sin(2*math.pi*k*i/(len(sig_src_imx_arr)*2))


calc_dft(sigs.InputSignal_1kHz_15kHz)
calc_idft(sig_dest_rex_arr,sig_dest_imx_arr)
plot_signals()