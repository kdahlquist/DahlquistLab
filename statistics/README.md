# statistics

This directory contains scripts to perform statistical analysis of the Dahlquist Lab microarray data.  A full description is found on the OpenWetWare protocol page: [Dahlquist:Microarray Data Analysis Worflow](http://www.openwetware.org/wiki/Dahlquist:Microarray_Data_Analysis_Workflow).

## Contents

* betweenStrainMissingDataHandler.m
* one_strain_ANOVA_corrected_20140725.m
* oneStrainMissingDataHandler.m
** TODO: verify with @bengfitzpatrick that the following means the Average Log Fold Change
`out_data_cells{1,3} = [strain '_t15'];`
`out_data_cells{1,4} = [strain '_t30'];`
`out_data_cells{1,5} = [strain '_t60'];`
`out_data_cells{1,6} = [strain '_t90'];`
`out_data_cells{1,7} = [strain '_t120'];`

* two_strain_compare_corrected_20140813_3pm.m
