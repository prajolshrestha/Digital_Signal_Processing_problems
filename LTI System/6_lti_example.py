import numpy as np
from scipy import signal

#Let's consider a simple first-order low-pass filter with a transfer function of:
#H(s) = 1 / (s + 1)
# Define the transfer function coefficients
numerator = [1]
denominator = [1, 1]

# Create the LTI system object
system = signal.lti(numerator, denominator)

# Define the time points for simulation
t = np.linspace(0, 5, 1000)

# Generate the step input signal
u = np.ones_like(t)

# Compute the output of the LTI .
# This function is used to simulate the response of an LTI system to an arbitrary input signal. 
t, y, _ = signal.lsim(system, u, t)

# Plot the input and output signals
import matplotlib.pyplot as plt
plt.figure()
plt.title('first-order low-pass filter')
plt.plot(t, u, label='Input')
plt.plot(t, y, label='Output')
plt.xlabel('Time')
plt.ylabel('Amplitude')
plt.legend()
plt.grid(True)
plt.show()

# In this case, since the transfer function represents a first-order low-pass filter, 
# you should observe that the output signal gradually rises to the final value of 1, 
# with a time constant of approximately 1.

#lets see the frequency response of LTI system
frequencies = np.logspace(-2,2,1000)
w, mag, phase = signal.bode(system,frequencies)
plt.figure()
# Plot the frequency response (Bode plot)
fig, (ax1, ax2) = plt.subplots(2, 1, sharex=True)
ax1.semilogx(w, mag)
ax1.set_ylabel('Magnitude (dB)')
ax1.grid(True)

ax2.semilogx(w, phase)
ax2.set_xlabel('Frequency (Hz)')
ax2.set_ylabel('Phase (degrees)')
ax2.grid(True)

plt.show()

