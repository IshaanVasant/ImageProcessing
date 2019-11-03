
from tensorflow.python.platform import flags
import pickle
import data3
import saab3
import numpy as np
from sklearn.decomposition import PCA
from sklearn.svm import SVC

def del_all_flags(FLAGS):
    print("Type of flags is",type(FLAGS))
    flags_dict = FLAGS._flags()    
    keys_list = [keys for keys in flags_dict]    
    for keys in keys_list:
        FLAGS.__delattr__(keys)
del_all_flags(flags.FLAGS)        

flags.DEFINE_string("use_classes", "0-9", "Supported format: 0,1,5-9")
FLAGS = flags.FLAGS






feat=[]
for i in range(1,11):
    fr=open('feature_vector%d.pkl'%i,'rb')  
    feat1=pickle.load(fr, encoding='latin1')
    if i==1:
        feat = feat1
    else:
        feat = np.concatenate((feat,feat1),axis=1)
    fr.close()

train_images, train_labels, test_images, test_labels, class_list = data3.import_data(FLAGS.use_classes)

pca = PCA(n_components = 10)
X = pca.fit_transform(feat)

clf = SVC()
clf.fit(X,train_labels)

training = clf.score(X,train_labels)
print("Training accuracy using Ensemble model is: ",training)

for i in range(1,11):
    fr=open('test_features%d.pkl'%i,'rb')  
    feat1=pickle.load(fr, encoding='latin1')
    if i==1:
        feat = feat1
    else:
        feat = np.concatenate((feat,feat1),axis=1)
    fr.close()
X_test = pca.transform(feat)
test = clf.score(X_test,test_labels)
print("Testing accuracy using Ensemble model is: ",test)





