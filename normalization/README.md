# normalization

This directory contains files and scripts needed to normalize the Dahlquist Lab microarray data.  A full description is found on the OpenWetWare protocol page: [Dahlquist:Microarray Data Analysis Worflow](http://www.openwetware.org/wiki/Dahlquist:Microarray_Data_Analysis_Workflow).

## Contents

* old_versions: directory, see README inside directory for contents and description
* GCAT-and-Ontario\_normalization_script.R
  * R script that performs within- and between-chip normalization for the GCAT and Ontario chip types.  A full description of the data processing is found on the OpenWetWare [Dahlquist:Microarray Data Analysis Workflow page](http://www.openwetware.org/wiki/Dahlquist:Microarray_Data_Analysis_Workflow). 
  * Put the script, Targets files, and all `*.gpr` files in the same folder to run. 
  * Use this script with [Version x64 3.1.0 of R](http://cran.r-project.org/bin/windows/base/old/3.1.0/).
  * Use this script with Version 3.20.1 of the limma package, found in this directory.
  * The GCAT Targets file: GCAT\_Targets_20160616.csv and Ontario Targets file: Ontario\_Targets\_wt-dCIN5-dGLN3-dHAP4-dHMO1-dSWI4-dZAP1_20160616.csv are hardcoded into the script, but may be changed by altering the script. 
* GCAT\_Targets_20160616.csv
  * The Targets file for the GCAT chip type, required by the normalization script.
* Limma_3.20.1.zip
  * R package required for the the normalization script.  Reference: Smyth, G. K., 2005, Limma: linear models for microarray data. In _Bioinformatics and computational biology solutions using R and Bioconductor_, pp. 397-420, Springer New York.
* Ontario\_Targets_wt-Spar_20160616.csv
  * The Targets file for the Ontario chip type, to be used when normalizing the _Saccharomyces cerevisiae_ wild type strain and _Saccharomyces paradoxus_ microarray data only.
* Ontario\_Targets\_wt-dCIN5-dGLN3-dHAP4-dHMO1-dSWI4-dZAP1-Spar_20160616.csv
  * The Targets file for the Ontario chip type, to be used when normalizing the _Saccharomyces cerevisiae_ wild type and deletion strains and _Saccharomyces paradoxus_ microarray data together.
* Ontario\_Targets\_wt-dCIN5-dGLN3-dHAP4-dHMO1-dSWI4-dZAP1_20160616.csv
  * The Targets file for the Ontario chip type, to be used when normalizing the _Saccharomyces cerevisiae_ wild type and deletion strains microarray data together.  This is the filename hardcoded into the normalization script.
* generate\_MA\_and\_box_plots.R
  * A script to automatically generate MA and box plots showing the results of the normalization.  Put it in the same directory as the `GCAT-and-Ontario\_normalization_script.R`, Ontario and GCAT Targets files, and `*gpr` files.  Run immediately after running the normalization script.
