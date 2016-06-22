# old_versions

This directory contains old versions of the normalization script and targets files, as described below.

## Contents

* GCAT-and-Ontario_normalization_script_no-rounding.R
  * Script that performs within- and between-chip normalization of GCAT-type and Ontario-type chips and outputs data for all decimal places computed by R.  This script has been replaced by one that rounds to 4 digits past the decimal.
  * It is hardcoded with the GCAT targets file: `GCAT_Targets_old-filenames.csv` and the Ontario Targets file: `Ontario_Targets_wt-dCIN5-dGLN3-dHAP4-dHMO1-dSWI4-dZAP1-Spar_old-filenames_20150514.csv`.
* GCAT_Targets_old-and-new-filenames_20160616.csv
  * Shows correspondence between old `*.gpr` filenames and new filenames that were generated for the GEO submission.  _Do not actually use with the normalization script._
* GCAT_Targets_old-filenames.csv
  * Specifies information needed to run normalization script for GCAT chips using the `*.gpr` filenames before they were changed for the GEO submission.
* Ontario_Targets_wt-dCIN5-dGLN3-dHAP4-dHMO1-dSWI4-dZAP1-Spar_old-and-new-filenames_20160616.csv
  * Shows correspondence between old `*.gpr` filenames and new filenames that were generated for the GEO submission. _Do not actually use with the normalization script._
* Ontario_Targets_wt-dCIN5-dGLN3-dHAP4-dHMO1-dSWI4-dZAP1-Spar_old-filenames_20150514.csv
  * Specifies information needed to run normalization script for Ontario chips using the `*.gpr` filenames before they were changed for the GEO submission..
