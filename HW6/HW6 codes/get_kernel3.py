
from tensorflow.python.platform import flags
import pickle
import data3
import saab3
import numpy as np

def del_all_flags(FLAGS):
    print("Type of flags is",type(FLAGS))
    flags_dict = FLAGS._flags()    
    keys_list = [keys for keys in flags_dict]    
    for keys in keys_list:
        FLAGS.__delattr__(keys)

del_all_flags(flags.FLAGS)

flags.DEFINE_string("output_path", None, "The output dir to save params")
flags.DEFINE_string("use_classes", "0-9", "Supported format: 0,1,5-9")
flags.DEFINE_string("kernel_sizes", "5,5", "Kernels size for each stage. Format: '3,3'")
flags.DEFINE_string("num_kernels", "5,15", "Num of kernels for each stage. Format: '4,10'")
flags.DEFINE_float("energy_percent", None, "Energy to be preserved in each stage")
flags.DEFINE_integer("use_num_images", 10000, "Num of images used for training")
FLAGS = flags.FLAGS

def convolution(i,j,kernel,image):
    pix = 0.0;
    for k in range(i,i+5):
        for l in range(j,j+5):
            pix+= (image[k][l] * kernel[k-i][l-j])
            #cout<<pix<<endl
    #return (pix/sum);
    return pix;

def main():
	# read data
    
                
               
        
    train_images, train_labels, test_images, test_labels, class_list = data3.import_data(FLAGS.use_classes)
    print('Training image size:', train_images.shape)
    print('Testing_image size:', test_images.shape)
    

    kernel_sizes=saab3.parse_list_string(FLAGS.kernel_sizes)
    if FLAGS.num_kernels:
    	num_kernels=saab3.parse_list_string(FLAGS.num_kernels)
    else:
    	num_kernels=None
    energy_percent=FLAGS.energy_percent
    use_num_images=FLAGS.use_num_images
    print('Parameters:')
    print('use_classes:', class_list)
    print('Kernel_sizes:', kernel_sizes)
    print('Number_kernels:', num_kernels)
    print('Energy_percent:', energy_percent)
    print('Number_use_images:', use_num_images)

    pca_params=saab3.multi_Saab_transform(train_images, train_labels,
    	                 kernel_sizes=kernel_sizes,
    	                 num_kernels=num_kernels,
    	                 energy_percent=energy_percent,
    	                 use_num_images=use_num_images,
    	                 use_classes=class_list)
    # save data
    fw=open('pca_params2.pkl','wb')    
    pickle.dump(pca_params, fw)    
    fw.close()

    # load data
    fr=open('pca_params2.pkl','rb')  
    data1=pickle.load(fr)
    print(data1)
    fr.close()

if __name__ == '__main__':
	main()
