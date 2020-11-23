import numpy as np
import matplotlib.pyplot as plt
import os
import cv2
from tqdm import tqdm
import random
import pickle

##training data et repartition par categories
DATADIR = "C:\\Users\\chada\\Desktop\\Nouveau dossier\\Database"

CATEGORIES = ["Avec", "Sans"]
IMG_SIZE = 500
training_data = []

def create_training_data():
    for category in CATEGORIES:

        path = os.path.join(DATADIR,category)
        class_num = CATEGORIES.index(category)
            
        for img in tqdm(os.listdir(path)):  

                img_array = cv2.imread(os.path.join(path,img) ,cv2.IMREAD_ANYCOLOR)
                new_array = cv2.resize(img_array, (IMG_SIZE, IMG_SIZE))
                training_data.append([new_array, class_num])
                
            
create_training_data()

##melange
random.shuffle(training_data) 

##formatkeras
X = []
Y = []
for features,label in training_data:
    X.append(features)
    Y.append(label)
X = np.array(X).reshape(-1, IMG_SIZE, IMG_SIZE, 3)

np.save("C:\\Users\\chada\\Desktop\\Nouveau dossier\\valeursx",X)
np.save("C:\\Users\\chada\\Desktop\\Nouveau dossier\\valeursy",Y)

