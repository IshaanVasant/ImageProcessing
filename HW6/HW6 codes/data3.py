import keras
from keras.datasets import mnist
import numpy as np
import saab_compact as saab
from sklearn.model_selection import train_test_split

def get_data_for_class(images, labels, cls):
	if type(cls)==list:
		idx=np.zeros(labels.shape, dtype=bool)
		for c in cls:
			idx=np.logical_or(idx, labels==c)
	else:
		idx=(labels==cls)
	return images[idx], labels[idx]

def import_data(use_classes):
	(train_images, train_labels), (test_images, test_labels) = mnist.load_data()
	# X_train, X_test, y_train, y_test = train_test_split(train_images1, train_labels1, train_size=60000, random_state=42)
	# train_images=X_train
	# train_labels=y_train
	train_images=train_images.reshape(-1,28,28,1)
	test_images=test_images.reshape(-1,28,28,1)
	train_images=train_images/255.
	test_images=test_images/255.

	train_images=np.float32(train_images)
	test_images=np.float32(test_images)

	print('initiali dtype: ', train_images.dtype)
	# print(train_images.shape) # 60000*28*28*1

	# zeropadding
	train_images=np.pad(train_images, ((0,0),(2,2),(2,2),(0,0)), mode='constant')
	test_images=np.pad(test_images,  ((0,0),(2,2),(2,2),(0,0)), mode='constant')
	# print(train_images.shape) # 60000*32*32*1

	if use_classes!='0-9':
		class_list=saab.parse_list_string(use_classes)
		train_images, train_labels=get_data_for_class(train_images, train_labels, class_list)
		test_images, test_labels=get_data_for_class(test_images, test_labels, class_list)
		# print(class_list)
	else:
		class_list=[0,1,2,3,4,5,6,7,8,9]
		
	return train_images, train_labels, test_images, test_labels, class_list

