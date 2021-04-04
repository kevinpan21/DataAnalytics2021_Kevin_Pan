import tensorflow as tf
from tensorflow.keras import layers, models, optimizers
from tensorflow.keras.models import Sequential
import numpy as np
import matplotlib.pyplot as plt
import os
import matplotlib.image as mpimg
from dataProcessing import DATA_PROCESSING

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
                names.append(name)   
    # append all images
    if (not size is None):
        names = names[:size]
    for name in names:
        img = mpimg.imread(os.path.join(path,name))   
        X.append(img)
        Y.append(label)

    return np.asarray(X, dtype=np.float16), np.asarray(Y, dtype=np.float16)

def visualize(model):
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
    

def plot(history):
    L_train = history.get("loss")
    Acc = history.get('accuracy')
    
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

def result(model):
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
    
def AlexNet(X, Y):
    # hyper parameters
    batchSize = 250
    maxItr = 500
    shape = [256, 256, 3]
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
    history = model.fit(X, Y, batch_size=batchSize, steps_per_epoch = 2, epochs=maxItr, verbose=1)
    return model, history

def VGG(X, Y):
    # hyper parameters
    batchSize = 150
    maxItr = 500
    shape = [256, 256, 3]
    K = 1
    
    model = Sequential()
    model.add(layers.Conv2D(16, (3,3), strides=2,padding="VALID",input_shape=shape))
    model.add(layers.Activation("relu"))
    model.add(layers.Conv2D(16, (3,3), strides=2,padding="VALID"))
    model.add(layers.Activation("relu"))
    model.add(layers.MaxPool2D(2, strides=2, padding="VALID"))
    model.add(layers.BatchNormalization())
    model.add(layers.Dropout(0.2))
        
    model.add(layers.Conv2D(128, (3,3), strides=1,padding="VALID"))
    model.add(layers.Activation("relu"))
    model.add(layers.Conv2D(256, (3,3), strides=1,padding="VALID"))
    model.add(layers.Activation("relu"))
    model.add(layers.Dropout(0.2))
    model.add(layers.Conv2D(128, (3,3), strides=1,padding="VALID"))
    model.add(layers.Activation("relu"))
    model.add(layers.Dropout(0.2))
    model.add(layers.MaxPool2D(2, strides=2, padding="VALID"))
    model.add(layers.BatchNormalization())
    model.add(layers.Dropout(0.2))
    
    
    model.add(layers.Flatten())
    model.add(layers.Dense(120,activation='relu'))
    model.add(layers.Dropout(rate=0.2))
    
    model.add(layers.Dense(10,activation='relu'))
    model.add(layers.Dropout(rate=0.2))
    
    model.add(layers.Dense(K, activation='sigmoid'))
    
    model.compile(loss='BinaryCrossentropy', optimizer='adam', metrics=['accuracy'])
    history = model.fit(X, Y, batch_size=batchSize, steps_per_epoch = 2, epochs=maxItr, verbose=1)
    return model, history

def LeNet (X, Y):
    # hyper parameters
    batchSize = 200
    maxItr = 500
    shape = [256, 256, 3]
    K = 1
    
    model = Sequential()
    model.add(layers.Conv2D(8, (11,11), strides=1,padding="VALID",input_shape=shape))
    model.add(layers.Activation("relu"))
    model.add(layers.MaxPool2D(2, strides=2, padding="VALID"))
    model.add(layers.BatchNormalization())
    model.add(layers.Dropout(0.2))
    
    model.add(layers.Conv2D(30, (5,5), strides=1,padding="VALID"))
    model.add(layers.Activation("relu"))
    model.add(layers.MaxPool2D(2, strides=2, padding="VALID"))
    model.add(layers.BatchNormalization())
    model.add(layers.Dropout(0.2))
    
    model.add(layers.Conv2D(80,(10,10),strides=1,padding='VALID'))
    model.add(layers.Activation("relu"))
    model.add(layers.Dropout(0.2))
    
    model.add(layers.Conv2D(80,(5,5),strides=1,padding='VALID'))
    model.add(layers.Activation("relu"))
    model.add(layers.MaxPool2D(2, strides=2, padding="VALID"))
    model.add(layers.BatchNormalization())
    model.add(layers.Dropout(0.2))
    
    
    model.add(layers.Flatten())
    model.add(layers.Dense(120,activation='relu'))
    model.add(layers.Dropout(rate=0.2))
    
    model.add(layers.Dense(10,activation='relu'))
    model.add(layers.Dense(K, activation='sigmoid'))
    
    model.compile(loss='BinaryCrossentropy', optimizer='adam', metrics=['accuracy'])
    history = model.fit(X, Y, batch_size=batchSize, steps_per_epoch = 2, epochs=maxItr, verbose=1)
    return model, history

