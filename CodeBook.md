##Data for Course Project Getting and Cleaning Data

For this course project data from the following publicly available dataset were processed:


####Human Activity Recognition Using Smartphones Dataset Version 1.0


> Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.  
> Smartlab - Non Linear Complex Systems Laboratory  
> DITEN - Università degli Studi di Genova.  
> Via Opera Pia 11A, I-16145, Genoa, Italy.  
> activityrecognition@smartlab.ws  
> www.smartlab.ws  


see also: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

the original description of the data can be found in the following 2 files:

* [features_info.txt](features_info.txt)
* [features.txt](features.txt)


The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ

The subjects participating in the experiment are identified by an id from 1-30


The activities for which measurements were taken are:  

<table border=1>
  <tr><th>id</th><th>activity label</th></tr>
  <tr><td>1</td><td>WALKING</td></tr>
  <tr><td>2</td><td>WALKING_UPSTAIRS</td></tr>
  <tr><td>3</td><td>WALKING_DOWNSTAIRS</td></tr>
  <tr><td>4</td><td>SITTING</td></tr>
  <tr><td>5</td><td>STANDING</td></tr>
  <tr><td>6</td><td>LAYING</td></tr>
</table>
  
  

For this course project the means and standard deviations of the following measurements were averaged by activity and subject:

