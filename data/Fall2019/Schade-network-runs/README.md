This directory will contain input/output files for re-running the Schade input file from the _Bulletin of Mathematical Biology_ paper with GRNmap v1.10.
* 21-genes_31-edges_Schade-data_input.xlsx: starting file from supplemental data from the paper.
* 21-genes_31-edges_Schade-data_change-format-only_input.xlsx: input file re-formatted to be compatible with GRNmap v1.10, but no other changes made.

Note that there are some ways we can update this model beyond the format:
* Change the alpha to 0.02
* Include replicate data
* Change the Belle et al. (2006) degradation rates (and initial guesses for production rates) to Neymotin et al. (2014)
* Run the Schade _network_ with the Dahlquist Lab data

@alicekfinton should run the 21-genes_31-edges_Schade-data_change-format-only_input.xlsx file and create the other input files and run them.
