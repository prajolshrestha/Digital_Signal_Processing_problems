import mysignals as sigs
import matplotlib.pyplot as plt
import math

def calc_dft(sig_src_arr):
    sig_dest_imx_arr = [None]*int((len(sig_src_arr)/2))
    sig_dest_rex_arr = [None]*int((len(sig_src_arr)/2))

    for j in range(int(len(sig_src_arr)/2)):
        sig_dest_rex_arr[j] = 0
        sig_dest_imx_arr[j] = 0
    
    for k in range(int(len(sig_src_arr)/2)):
        for i in range(len(sig_src_arr)):
            sig_dest_rex_arr[k] = sig_dest_rex_arr[k] + sig_src_arr[i]*math.cos(2*math.pi*k*i/len(sig_src_arr))
            sig_dest_imx_arr[k] = sig_dest_imx_arr[k] - sig_src_arr[i]*math.sin(2*math.pi*k*i/len(sig_src_arr))

    plt.subplot(131)
    plt.plot(sig_dest_rex_arr)
    plt.title('Real')

    plt.subplot(132)
    plt.plot(sig_dest_imx_arr)
    plt.title('IMG')

    plt.subplot(133)
    plt.plot(sigs.InputSignal_1kHz_15kHz)
    plt.title('Input')

    plt.show()

calc_dft(sigs.InputSignal_1kHz_15kHz)