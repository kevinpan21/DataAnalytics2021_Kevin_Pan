import matplotlib.image as mpimg
import os
import pathlib 
import shutil
import random
import numpy as np

class DATA_PROCESSING: 
    # crop images base on the min_dim by the center
    # @para: img, min_dim
    # @return: img
    def crop (self, img, dim):
        w,h,c = img.shape
        w_begin = (w-dim)//2
        w_end = w_begin + dim
        h_begin = (h-dim)//2
        h_end = h_begin + dim
        img_cropped = img[w_begin:w_end , h_begin:h_end, :]
        w,h,c = img_cropped.shape
        # split into 4 img
        c1 = img_cropped[0:w//2,0:h//2,:]
        c2 = img_cropped[0:w//2,h//2:,:]
        c3 = img_cropped[w//2:,0:h//2,:]
        c4 = img_cropped[w//2:,h//2:,:]
        return c1, c2, c3, c4
    
    # scaleing all images from the input folder to output_folder
    # @para: input_folder, output_folder
    # @return: none
    def scaleImg(self, input_folder, train_folder, test_folder, discarded_folder, threshold, starting_index):
        # getting all the image names
        names = [] 
        input_path = os.getcwd() + input_folder
        for root, dirs, files in os.walk(input_path,topdown = True):
            for name in files: 
                _, ending = os.path.splitext(name)
                if ending == ".jpg":
                    names.append(name)   
        
        # append all images
        min_dim = 750 # min dimension for square images
        train_path = os.getcwd() + train_folder # empty out the folder
        test_path = os.getcwd() + test_folder 
        discarded_path = os.getcwd() + discarded_folder 
        
        # empty out the folders
        if (pathlib.Path(train_path).exists()):
            shutil.rmtree(train_path)
        if (pathlib.Path(test_path).exists()):
            shutil.rmtree(test_path)
        if (pathlib.Path(discarded_path).exists()):
            shutil.rmtree(discarded_path)
            
        # making new folders and store
        os.makedirs(train_path)
        os.makedirs(test_path)
        os.makedirs(discarded_path)
        
        random.shuffle(names)
        num_test = len(names)//4
        for i in range(len(names)):
            img = mpimg.imread(os.path.join(input_path,names[i]))   
            width,height,channel = img.shape
            dim = min(width,height)
            
            # too much black pixels, discard
            sought = [0,0,0]
            black = np.count_nonzero(np.all(img==sought,axis=2))
            if (black > threshold):
                starting_index += 1
                output_name = os.path.join(discarded_path,str(starting_index)+'.jpg')
                mpimg.imsave(output_name, img) 
                
            elif(dim >= min_dim):
                # belongs to the testing set
                if (i <= num_test):
                    output_name1 = os.path.join(test_path,str(starting_index)+'_1' + '.jpg')
                    output_name2 = os.path.join(test_path,str(starting_index)+'_2' + '.jpg')
                    output_name3 = os.path.join(test_path,str(starting_index)+'_3' + '.jpg')
                    output_name4 = os.path.join(test_path,str(starting_index)+'_4' + '.jpg')
                    
                # belongs to the training set
                elif (i > num_test):
                    output_name1 = os.path.join(train_path,str(starting_index)+'_1' + '.jpg')
                    output_name2 = os.path.join(train_path,str(starting_index)+'_2' + '.jpg')
                    output_name3 = os.path.join(train_path,str(starting_index)+'_3' + '.jpg')
                    output_name4 = os.path.join(train_path,str(starting_index)+'_4' + '.jpg')
                starting_index += 1
                c1, c2, c3, c4 = self.crop(img, min(dim, min_dim))
                mpimg.imsave(output_name1, c1)
                mpimg.imsave(output_name2, c2)
                mpimg.imsave(output_name3, c3)
                mpimg.imsave(output_name4, c4)
        return starting_index

    def main(self):
        # scaling the "no" data
        index = self.scaleImg('\\no\\', '\\NO_train\\', '\\NO_test\\', '\\NO_Discarded\\', 100000, 0)

        # scaling the "yes" data
        index = self.scaleImg('\\yes\\', '\\YES_train\\', '\\YES_test\\','\\YES_Discarded\\', 400000, index)