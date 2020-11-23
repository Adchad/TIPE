import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from matplotlib.widgets import Cursor,Button

def onclick(event):
    x, y = event.xdata, event.ydata
    plt.cla()
    cursor = Cursor(ax)
    ax.imshow(test,extent=[0,1,0,1])
    print(x, y)

test=mpimg.imread('test.png')

fig, ax = plt.subplots()
cursor = Cursor(ax)
fig.canvas.mpl_connect('button_press_event', onclick)
ax.imshow(test,extent=[0,1,0,1])
plt.show()
