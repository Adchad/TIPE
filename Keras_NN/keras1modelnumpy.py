import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

mnist = tf.keras.datasets.mnist
x_train=np.load("C:\\Users\\chada\\Desktop\\Nouveau dossier\\valeursx.npy")
y_train=np.load("C:\\Users\\chada\\Desktop\\Nouveau dossier\\valeursy.npy")
# (x_train, y_train)= mnist.load_data()
## 0-1 pas 0-255
x_train = tf.keras.utils.normalize(x_train, axis=1)
# x_test = tf.keras.utils.normalize(x_test, axis=1)
##modele
model = tf.keras.models.Sequential()
model.add(tf.keras.layers.Flatten())
model.add(tf.keras.layers.Dense(128, activation=tf.nn.relu))
model.add(tf.keras.layers.Dense(128, activation=tf.nn.relu))
model.add(tf.keras.layers.Dense(10, activation=tf.nn.softmax)) ##softmax pour repartition probalistic
##calcul du gradient
model.compile(optimizer='adam',loss='sparse_categorical_crossentropy',metrics=['accuracy'])
##entrainement
model.fit(x_train, y_train, epochs=3)

# ##test du model avec base test
# val_loss, val_acc = model.evaluate(x_test, y_test)
# print(val_loss, val_acc)

##save
model.save('simon')
##load
new_model =tf.keras.models.load_model('simon')

##fonctionnement
prediction = new_model.predict(x_train)
print(prediction)
print(np.argmax(prediction[0]))
plt.imshow(x_train[0])
plt.show()



