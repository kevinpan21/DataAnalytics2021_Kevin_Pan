Project summary:
	This project uses Convoluntional Neural Network to binary classify cloudstreet dataset. The dataset is rbg image data.
	A modified version of AlexNet will be used for CNN. The modified version produces slightly better result and runs much faster.

Dataset description:
	Cloud Streets
	The organization of cumulus clouds into elongated rows oriented parallel to the mean boundary layer flow is a phenomenon often referred to as cloud streets. 
	Organized cumulus cloud streets are the visual manifestation of underlying boundary layer roll circulations commonly referred to as horizontal convective rolls. 
	Formation of boundary layer rolls is attributed to two instability mechanisms – thermal and dynamic instability.
	Direct impacts of cloud streets are fairly minimal as they typically do not precipitate or have meaningful environmental impacts aside from surface radiation. 
	The effects of cloud streets are most notable in the presence of sea breeze circulations as intersections of roll circulations and sea breeze circulations are known to force convective initiation. 
	Coastal convection is a primary source of precipitation in these settings and can grow upscale to propagating mesoscale convective systems that modulate the regional and even global precipitation budgets.
	https://github.com/NASA-IMPACT/data_share
	
metadata: Location: the data is obtained on NASA AWS server. 
	  Method: the data is pulled from, "aws s3 cp --recursive s3://impact-datashare/cloudstreet . --no-sign-request"
	  Data & Time: March, 12. 2021
	  Format: .jpg

System requirement:
	Python 3.8 (or above)
	Tensorflow 2.4
	Nvidia RTX 2060 GPU - cuda 11.0 - cudnn 11.0  (or equivalent)
	RAM 16 GB (or more)

How to run the programs:
	1) Create a directory 
	2) Pull cloudstreet dataset from NASA AWS server, "aws s3 cp --recursive s3://impact-datashare/cloudstreet . --no-sign-request". 
	   Place the dataset "yes", "no" into the directory
	2) Download and extract "dataPreprocessing.py", "driver.py", and "YES_NOT_TO_INCLUDE.txt" and place them in the same directory.
	3) Run "driver.py"
		Note: before running for the first time, MAKE SURE all the parameters in controller() are initalized to True
		      several files will be generated.
	5) The final model and weights will be stored in CNN_Model

	
	
	