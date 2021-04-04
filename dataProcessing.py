import matplotlib.image as mpimg
import os
import pathlib 
import shutil
import random
import numpy as np

class DATA_PROCESSING: 
    def filters (self, img, name):
        # no cloud, discard
        if (np.count_nonzero(np.all(img>=[85,85,85],axis=2)) < 5):
            mpimg.imsave(name, img) 
            return None
        
        # all while, discard
        if (np.count_nonzero(np.all(img>=[160,160,160],axis=2)) > 65500):
            mpimg.imsave(name, img) 
            return None
        return img
    
    # crop images base on the min_dim by the center
    # @para: img, min_dim
    # @return: img
    def crop (self, img, min_dim):
        # crop to square img
        w,h,c = img.shape
        if (w != h):
            newDim = min(w, h) 
            w_begin = (w-newDim)//2
            w_end = w_begin + newDim
            h_begin = (h-newDim)//2
            h_end = h_begin + newDim
            img = img[w_begin:w_end , h_begin:h_end, :]
        assert(img.shape[0] == img.shape[1] and img.shape[2] == 3)
            
        # split into mutiple img based on min_dim
        w,h,c = img.shape
        numCropped = w//min_dim
        # img too large, hard to extract useful information
        if (numCropped >= 5):
            return []
        
        croppedList = []
        for i in range(numCropped):
            for j in range(numCropped):
                currImg = img[i*min_dim:(i+1)*min_dim, j*min_dim:(j+1)*min_dim, :]
                croppedList.append(currImg)
        return croppedList

    
    # scaleing all images from the input folder to output_folder
    # @para: input_folder, output_folder
    # @return: none
    def scaleImg(self, input_folder, train_folder, test_folder, discarded_folder, starting_index):
        # getting all the image names
        names = [] 
        input_path = os.getcwd() + input_folder
        for root, dirs, files in os.walk(input_path,topdown = True):
            for name in files: 
                _, ending = os.path.splitext(name)
                if ending == ".jpg":
                    names.append(name)   
        
        # append all images
        min_dim = 256 # min dimension for square images
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
                            
            # large enough to be saved
            if(dim >= min_dim):
                imgList = self.crop(img, min_dim)
                # belongs to the testing set
                if (i <= num_test):
                    for i in range(len(imgList)):
                        output_name = os.path.join(test_path,str(starting_index)+'_' + str(i) + '.jpg')
                        if (input_folder[1] == 'n'):
                            mpimg.imsave(output_name, imgList[i])
                        else:
                            currImg = self.filters(imgList[i], os.path.join(discarded_path,str(starting_index)+'_' + str(i) + '.jpg'))
                            if (not currImg is None):
                                mpimg.imsave(output_name, currImg)
                # belongs to the training set
                else:
                    for i in range(len(imgList)):
                        output_name = os.path.join(train_path, str(starting_index)+'_' + str(i) + '.jpg')
                        if (input_folder[1] == 'n'):
                            mpimg.imsave(output_name, imgList[i])
                        else:
                            currImg = self.filters(imgList[i], os.path.join(discarded_path,str(starting_index)+'_' + str(i) + '.jpg'))
                            if (not currImg is None):
                                mpimg.imsave(output_name, currImg)
                starting_index += 1

        return starting_index

    def main(self):
        # scaling the "yes" data
        index = self.scaleImg('\\yes\\', '\\YES_train\\', '\\YES_test\\','\\YES_Discarded\\', 0)
        
        # scaling the "no" data
        index = self.scaleImg('\\no\\', '\\NO_train\\', '\\NO_test\\', '\\NO_Discarded\\', index)
