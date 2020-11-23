import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt


x_train=np.load("C:\\Users\\chada\\Desktop\\Nouveau dossier\\valeursx.npy")
y_train=np.load("C:\\Users\\chada\\Desktop\\Nouveau dossier\\valeursy.npy")

## 0-1 pas 0-255
x_train = x_train.astype('float32')
y_train = y_train.astype('float32')
x_train = tf.keras.utils.normalize(x_train, axis=-1)


##modele
model = tf.keras.models.Sequential()
model.add(tf.keras.layers.Flatten())
model.add(tf.keras.layers.Dense(128, activation=tf.nn.relu))
model.add(tf.keras.layers.Dense(128, activation=tf.nn.relu))
model.add(tf.keras.layers.Dense(1, activation=tf.nn.softmax)) 
##calcul du gradient
model.compile(optimizer='adam',loss='sparse_categorical_crossentropy',metrics=['accuracy'])
##entrainement
model.fit(x_train, y_train, epochs=3)

##save
model.save('simon')
##load
new_model =tf.keras.models.load_model('simon')


##fonctionnement
prediction = new_model.predict(x_train)
# print(prediction)
print(np.argmax(prediction[0]))
plt.imshow(x_train[0])
plt.show()



