# https---github.com-deep2843-hello-worldREAD ME run_analysis.R

HOW CODE WORKS:

1. Download the file from the link:
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2. Change the working directory in the R code so that the files can be readed in easily

3. Read the set of training files from the train folder the files to read are X_train, Y_train 

4. Similarly read in X_test and Y_test from the Test folder of the downloaded files

5. Also read in the feaures.txt which has 561 labels for the columns in X test and X train.

6 Read in activity_labels. Which define the variable Y.

7. Once all this is done use names to create the colnames in X_Train and X_Test, Also read in Subject_test and Subject_train file.

8. The code first combined subject_test, x_test, y_test using the cbind function and then combines subject_train, y_train, x_train. Once these are combined using r bind combine the test and train data into a dataset called "data"

9.The next step is to keep varibles which are measurments of mean and std. For this I am using the grep function which returns the indexes corresponding to the col names.

10. Using this I subset the data and extract all the required fields.

11. To get activity name field into the data. I am using the package data.table and merging the activity labels and data with the field Activity_ID.

12. Once this is created all the variable in the frame are named in accordance so that fields are readable.

13. To create the final data frame with mean on all variables by activity name and subject id. I use the aggreagate funcion in stats package.

14 Finally I write the data set to a final file without any row name
