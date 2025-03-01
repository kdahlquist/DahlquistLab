This directory will contain input/output files for re-running the Schade input file from the _Bulletin of Mathematical Biology_ paper with GRNmap v1.10.
* 21-genes_31-edges_Schade-data_input.xlsx: starting file from supplemental data from the paper.
* 21-genes_31-edges_Schade-data_estimation_output.xlsx: output file from supplemental data from the paper for comparison.
* 21-genes_31-edges_Schade-data_change-format-only_input.xlsx: input file re-formatted to be compatible with GRNmap v1.10, but no other changes made.

Note that there are some ways we can update this model beyond the format:
* Change the alpha to 0.02, MaxIter	to 1.00E+08, TolFun	to 1.00E-06, MaxFunEval to 1.00E+08, and TolX	1.00E-06, consistent with the runs we are now doing.
* Include replicate data.
* Change the Belle et al. (2006) degradation rates (and initial guesses for production rates) to Neymotin et al. (2014).
* Run the Schade _network_ with the Dahlquist Lab data (and Neymotin et al. degradation rates and initial guesses)

@alicekfinton should run the 21-genes_31-edges_Schade-data_change-format-only_input.xlsx file and create the other input files and run them.  
* Finding the new degradation and production rates for this network and the Dahlquist Lab expression data can be done with this [MS Access Database](https://github.com/kdahlquist/DahlquistLab/blob/master/data/Spring2019/Expression-and-Degradation-rate-database_2019.accdb).
    * [Here is a link to instructions for how to run the query to make the input workbook](https://xmlpipedb.cs.lmu.edu/biodb/fall2019/index.php/Week_10#Creating_the_GRNmap_Input_Workbook)
* The Schade data spreadsheet with the replicate data, called wild type cold time curve_edited_20110113_KD.xls, can be found on [Box](https://lmu.box.com/s/au1u4qo3e6yu656ks8x0738w0xm4oxoq).
    * Note that you should round the expression data to four digits past the decimal as is the custom with the Dahlquist lab data.
