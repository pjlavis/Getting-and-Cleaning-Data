Code Book
======================

The data for this is data aollected from the accelerometers from the Samsung Galaxy S smartphone. A full description is avaliable below.

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data was initally added to two data tables Test_Data and Train_Data. These tables contained the Activity, Subject and data colllected for each observation for the respective Test and Train Data sets.

These were then combined into the Full_Data data set to create the full data set. The column names were names were added to this table

A new data table, Summary_Data, was then created by adding any column thats name contained "mean()" or "std()" to the activity and subject columns.

Then activity number was then replaced in the Full_Data and Summary_Data tables with the text description from the data file "activity_labels.txt"

Finally Tidy_Data was created by removing then duplicate column names and grouping the data by subject and activity with an finally average taken on each of these groups.