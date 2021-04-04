import tensorflow as tf
from tensorflow.keras import layers, models, optimizers
from tensorflow.keras.models import Sequential
import numpy as np
import matplotlib.pyplot as plt
import os
import matplotlib.image as mpimg
from dataPreprocessing import DATA_PROCESSING

gpus = tf.config.experimental.list_physical_devices('GPU')
if gpus:
    try:
        # Currently, memory growth needs to be the same across GPUs
        for gpu in gpus:
            tf.config.experimental.set_memory_growth(gpu, True)
        logical_gpus = tf.config.experimental.list_logical_devices('GPU')
        print(len(gpus), "Physical GPUs,", len(logical_gpus), "Logical GPUs")
    except RuntimeError as e:
        # Memory growth must be set before GPUs have been initialized
        print(e)

def loadingData(fileName, size):
    f= open("YES_NOT_TO_INCLUDE.txt", 'r')
    YES_NOT_INCLUDE = f.read().strip().split()
    f.close()
    removed = True
    
    label = 0
    if (fileName[1] == 'Y'):
        label = 1
    X = []
    Y = []
    names = []
    path = os.getcwd() + fileName
    for root, dirs, files in os.walk(path,topdown = True):
        for name in files: 
            _, ending = os.path.splitext(name)
            if ending == ".jpg":
                # not to include
                if (not removed and fileName[1] == 'Y' and name in YES_NOT_INCLUDE):
                    found = YES_NOT_INCLUDE.index(name)
                    YES_NOT_INCLUDE.pop(found)
                else:
                    names.append(name)   
    # append all images
    if (not size is None):
        names = names[:size]
    for name in names:
        img = mpimg.imread(os.path.join(path,name))   
        X.append(img)
        Y.append(label)

    return np.asarray(X, dtype=np.float16), np.asarray(Y, dtype=np.float16)

def plot(history1, history2):
    L_train = history1.get("loss")
    Acc = history1.get('accuracy')
    
    L_train += history2.get("loss")
    Acc += history2.get('accuracy')
    
    # ploting training loss
    iterations = np.arange(len(L_train))
    plt.plot(iterations,L_train)
    plt.title('Train Error')
    plt.xlabel('Number of Iterations')
    plt.ylabel('Loss')


    # ploting testing accuracy
    plt.figure()
    plt.plot(iterations,Acc)
    plt.title('Train Accuracy')
    plt.xlabel('Number of Iterations')
    plt.ylabel('Accuracy')

def AlexNet(X1, Y1, X2, Y2):
    # hyper parameters
    batchSize = 150
    maxItr = 250
    shape = [375, 375, 3]
    K = 1
    
    model = Sequential()
    model.add(layers.Conv2D(8, (11,11), strides=4,padding="VALID",input_shape=shape))
    model.add(layers.Activation("relu"))
    model.add(layers.MaxPool2D(2, strides=2, padding="VALID"))
    model.add(layers.BatchNormalization())
    model.add(layers.Dropout(0.2))
    
    model.add(layers.Conv2D(128, (5,5), strides=1,padding="VALID"))
    model.add(layers.Activation("relu"))
    model.add(layers.MaxPool2D(2, strides=2, padding="VALID"))
    model.add(layers.BatchNormalization())
    model.add(layers.Dropout(0.2))
    
    model.add(layers.Conv2D(256,(3,3),strides=1,padding='VALID'))
    model.add(layers.Activation("relu"))
    model.add(layers.Dropout(0.2))
    
    model.add(layers.Conv2D(256,(3,3),strides=1,padding='VALID'))
    model.add(layers.Activation("relu"))
    model.add(layers.MaxPool2D(2, strides=2, padding="VALID"))
    model.add(layers.BatchNormalization())
    model.add(layers.Dropout(0.2))
    
    model.add(layers.Conv2D(128,(3,3),strides=1,padding='VALID'))
    model.add(layers.Activation("relu"))
    model.add(layers.MaxPool2D(2, strides=2, padding="VALID"))
    model.add(layers.BatchNormalization())
    model.add(layers.Dropout(0.2))
    
    model.add(layers.Flatten())
    model.add(layers.Dense(10,activation='relu'))
    model.add(layers.Dropout(rate=0.2))
    
    model.add(layers.Dense(K, activation='sigmoid'))
    
    model.compile(loss='BinaryCrossentropy', optimizer='adam', metrics=['accuracy'])
    
    history1 = model.fit(X1, Y1, batch_size=batchSize, steps_per_epoch = 3, epochs=maxItr, verbose=1)
    print("Training from first batch completed")
    history2 = model.fit(X2, Y2, batch_size=batchSize, steps_per_epoch = 3, epochs=maxItr, verbose=1)
    print("Training from second batch completed")
    return model, [history1,history2]

def main(processing, plotting, saving, visulizing):
    # pre process the data
    if (processing):
        DATA_PROCESSING().main()  
        print("Data Processing Done")
    
    
    # loading in the data    
    yesX, yesY = loadingData('\\YES_train\\', None)
    noX, noY = loadingData("\\NO_train\\", len(yesY)) 

    # split the training data into pre-train and train
    noX_1, noX_2 = np.array_split(noX,2)
    noY_1, noY_2 = np.array_split(noY,2)
    yesX_1, yesX_2 = np.array_split(yesX,2)
    yesY_1, yesY_2 = np.array_split(yesY,2)
    noX, noY, yesX, yesY  = [], [], [], [] # clearing memory
    trainX_1 = np.concatenate((noX_1, yesX_1), axis = 0)
    trainY_1 = np.concatenate((noY_1, yesY_1), axis = 0)
    trainX_2 = np.concatenate((noX_2, yesX_2), axis = 0)
    trainY_2 = np.concatenate((noY_2, yesY_2), axis = 0)
    noX_1, noX_2, noY_1, noY_2 = [], [], [], [] # clearing memory
    yesX_1, yesX_2, yesY_1, yesY_2 = [],[], [],[]
    print("Train data loaded")
    
    # training the model on AlexNet
    model, history = AlexNet(trainX_1, trainY_1, trainX_2, trainY_2)
    trainX_1, trainY_1, trainX_2, trainY_2 = [], [], [], [] # clearing memory


    if (visulizing):
        weights, bias = model.layers[0].get_weights()

        #normalize filter values between  0 and 1 for visualization
        f_min, f_max = weights.min(), weights.max()
        filters = (weights - f_min) / (f_max - f_min)  
        
        #plotting all the filters
        for i in range(filters.shape[3]):
            plt.figure()
            plt.imshow(filters[:,:,:, i])
            plt.title("Filter" + str(i+1))
        plt.show()


    if (plotting):
        plot(history[0].history, history[1].history)
    
    # loading the testing dataset
    yesX, yesY = loadingData('\\YES_test\\', None)
    noX, noY = loadingData("\\NO_test\\", None)
    testX = np.concatenate((noX, yesX), axis = 0)
    testY = np.concatenate((noY, yesY), axis = 0)
    noX, noY = [], [] # clearing memory
    yesX, yesY = [], []
    print("Test data loaded")

    # test preformance on testing dataset
    test_loss, test_acc = model.evaluate(testX, testY, batch_size= 150)
    print("The final accuracy on testing dataset is: " + str(test_acc))


def controller():
    processing = False # whether to process and split the data
    plotting = True # whether to generate plots
    saving = True # whether to save the model
    visulizing = True # whether to visulize the filters
    main(processing, plotting, saving, visulizing)
    
    
if __name__ == "__main__":
    controller()
    