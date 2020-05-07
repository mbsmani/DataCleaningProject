# DataCleaningProject
Solution to Data Science course in coursera 


The code actually takes the training and testing datasets into two variables, "train" and "test" respectively and then does the following:

1. Inorder to use the "dplyr" package, we need to remove the duplicate column names and thus I appended a "X" or "Y" or "Z" to all the columns with the same name. This is done keeping in mind that the readings are actually from the three axes.

2. Then we add the column names to the "train" and "test" variables which originally was loaded with column names V1,V2....V561

3. Before we merge the dataset we need to append the subjects and descriptive activity names to the training and test datasets. The descriptive activity name is taken from the "activity_label.txt" file and assign it to all the activities in "y_train" and "y_test". 

4. Then the actual merge is done with the rbind() funtion. This completes the instruction 1,3 and 4.

5. Then instruction 2 is completed by using grep to extract columns with "mean()" and "std()" which indicates only the mean and standard deviation of each measurements. Now instruction 1 to 4 are completed.

6. Finally instruction 5 is completed by grouping the dataset based on subject and activity names(labels), using the "group_by()" dplyr function. This is chained "summarise_if()" funtion, which calculates mean of all the numeric columns (columns except the labels and subjects) and creates the new required independent tidy dataset and writes it into a file.

NOTE:

The new dataset in step 5 was created from the dataset that contains the extracted information in instruction 2. If we wanted to create this from the entire merged dataset uncomment the final line in the script and run it.