def Customized (X, Y):
    # hyper parameters
    batchSize = 200
    maxItr = 500
    shape = [256, 256, 3]
    K = 1
    
    model = Sequential()
    model.add(layers.Conv2D(8, (5,5), strides=2,padding="VALID",input_shape=shape))
    model.add(layers.Activation("relu"))
    model.add(layers.MaxPool2D(2, strides=2, padding="VALID"))
    model.add(layers.BatchNormalization())
    model.add(layers.Dropout(0.2))
    
    model.add(layers.Conv2D(128, (5,5), strides=2,padding="VALID"))
    model.add(layers.Activation("relu"))
    model.add(layers.MaxPool2D(2, strides=2, padding="VALID"))
    model.add(layers.BatchNormalization())
    model.add(layers.Dropout(0.2))
    
    model.add(layers.Conv2D(256,(3,3),strides=2,padding='VALID'))
    model.add(layers.Activation("relu"))
    model.add(layers.BatchNormalization())
    model.add(layers.MaxPool2D(2, strides=2, padding="VALID"))
    model.add(layers.Dropout(0.2))
    
    model.add(layers.Conv2D(128,(3,3),strides=1,padding='VALID'))
    model.add(layers.Activation("relu"))
    model.add(layers.BatchNormalization())
    model.add(layers.Dropout(0.2))
    
    model.add(layers.Flatten())
    model.add(layers.Dense(10,activation='relu'))
    model.add(layers.Dropout(rate=0.2))
    model.add(layers.Dense(K, activation='sigmoid'))
    
    model.compile(loss='BinaryCrossentropy', optimizer='adam', metrics=['accuracy'])
    history = model.fit(X, Y, batch_size=batchSize, steps_per_epoch = 1, epochs=maxItr, verbose=1)
    return model, history


def main(processing, plotting, saving, visualizing, model_selected):
    # pre process the data
    if (processing):
        DATA_PROCESSING().main()  
        print("Data Processing Done")
    
    # loading in the data    
    yesX, yesY = loadingData('\\YES_train\\', None)
    noX, noY = loadingData("\\NO_train\\", len(yesY)) 
    print("Train data loaded")
    # split the training data into pre-train and train
    trainX = np.concatenate((noX, yesX), axis = 0)
    trainY = np.concatenate((noY, yesY), axis = 0)
    
    if (model_selected == "AlexNet"):
        # training the model on AlexNet
        model, history = AlexNet(trainX, trainY)
        trainX, trainY = [], [] # clearing memory
        print("Training with AlexNet completed")
        if (visualizing):
            visualize(model)
        if (plotting):
            plot(history.history)
        result(model)
        
    elif (model_selected == "VGG"):
        model, history = VGG(trainX, trainY)
        trainX, trainY = [], [] # clearing memory
        print("Training with VGG-16 completed")
        if (visualizing):
            visualize(model)
        if (plotting):
            plot(history.history)
        result(model)
        
    elif (model_selected == "LeNet"):
        model, history = LeNet(trainX, trainY)
        trainX, trainY = [], [] # clearing memory
        print("Training with LeNet-5 completed")
        if (visualizing):
            visualize(model)
        if (plotting):
            plot(history.history)
        result(model)

    elif (model_selected == "Customized"):
        model, history = Customized(trainX, trainY)
        trainX, trainY = [], [] # clearing memory
        print("Training with Customized completed")
        if (visualizing):
            visualize(model)
        if (plotting):
            plot(history.history)
        result(model)


def controller():
    processing = False # whether to process and split the data
    plotting = True # whether to generate plots
    saving = True # whether to save the model
    visualizing = True # whether to visulize the filters
    # models: "AlexNet", "VGG", "LeNet", "Customized"
    main(processing, plotting, saving, visualizing, "Customized")
    
    
if __name__ == "__main__":
    controller()
    