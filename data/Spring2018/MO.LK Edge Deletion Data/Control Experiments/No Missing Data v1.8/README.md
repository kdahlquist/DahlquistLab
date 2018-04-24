### GRNmap Testing Report
## Test Conditions

* Date: January 17, 2018
* Run time: Started at 10:09am | Ended at 11:24am
* Test Performed by: @maggie-oneil
* Code Version: v1.8
* MATLAB Version: R2014b
* Computer on which the model was run: cerevisiae

## Purpose

To serve as a control for the edge deletion experiment. Looking at how workbooks with missing data run on GRNmap v1.8 as compared to running workbooks with missing data on the beta version of GRNmap or workbooks with no missing data on v1.8 of GRNmap

## Results

* Input sheet: 15-genes_28-edges_db5-MO-LK_Sigmoid_estimation_no-missing-values.xlsx
* Output sheet:  15-genes_28-edges_db5-MO-LK_Sigmoid_estimation_no-missing-values_output.xlsx
* Output .mat file (zipped):
* LSE: 0.691926064
* Penalty term: 2.351711891
* Number of iterations (counter): 63546
* Figures (all expression graphs .jpg files zipped together): See Images folder
* Save the progress figure containing the counts manually: See Images folder

## Discussion
Decided based on this run, v1.8 with missing data, and beta with missing data that the edge deletion experiment would be performed using the db5 missing data workbooks on v1.8
