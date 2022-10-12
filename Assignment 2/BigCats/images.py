import cv2
from os import listdir
from os.path import isfile, join
import matplotlib.pyplot as plt
from matplotlib.pyplot import imshow
from PIL import Image
import numpy as np
import os

#https://www.section.io/engineering-education/image-preprocessing-in-python/
dataset_path = '../Data-PR-As2/BigCats/'
class_names = [dir for dir in os.listdir(dataset_path) if os.path.isdir(join(dataset_path + dir))]

# Visualise data samples for each class
fig, axs = plt.subplots(1,len(class_names), constrained_layout=True)
axs = axs.flatten()
for class_ in class_names:
    files = [f for f in listdir(dataset_path + class_) if isfile(join(dataset_path + class_, f))]
    img_plot_path = dataset_path + class_ + '/' + files[0]
    with Image.open(img_plot_path) as img:
        axs[class_names.index(class_)].imshow(img)
    axs[class_names.index(class_)].title.set_text(class_)
plt.show()

# 
gray_dir_path = '../Data-PR-As2/grayscale/'
if 