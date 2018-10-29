Input and output files for db3.
* _17-genes_32-edges_db3_Sigmoid_estimation_all-timepoints_no-dHAP4-data.xlsx_ STB5 has missing data for all three replicates of t90 for dHAP4. Create new input workbook without the dHAP4 expression data.
* Note in the initial version of the file, I forgot to update the optimization_parameters sheet with the correct timepoints for the expression and simulated data.
* Could not run updated input file, see issue on GRNmap: https://github.com/kdahlquist/GRNmap/issues/411.
* Turns out that some of the data in the expression worksheet was formatted as text.  Once this has been fixed, the model runs.  Restart run on _bayanus_ using code from @jtorre39's fork, beta branch at 10/29/18 at 1:04 PM and ending at 4:01 PM.
