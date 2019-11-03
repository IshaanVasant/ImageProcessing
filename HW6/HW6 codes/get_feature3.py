
import pickle
import numpy as np
import data3
import saab3
import keras
import sklearn

def main():
	# load data
    fr=open('pca_params2.pkl','rb')  
    pca_params=pickle.load(fr)
    fr.close()

	# read data
    train_images, train_labels, test_images, test_labels, class_list = data3.import_data("0-9")
    print('Training image size:', train_images.shape)
    print('Testing_image size:', test_images.shape)
	
	# Training
    print('--------Training--------')
    featu=[]
    for i in range(10):
        feature=saab3.initialize(train_images[i*6000:(i+1)*6000], pca_params)
        feature=feature.reshape(feature.shape[0],-1)
        featu.append(feature)
    featu=np.array(featu).reshape(60000,-1)
    
    print("S4 shape:", featu.shape)
    print('--------Finish Feature Extraction subnet--------')
    feat={}
    feat['feature']=featu
	
	# save data
    fw=open('feat2.pkl','wb')    
    pickle.dump(feat, fw)    
    fw.close()

if __name__ == '__main__':
	main()