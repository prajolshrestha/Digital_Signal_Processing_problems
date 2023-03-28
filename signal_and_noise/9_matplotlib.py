from matplotlib import pyplot as plt
from matplotlib import style

x = [1, 2, 3, 4, 5]
y = [7, 8 ,9, 10, 11]


style.use('dark_background')
plt.plot(x,y,label='Line One')
plt.xlabel('x-axis')
plt.ylabel('y-axis')
plt.title('Simple Chart')

plt.legend()
plt.show()