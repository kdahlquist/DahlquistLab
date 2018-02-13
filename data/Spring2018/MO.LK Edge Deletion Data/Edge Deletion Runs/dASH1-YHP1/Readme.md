### GRNmap Testing Report
## Test Conditions

* Date: January 22, 2018
* Run time: Started at 3:34pm
* Test Performed by: @maggie-oneil
* Code Version: beta
* MATLAB Version: R2014b
* Computer on which the model was run: paradoxus CPU3

## Purpose

*To serve as a control for the edge deletion experiment. Looking at how workbooks with missing data run on GRNmap v1.8 as compared to running workbooks with missing data on the beta version of GRNmap or workbooks with no missing data on v1.8 of GRNmap

## Results

* Input sheet: [[Media:]]
* Output sheet: [[Media:]]
* Output .mat file (zipped): [[Media:]]
** LSE:
** Penalty term:
** Number of iterations (counter):
* Figures (all expression graphs .jpg files zipped together): [[Media:]]
* Save the progress figure containing the counts manually: [[Media:]]
* analysis.xlsx containing bar graphs: [[Media:]]
* GRNsight figure of unweighted network: [[Image:]]
* GRNsight figure of weighted network: [[Image:*filename here*|thumb|center|400px]]

## Discussion

* Discuss the results of the test with regards to the stated purpose.  Additionally, answer the relevant questions below:
** Examine the graphs that were output by each of the runs. Which genes in the model have the closest fit between the model data and actual data? Which genes have the worst fit between the model and actual data? Why do you think that is? (Hint: how many inputs do these genes have?) How does this help you to interpret the microarray data?
** Which genes showed the largest dynamics over the timecourse? In other words, which genes had a log fold change that is different than zero at one or more timepoints. The p values from the Week 11 ANOVA analysis are informative here. Does this seem to have an effect on the goodness of fit (see question above)?
** Which genes showed differences in dynamics between the wild type and the other strain your group is using? Does the model adequately capture these differences? Given the connections in your network (see the visualization in GRNsight), does this make sense? Why or why not?
** Examine the bar charts comparing the weights and production rates between the two runs. Were there any major differences between the two runs? Why do you think that was? Given the connections in your network (see the visualization in GRNsight), does this make sense? Why or why not?
** What other questions should be answered to help us further analyze the data?
