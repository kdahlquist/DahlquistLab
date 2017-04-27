Thursday: I computed the minMSE values for the DB5 network so that I could use the information for my Symposium presentation. The following protocol was done.
#Using the log2 expression data for the specific strain in a input sheet, average the values for the same timepoints
#* i.e. for wt strain, there are four 15 time point measurements, five 30 time point measurements, and four 60 time point measurements. Therefore, the first gene's average log fold expression change is averaged across four timepoints for 15, five for 30, and four for 60.
#** ABF1 averages: 15 = -1.1878; 30 = -1.1819; 60 = -1.9142
#Next, the difference between each individual log2 expression at a given time point and the average for that given time point was found.
#* i.e for wt's ABF1 gene, we see the following formula: = t15.1 - avg15, where t15.1 is the individual log2 expression at the first 15 time point and avg15 is the average of the four observed expression changes at 15 time point replicates
#** ABF1's first 15 time point: = B2 - P2 = t15.1 - avg15 = -2.1071 - (-1.1878) = -0.9193
#Then, the differences are squared so that no negative numbers result and to account for differences seen above and below this difference
#* i.e. for wt's ABF1 gene, we see the following formula in the cell: = B20^2
#The squared differences were then summed up for all the time points and divided by the total number of time points.
#* The formula used was as follows: =SUM(B38:N38)/13 (based off wt's ABF1 gene)
#** i.e. for wt, there are 13 time points (four 15 time points + five 30 time points + four 60 time points = 13)
#** Note that the sum for all these time points differs for each individual strain, such that db4 (dGLN3) has 12 overall time points
#To ensure that these calculations were correct, I first used this procedure to calculate the MSE observed via the model. After I receive the same output values, I proceeded to calculate the actual minMSEs.
