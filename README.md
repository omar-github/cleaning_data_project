cleaning_data_project
=====================

This Repo has the cleaning data course project code.

run_analysis() does the following in order to reach a tidy data set:

1. It reads in features file and then select the positions of the needed features name.
2. Then it reads the X_train, y_label, activity_label for both train and test data and merge them together.
3. Afterwards, using the naming obtained from features table, it name all the columns according to their correct names in order to have a descriptive data set.
4. Then it splits the data set first according to the activity, and calculate the mean of each variable for each activity.(6 activities)
5. It repeats the same for each subject. (30 subjects)
6. Then it merges all together ( 36 rows for 6 activites and 30 subjects and 66 columns for the features)
7. Finally, it writes an output text file (tidy.txt) with the clean data set.