<table border="1">
  <tr>
    <th>index in original dataset</th>
    <th>measurement name</th>
  </tr>
  <tr>
    <td>1</td><td>tBodyAcc.mean.X</td>
  </tr>
  <tr>
    <td>2</td><td>tBodyAcc.mean.Y</td>
  </tr>
  <tr>
    <td>3</td><td>tBodyAcc.mean.Z</td>
  </tr>
  <tr>
    <td>4</td><td>tBodyAcc.std.X</td>
  </tr>
  <tr>
    <td>5</td><td>tBodyAcc.std.Y</td>
  </tr>
  <tr>
    <td>6</td><td>tBodyAcc.std.Z</td>
  </tr>
  <tr>
    <td>41</td><td>tGravityAcc.mean.X</td>
  </tr>
  <tr>
    <td>42</td><td>tGravityAcc.mean.Y</td>
  </tr>
  <tr>
    <td>43</td><td>tGravityAcc.mean.Z</td>
  </tr>
  <tr>
    <td>44</td><td>tGravityAcc.std.X</td>
  </tr>
  <tr>
    <td>45</td><td>tGravityAcc.std.Y</td>
  </tr>
  <tr>
    <td>46</td><td>tGravityAcc.std.Z</td>
  </tr>
  <tr>
    <td>81</td><td>tBodyAccJerk.mean.X</td>
  </tr>
  <tr>
    <td>82</td><td>tBodyAccJerk.mean.Y</td>
  </tr>
  <tr>
    <td>83</td><td>tBodyAccJerk.mean.Z</td>
  </tr>
  <tr>
    <td>84</td><td>tBodyAccJerk.std.X</td>
  </tr>
  <tr>
    <td>85</td><td>tBodyAccJerk.std.Y</td>
  </tr>
  <tr>
    <td>86</td><td>tBodyAccJerk.std.Z</td>
  </tr>
  <tr>
    <td>121</td><td>tBodyGyro.mean.X</td>
  </tr>
  <tr>
    <td>122</td><td>tBodyGyro.mean.Y</td>
  </tr>
  <tr>
    <td>123</td><td>tBodyGyro.mean.Z</td>
  </tr>
  <tr>
    <td>124</td><td>tBodyGyro.std.X</td>
  </tr>
  <tr>
    <td>125</td><td>tBodyGyro.std.Y</td>
  </tr>
  <tr>
    <td>126</td><td>tBodyGyro.std.Z</td>
  </tr>
  <tr>
    <td>161</td><td>tBodyGyroJerk.mean.X</td>
  </tr>
  <tr>
    <td>162</td><td>tBodyGyroJerk.mean.Y</td>
  </tr>
  <tr>
    <td>163</td><td>tBodyGyroJerk.mean.Z</td>
  </tr>
  <tr>
    <td>164</td><td>tBodyGyroJerk.std.X</td>
  </tr>
  <tr>
    <td>165</td><td>tBodyGyroJerk.std.Y</td>
  </tr>
  <tr>
    <td>166</td><td>tBodyGyroJerk.std.Z</td>
  </tr>
  <tr>
    <td>201</td><td>tBodyAccMag.mean</td>
  </tr>
  <tr>
    <td>202</td><td>tBodyAccMag.std</td>
  </tr>
  <tr>
    <td>214</td><td>tGravityAccMag.mean</td>
  </tr>
  <tr>
    <td>215</td><td>tGravityAccMag.std</td>
  </tr>
  <tr>
    <td>227</td><td>tBodyAccJerkMag.mean</td>
  </tr>
  <tr>
    <td>228</td><td>tBodyAccJerkMag.std</td>
  </tr>
  <tr>
    <td>240</td><td>tBodyGyroMag.mean</td>
  </tr>
  <tr>
    <td>241</td><td>tBodyGyroMag.std</td>
  </tr>
  <tr>
    <td>253</td><td>tBodyGyroJerkMag.mean</td>
  </tr>
  <tr>
    <td>254</td><td>tBodyGyroJerkMag.std</td>
  </tr>
  <tr>
    <td>266</td><td>fBodyAcc.mean.X</td>
  </tr>
  <tr>
    <td>267</td><td>fBodyAcc.mean.Y</td>
  </tr>
  <tr>
    <td>268</td><td>fBodyAcc.mean.Z</td>
  </tr>
  <tr>
    <td>269</td><td>fBodyAcc.std.X</td>
  </tr>
  <tr>
    <td>270</td><td>fBodyAcc.std.Y</td>
  </tr>
  <tr>
    <td>271</td><td>fBodyAcc.std.Z</td>
  </tr>
  <tr>
    <td>345</td><td>fBodyAccJerk.mean.X</td>
  </tr>
  <tr>
    <td>346</td><td>fBodyAccJerk.mean.Y</td>
  </tr>
  <tr>
    <td>347</td><td>fBodyAccJerk.mean.Z</td>
  </tr>
  <tr>
    <td>348</td><td>fBodyAccJerk.std.X</td>
  </tr>
  <tr>
    <td>349</td><td>fBodyAccJerk.std.Y</td>
  </tr>
  <tr>
    <td>350</td><td>fBodyAccJerk.std.Z</td>
  </tr>
  <tr>
    <td>424</td><td>fBodyGyro.mean.X</td>
  </tr>
  <tr>
    <td>425</td><td>fBodyGyro.mean.Y</td>
  </tr>
  <tr>
    <td>426</td><td>fBodyGyro.mean.Z</td>
  </tr>
  <tr>
    <td>427</td><td>fBodyGyro.std.X</td>
  </tr>
  <tr>
    <td>428</td><td>fBodyGyro.std.Y</td>
  </tr>
  <tr>
    <td>429</td><td>fBodyGyro.std.Z</td>
  </tr>
  <tr>
    <td>503</td><td>fBodyAccMag.mean</td>
  </tr>
  <tr>
    <td>504</td><td>fBodyAccMag.std</td>
  </tr>
  <tr>
    <td>516</td><td>fBodyBodyAccJerkMag.mean</td>
  </tr>
  <tr>
    <td>517</td><td>fBodyBodyAccJerkMag.std</td>
  </tr>
  <tr>
    <td>529</td><td>fBodyBodyGyroMag.mean</td>
  </tr>
  <tr>
    <td>530</td><td>fBodyBodyGyroMag.std</td>
  </tr>
  <tr>
    <td>542</td><td>fBodyBodyGyroJerkMag.mean</td>
  </tr>
  <tr>
    <td>543</td><td>fBodyBodyGyroJerkMag.std</td>
  </tr>
</table>

----
  
Unfortunately i do not really understand these measurements and how they were derived from the original sensor signals available in the dataset (but ignored for this project).
  
----  

final quote from original data description:
  
###### Notes:  
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
  
For more information about this dataset contact: activityrecognition@smartlab.ws
  
###### License:  
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
  
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
  
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
  
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
  