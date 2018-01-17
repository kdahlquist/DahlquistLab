This directory will hold the results of Spring 2018 research.

The text below is a sample GRNmap model testing report.

This is a template page for various GRNmap model tests. The name of the page should start with the phrase GRNmap Testing Report, then a description of the test, the date in the format yyyy-mm-dd, and the initials of the person who performed the test. 

## Test Conditions

* Date: 
* Test Performed by: <nowiki>[[link to user page]], [[link to electronic notebook]]</nowiki>
* Code Version:
* MATLAB Version:
* Computer on which the model was run:

## Purpose

* State the purpose of this particular test.
* Link to Issue # on GRNmap @ GitHub.

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
