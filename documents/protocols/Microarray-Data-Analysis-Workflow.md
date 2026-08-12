## Microarray Data Analysis Workflow

This page shows the Microarray Data Analysis Workflow used in the Dahlquist Lab at Loyola Marymount University to analyze the data from for the DNA microarray hybridizations reported in [GEO Series GSE83656](https://ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE83656).

### Summary of steps for microarray data analysis
1. Quantitate the fluorescence signal in each spot (GenePix Pro)
2. Calculate the ratio of red/green fluorescence (GenePix Pro)
3. Log transform the ratios (GenePix Pro)
4. Normalize the ratios on each microarray slide (within-chip normalization)
5. Normalize the ratios for a set of slides in an experiment (between-chip normalization)
6. Perform statistical analysis on the ratios:
  - Within-strain ANOVA
  - Modified t test for each timepoint
  - Between-strain ANOVA
  - Benjamini & Hochberg and Bonferroni p value corrections for the above three tests
  - "Sanity Check" on above three tests
7. Pattern finding algorithms (clustering with stem)
8. Gene Ontology term enrichment analysis (on clusters with stem)
9. Determining candidate transcription factors and gene regulatory network (YEASTRACT)
10. Dynamical modeling with [GRNmap](http://kdahlquist.github.io/GRNmap/); visualization with [GRNsight](http://dondi.github.io/GRNsight/)

### Steps 1-3: Generating Log<sub>2</sub> Ratios with GenePix Pro

- The protocol for gridding and generating the intensity (log<sub>2</sub> ratio) data with GenePix Pro 6.1 is found on [this page](https://github.com/kdahlquist/DahlquistLab/blob/master/documents/protocols/GenePix-Pro-Software-Protocol.md). 
- This protocol will generate a `*.gpr` file for each chip which is then fed into the normalization protocol below.
- To bypass this step, you can download the `*.gpr` files from the NCBI GEO repository  [series GSE83656](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE83656).  Click [this link](https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE83656&format=file) to begin the download of a 154.9 Mb compressed file called `GSE83656_RAW.tar`.

### Steps 4-5: Within- and Between-chip Normalization

The scripts and accessory files required to run the normalization are archived on the [Dahlquist Lab GitHub Repository normalization directory](https://github.com/kdahlquist/DahlquistLab/tree/master/normalization).

#### Installing R x64 v3.1.0 and the limma v3.20.1 package

The following protocol was developed to normalize GCAT and Ontario DNA microarray chip data from the Dahlquist Lab using the R Statistical Software and the limma package (part of the [Bioconductor Project](http://www.bioconductor.org)).  

_Note that if R x64 v3.1.0 and the limma v3.20.1 package are already installed on your computer, you can proceed to the next section._
- The normalization procedure has been verified to work with the 64-bit (x64) version 3.1.0 of R released in April 2014 ([link to download site](https://cran-archive.r-project.org/bin/windows/base/old/3.1.0/), [alternate direct link to download from Box](https://lmu.box.com/s/tiat8qfod4m4zlgu209hldj5d3n4urg5)) and and version 3.20.1 of the limma package [direct link to download zipped file](https://github.com/kdahlquist/DahlquistLab/blob/master/normalization/Limma_3.20.1.zip?raw=true) on the Windows 7 platform.
  - Note that using other versions of R or the limma package might give different results.
  - Note also that using the 32-bit versus the 64-bit versions of R 3.1.0 will give different results for the normalization out in the 10<sup>-13</sup> or 10<sup>-14</sup> decimal place.  The Dahlquist Lab has standardized on using the 64-bit version of R.
- To install R for the first time, download and run the installer from the link above, accepting the default installation.
- To use the limma package, unzip the file and place the contents into a folder called "limma" in the library directory of the R program.  If you accept the default location, that will be C:\Program Files\R\R-3.1.0\library.

#### Running the Normalization Script

This protocol describes the procedure for normalizing the microarray data for the wild type and transcription factor deletion strains _Δcin5_, _Δgln3_, _Δhap4_, _Δhmo1_, _Δswi4_, and _Δzap1_ which were hybridized on the GCAT and Ontario chip types.  It can also be used to normalize the Dahlquist Lab _Saccharomyces paradoxus_ data (unpublished), which was hybridized to the Ontario chips.

- Create a folder to store your files for the microarray analysis procedure.
- Download the zipped file that contains the `.gpr` files and save it to this folder (or move it if it saved in a different folder).
  - Unzip this file using [7-zip](http://www.7-zip.org/download.html).  Right-click on the file and select the menu item, "7-zip > Extract Here".
- Download the following files by right-clicking on the link and choosing the menu item "Save Link As..."
  - Download the [GCAT_Targets_20160616.csv](https://github.com/kdahlquist/DahlquistLab/raw/master/normalization/GCAT_Targets_20160616.csv) file and [Ontario_Targets_wt-dCIN5-dGLN3-dHAP4-dHMO1-dSWI4-dZAP1_20160616.csv](https://github.com/kdahlquist/DahlquistLab/raw/master/normalization/Ontario_Targets_wt-dCIN5-dGLN3-dHAP4-dHMO1-dSWI4-dZAP1_20160616.csv) file and save them to this folder (or move them if they saved to a different folder).
  - Download the [GCAT-and-Ontario_normalization_script.R](https://github.com/kdahlquist/DahlquistLab/raw/master/normalization/GCAT-and-Ontario_normalization_script.R) script and save (or move) it to this folder.
  - Download the [generate_MA_and_box_plots.R](https://github.com/kdahlquist/DahlquistLab/raw/master/normalization/generate_MA_and_box_plots.R) script and save (or move) it to this folder.
  - _Note that the filenames for the GCAT and Ontario Targets files and the strains are hardcoded into the normalization script.  They can be modified for use with other data by modifying the appropriate lines in the script._
- Launch R x64 3.1.0 (make sure you are using the 64-bit version). 
- Change the directory to the folder containing the targets file and the `*.gpr` files for the chips by selecting the menu item File > Change dir... and clicking on the appropriate directory.  You will need to click on the + sign to drill down to the right directory.  Once you have selected it, click OK.
- In R, select the menu item File > Source R code..., and select the `GCAT-and-Ontario_normalization_script.R` script.
  - Wait while R processes your files.
- When the processing has finished, you will find three files called `GCAT_and_Ontario_Unnormalized.csv`, `GCAT_and_Ontario_Within_Array_Normalization.csv`, and `GCAT_and_Ontario_Between_Array_Normalization.csv`.  The latter file is the one that you will need going forward.
  - Save back-ups of these files.
  - Note that the `GCAT_and_Ontario_Within_Array_Normalization.csv` file is the source of, and should be identical to the processed data submitted to NCBI GEO as [series GSE83656](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE83656).

#### Visualizing the Normalized Data

- Immediately after running the normalization script, select the menu item File > Source R code..., and select the `generate_MA_and_box_plots.R` script.
  - Wait while R processes your files.  You will see the individual plots being created in a new window.  R will save them automatically to the same folder that contains the data and scripts.
    - The box plots for each strain (comparison of the before, after within- and after between-chip normalization in the same file) are saved under the name of the strain, e.g., dCIN5.jpg.
    - The MA plots are saved under a name for the individual chip, e.g., dCIN5_LogFC_t15-1.jpg, and show the plots both before and after normalization.
- Zip the files of the plots together and save back-up copies of them.

### Step 6: Statistical Analysis

#### Preparing the Excel Workbook

* For the statistical analysis, we will begin with the file `GCAT_and_Ontario_Between_Array_Normalization.csv` that you generated in the previous step.
* Open this file in Excel and Save As an Excel Workbook `*.xlsx.  It is a good idea to add your initials and the date (yyyymmdd) to the filename as well.
* Rename the worksheet with the data "Master_Sheet".
** Type the header "ID" in cell A1.
** Insert a new column after column A and name it "Standard Name".  Column B will contain the common names for the genes on the microarray.
*** Copy the entire column of IDs from Column A.
*** Paste the names into the "Value" field of the [http://www.yeastract.com/formorftogene.php ORF List <-> Gene List] tool in [http://www.yeastract.com YEASTRACT]. Then, click on the "Transform" button.
*** Select all of the names in the "Gene Name" column of the resulting table.
*** Copy and paste these names into column B of the <code>*.xlsx</code> file. Save your work.
** Insert a new column on the very left and name it "MasterIndex".  We will create a numerical index of genes so that we can always sort them back into the same order.
*** Type a "1" in cell A2 and a "2" in cell A3.
*** Select both cells. Hover your mouse over the bottom-right corner of the selection until it makes a thin black + sign.  Double-click on the + sign to fill the entire column with a series of numbers from 1 to 6189 (the number of genes on the microarray).
** Some cells in the worksheet have "NA" either because there was missing data for genes that existed on the Ontario chips, but not the GCAT chips or because that spot was flagged as "Not Found" by the GenePix Pro software.
*** Select the menu item Find/Replace and Find all cells with "NA" and replace them with a single space character.  Record how many replacements were made to your electronic lab notebook.  Save your work.
* This will be the starting point for our statistical analysis below.

#### Within-strain ANOVA

The purpose of the witin-stain ANOVA test is to determine if any genes had a gene expression change that was significantly different than zero at _*any*_ timepoint.

# Create a new worksheet, naming it either "(STRAIN)_ANOVA" as appropriate.  For example, you might call yours "wt_ANOVA" or "dHAP4_ANOVA" 
# Copy the first three columns containing the "MasterIndex", "ID", and "Standard Name" from the "Master_Sheet" worksheet for your strain and paste it into your new worksheet.  Copy the columns containing the data for your strain and paste it into your new worksheet.
# At the top of the first column to the right of your data, create five column headers of the form (STRAIN)_AvgLogFC_(TIME) where (STRAIN) is your strain designation and (TIME) is 15, 30, etc.
# In the cell below the (STRAIN)_AvgLogFC_t15 header, type <code>=AVERAGE(</code> 
# Then highlight all the data in row 2 associated with (STRAIN) and t15, press the closing paren key (shift 0),and press the "enter" key.
# This cell now contains the average of the log fold change data from the first gene at t=15 minutes.
# Click on this cell and position your cursor at the bottom right corner. You should see your cursor change to a thin black plus sign (not a chubby white one). When it does, double click, and the formula will magically be copied to the entire column of 6188 other genes.
# Repeat steps (4) through (8) with the t30, t60, t90, and the t120 data.
# Now in the first empty column to the right of the (STRAIN)_AvgLogFC_t120 calculation, create the column header (STRAIN)_ss_HO.
# In the first cell below this header, type <code>=SUMSQ(</code>
# Highlight all the LogFC data in row 2 for your (STRAIN) (but not the AvgLogFC), press the closing paren key (shift 0),and press the "enter" key. 
# In the next empty column to the right of (STRAIN)_ss_HO, create the column headers (STRAIN)_ss_(TIME) as in (3).
# Make a note of how many data points you have at each time point for your strain.  For most of the strains, it will be 4, but for dHAP4 t90 or t120, it will be "3", and for the wild type it will be "4" or "5".  Count carefully. Also, make a note of the total number of data points. Again, for most strains, this will be 20, but for example, dHAP4, this number will be 18, and for wt it should be 23 (double-check).
# In the first cell below the header (STRAIN)_ss_t15, type <code>=SUMSQ(<range of cells for logFC_t15>)-COUNTA(<range of cells for logFC_t15>)*<AvgLogFC_t15>^2</code> and hit enter.
#* The phrase <range of cells for logFC_t15> should be replaced by the data range associated with t15. 
#* The <code>COUNTA</code> function counts the number of cells with data points in the range specified (i.e., it doesn't count cells with missing values). 
#* The phrase <AvgLogFC_t15> should be replaced by the cell number in which you computed the AvgLogFC for t15, and the "^2" squares that value. 
#* Upon completion of this single computation, use the Step (7) trick to copy the formula throughout the column.
# Repeat this computation for the t30 through t120 data points.  Again, be sure to get the data for each time point, type the right number of data points, and get the average from the appropriate cell for each time point, and copy the formula to the whole column for each computation.
# In the first column to the right of (STRAIN)_ss_t120, create the column header (STRAIN)_SS_full.
# In the first row below this header, type <code>=sum(<range of cells containing "ss" for each timepoint>)</code> and hit enter.
# In the next two columns to the right, create the headers (STRAIN)_Fstat and (STRAIN)_p-value.
# Recall the number of data points from (13): call that total n.
# In the first cell of the (STRAIN)_Fstat column, type <code>=((n-5)/5)*(<(STRAIN)_ss_HO>-<(STRAIN)_SS_full>)/<(STRAIN)_SS_full></code> and hit enter.  
#* Don't actually type the n but instead use the number from (13). Also note that "5" is the number of timepoints and the dSWI4 strain has 4 timepoints (it is missing t15).
#* Replace the phrase (STRAIN)_ss_HO with the cell designation.
#* Replace the phrase <(STRAIN)_SS_full> with the cell designation. 
#* Copy to the whole column.
# In the first cell below the (STRAIN)_p-value header, type <code>=FDIST(<(STRAIN)_Fstat>,5,n-5)</code> replacing the phrase <(STRAIN)_Fstat> with the cell designation and the "n" as in (13) with the number of data points total. (Again, note that the number of timepoints is actually "4" for the dSWI4 strain).  Copy to the whole column.
# Before we move on to the next step, we will perform a quick sanity check to see if we did all of these computations correctly.
#*  Click on cell A1 and click on the Data tab.  Select the Filter icon (looks like a funnel). Little drop-down arrows should appear at the top of each column. This will enable us to filter the data according to criteria we set.
#* Click on the drop-down arrow on your (STRAIN)_p-value column. Select "Number Filters". In the window that appears, set a criterion that will filter your data so that the p value has to be less than 0.05. 
#* Excel will now only display the rows that correspond to data meeting that filtering criterion.  A number will appear in the lower left hand corner of the window giving you the number of rows that meet that criterion.  We will check our results with each other to make sure that the computations were performed correctly.

==== Calculate the Bonferroni and p value Correction ====

# Now we will perform adjustments to the p value to correct for the [https://xkcd.com/882/ multiple testing problem].  Label the next two columns to the right with the same label, (STRAIN)_Bonferroni_p-value.
# Type the equation <code>=<(STRAIN)_p-value>*6189</code>, Upon completion of this single computation, use the Step (10) trick to copy the formula throughout the column.
# Replace any corrected p value that is greater than 1 by the number 1 by typing the following formula into the first cell below the second (STRAIN)_Bonferroni_p-value header: <code>=IF(<STRAIN_Bonferroni_p-value>1,1,<STRAIN_Bonferroni_p-value>)</code>.  Replace <STRAIN_Bonferroni_p-value> with the cell designation where that value was computed.  Use the Step (10) trick to copy the formula throughout the column.

==== Calculate the Benjamini & Hochberg p value Correction ====

# Insert a new worksheet named "(STRAIN)_ANOVA_B-H".
# Copy and paste the "MasterIndex", "ID", and "Standard Name" columns from your previous worksheet into the first two columns of the new worksheet. 
# For the following, use Paste special > Paste values.  Copy your unadjusted p values from your ANOVA worksheet and paste it into Column D.
# Select all of columns A, B, C, and D. Sort by ascending values on Column D. Click the sort button from A to Z on the toolbar, in the window that appears, sort by column D, smallest to largest.
# Type the header "Rank" in cell E1.  We will create a series of numbers in ascending order from 1 to 6189 in this column.  This is the p value rank, smallest to largest.  Type "1" into cell E2 and "2" into cell E3. Select both cells E2 and E3. Double-click on the plus sign on the lower right-hand corner of your selection to fill the column with a series of numbers from 1 to 6189.
# Now you can calculate the Benjamini and Hochberg p value correction. Type (STRAIN)_B-H_p-value in cell F1. Type the following formula in cell F2: <code>=(D2*6189)/E2</code> and press enter. Copy that equation to the entire column.
# Type "STRAIN_B-H_p-value" into cell G1. 
# Type the following formula into cell G2: <code>=IF(F2>1,1,F2)</code> and press enter. Copy that equation to the entire column. 
# Select columns A through G.  Now sort them by your MasterIndex in Column A in ascending order.
# Copy column G and use Paste special > Paste values to paste it into the next column on the right of your ANOVA sheet.

* '''''Upload the .xlsx file that you have just created to LionShare.'''''  Send Dr. Dahlquist an e-mail with the link to the file.

==== Sanity Check: Number of genes significantly changed ====

Before we move on to further analysis of the data, we want to perform a more extensive sanity check to make sure that we performed our data analysis correctly.  We are going to find out the number of genes that are significantly changed at various p value cut-offs.

* Go to your (STRAIN)_ANOVA worksheet.
* Select row 1 (the row with your column headers) and select the menu item Data > Filter > Autofilter (The funnel icon on the Data tab).  Little drop-down arrows should appear at the top of each column.  This will enable us to filter the data according to criteria we set.
* Click on the drop-down arrow for the unadjusted p value.  Set a criterion that will filter your data so that the p value has to be less than 0.05.
** '''''How many genes have p < 0.05?  and what is the percentage (out of 6189)?'''''
** '''''How many genes have p < 0.01? and what is the percentage (out of 6189)?'''''
** '''''How many genes have p < 0.001? and what is the percentage (out of 6189)?'''''
** '''''How many genes have p < 0.0001? and what is the percentage (out of 6189)?'''''
* When we use a p value cut-off of p < 0.05, what we are saying is that you would have seen a gene expression change that deviates this far from zero by chance less than 5% of the time.
* We have just performed 6189 hypothesis tests.  Another way to state what we are seeing with p < 0.05 is that we would expect to see this a gene expression change for at least one of the timepoints by chance in about 5% of our tests, or 309 times.  Since we have more than 309 genes that pass this cut off, we know that some genes are significantly changed.  However, we don't know ''which'' ones.  To apply a more stringent criterion to our p values, we performed the Bonferroni and Benjamini and Hochberg corrections to these unadjusted p values.  The Bonferroni correction is very stringent.  The Benjamini-Hochberg correction is less stringent.  To see this relationship, filter your data to determine the following:
** '''''How many genes are p < 0.05 for the Bonferroni-corrected p value? and what is the percentage (out of 6189)?'''''
** '''''How many genes are p < 0.05 for the Benjamini and Hochberg-corrected p value? and what is the percentage (out of 6189)?'''''
* In summary, the p value cut-off should not be thought of as some magical number at which data becomes "significant".  Instead, it is a moveable confidence level.  If we want to be very confident of our data, use a small p value cut-off.  If we are OK with being less confident about a gene expression change and want to include more genes in our analysis, we can use a larger p value cut-off.  
* Comparing results with known data:  the expression of the gene ''NSR1'' (ID: YGR159C)is known to be induced by cold shock. '''''Find ''NSR1'' in your dataset.  What is its unadjusted, Bonferroni-corrected, and B-H-corrected p values?  What is its average Log fold change at each of the timepoints in the experiment?'''''  Note that the average Log fold change is what we called "STRAIN)_AvgLogFC_(TIME)" in step 3 of the ANOVA analysis. 
* We will compare the numbers we get between the wild type strain and the other strains studied, organized as a table.  Use this [[Media: BIOL398-04_S15_sample_p-value_slide.pptx | sample PowerPoint slide]] to see how your table should be formatted.

=== Modified t test for each timepoint ===

In the analysis above we performed an ANOVA to determine if any genes had a gene expression change that was significantly different than zero at '''''any''''' timepoint.  Now we will perform a modified t test to determine if any genes had a gene expression change that was significantly different than zero at '''''each''''' timepoint.  You will perform your analysis on the same strain that you did above, adding these calculations to the same Excel workbook.

* Insert a new worksheet into your Excel workbook and name it "(STRAIN)_ttest", e.g., "wt_ttest" or "dHAP4_ttest".
* Go back to the "Master_Sheet" worksheet for your strain.  Copy the first three columns containing the "MasterIndex", "ID", and "Standard Name" from the "Master_Sheet" worksheet for your strain and paste it into your new worksheet.  Copy the columns containing the data for your strain and paste it into your new worksheet.
* Go to the empty columns to the right on your worksheet.  Create new column headings in the top cells to label the average log fold changes that you will compute.  Name them with the pattern <dHAP4>_<AvgLogFC>_<tx> where you use the appropriate text within the <> and where x is the time.  For example, "dHAP4_AvgLogFC_t15".
* Compute the average log fold change for the replicates for each timepoint by typing the equation:
 =AVERAGE(''range of cells in the row for that timepoint'')
into the second cell below the column heading.  For example, your equation might read 
 =AVERAGE(C2:F2)
Copy this equation and paste it into the rest of the column.  
* Create the equation for the rest of the timepoints and paste it into their respective columns.  ''Note that you can save yourself some time by completing the first equation for all of the averages and then copy and paste all the columns at once.''
* Go to the empty columns to the right on your worksheet.  Create new column headings in the top cells to label the T statistic that you will compute.  Name them with the pattern <dHAP4>_<Tstat>_<tx> where you use the appropriate text within the <> and where x is the time.  For example, "dHAP4_Tstat_t15".  You will now compute a T statistic that tells you whether the normalized average log fold change is significantly different than 0 (no change in expression).  Enter the equation into the second cell below the column heading:  
 =AVERAGE(''range of cells'')/(STDEV(''range of cells'')/SQRT(''number of replicates''))
For example, your equation might read:
 =AVERAGE(C2:F2)/(STDEV(C2:F2)/SQRT(4))
(NOTE: in this case the number of replicates is 4.  Be careful that you are using the correct number of parentheses.)  Copy the equation and paste it into all rows in that column. Create the equation for the rest of the timepoints and paste it into their respective columns.  ''Note that you can save yourself some time by completing the first equation for all of the T statistics and then copy and paste all the columns at once.''
* Go to the empty columns to the right on your worksheet.  Create new column headings in the top cells to label the P value that you will compute.  Name them with the pattern <dHAP4>_<Pval>_<tx> where you use the appropriate text within the <> and where x is the time.  For example, "dHAP4_Pval_t15".  In the cell below the label, enter the equation:  
 =TDIST(ABS(''cell containing T statistic''),''degrees of freedom'',2)
For example, your equation might read:
 =TDIST(ABS(AE2),3,2)
The number of degrees of freedom is the number of replicates minus one.  Copy the equation and paste it into all rows in that column.
* As with the ANOVA, we encounter the multiple testing problem here as well.

==== Bonferroni Correction ====

# Now we will perform adjustments to the p value to correct for the multiple testing problem.  Label the columns to the right with the label, (STRAIN)_Bonferroni-Pval_tx (do this twice in a row).
# Type the equation <code>=<(STRAIN)_Pval_tx>*6189</code>, Upon completion of this single computation, use the trick to copy the formula throughout the column.
# Replace any corrected p value that is greater than 1 by the number 1 by typing the following formula into the first cell below the second (STRAIN)_Bonferroni-Pval_tx header: <code>=IF(r2>1,1,r2)</code>.  Use the trick to copy the formula throughout the column.

==== Benjamini & Hochberg Correction ====

# Insert a new worksheet named "(STRAIN)_ttest_B-H".  You will need to perform the procedure below for the p values for each timepoint.  Do them individually one at a time to avoid confusion.
# Copy and paste the "MasterIndex", "ID", and "Standard Name" columns from your previous worksheet into the first two columns of the new worksheet. 
# For the following, use Paste special > Paste values.  Copy your unadjusted p values from the first timepoint from your ttest worksheet and paste it into Column D.
# Select all of columns A, B, C, and D. Sort by ascending values on Column D. Click the sort button from A to Z on the toolbar, in the window that appears, sort by column D, smallest to largest.
# Type the header "Rank" in cell E1.  We will create a series of numbers in ascending order from 1 to 6189 in this column.  This is the p value rank, smallest to largest.  Type "1" into cell E2 and "2" into cell E3. Select both cells E2 and E3. Double-click on the plus sign on the lower right-hand corner of your selection to fill the column with a series of numbers from 1 to 6189.
# Now you can calculate the Benjamini and Hochberg p value correction. Type (STRAIN)_B-H_Pval_tx in cell F1. Type the following formula in cell F2: <code>=(D2*6189)/E2</code> and press enter. Copy that equation to the entire column.
# Type "STRAIN_B-H_Pval_tx" into cell G1. 
# Type the following formula into cell G2: <code>=IF(F2>1,1,F2)</code> and press enter. Copy that equation to the entire column. 
# Select columns A through G.  Now sort them by your MasterIndex in Column A in ascending order.
# Copy column G and use Paste special > Paste values to paste it into the next column on the right of your ttest sheet.

* '''''Upload the .xlsx file that you have just created to LionShare.'''''  Note that when you upload your file, you should check the box to "Overwrite file if it already exists."  This will then replace your previous version of your file with the updated one containing today's calculations.  Send Dr. Dahlquist an e-mail with the link to the file (e-mail kdahlquist at lmu dot edu).

==== Sanity Check ====

* We will also perform the "sanity check" as follows:
** '''''Determine how many genes have a p value < 0.05 at each timepoint.'''''
**  '''''Keeping the "Pval" filter at p < 0.05, How many have an average log fold change of > 0.25 and p < 0.05 at each timepoint? How many have an average log fold change of < -0.25 and p < 0.05 at each timepoint? (These log fold change cut-offs represent about a 20% fold change in expression.)'''''
** How many genes have B&H corrected p < 0.05?
** How many genes have a Bonferroni corrected p < 0.05?
** Use this [[Media: BIOL398-04_S15_sample_p-value_slide.pptx | sample PowerPoint slide]] to see how your table should be formatted.

=== Between-strain ANOVA ===

The detailed description of how this is done can be found on [[Dahlquist:Modified_ANOVA_and_p_value_Corrections_for_Microarray_Data#Comparing_Significant_Changes_in_Expression_Between_Two_Strains | this page.]] A brief version of the protocol appears below.

* All two strain comparisons were performed in MATLAB using the script [[Media:Two_strain_compare_corrected_20140813_3pm.zip | Two_strain_compare_corrected_20140813_3pm.zip (within a zip file)]]:
** Download the zipped script file, extract it to the folder that contains your Excel file with the worksheet named "Master_Sheet".  (The script and Excel file must be in the same folder to work.)
** Launch MATLAB version 2014b.
** In MATLAB, you will need to navigate to the folder containing the script and the Excel file.
*** Near the top of the page, you will see a a field that contains the path to the working directory.  Just to the left of it, there is an icon that looks like a folder opening with a green down arrow.  Click on this icon to open a dialog box where you can choose your folder containing the script and Excel file.
*** Once you have selected your folder, the left-hand pane should display the contents of that folder.  To open the MATLAB script, you can double-click on it from that pane.  The code for the script will appear in the center pane.
* You will need to make a few edits to the code, depending on which strain comparison you want to make.
** For the first block of code, the user must input the name of the Excel file (<code>*.xls or .xlsx</code>) to be imported as the variable "filename", the sheet from which the data will be imported as the variable "sheetname", and the two strains that will be compared as the variables "strain1" and "strain2".
*** MATLAB will read either .xls or .xlsx
*** Also note that this script will not work for any comparison involving dSWI4 because it has been hard-coded to expect 5 timepoints instead of 4.

 %% User must input filename, sheetname, and strains for comparison
 filename = 'GCAT_and_Ontario_Final_Normalized_Data.xls'; % Name of input file
 sheetname  = 'Master_Sheet'; % Name of sheet in input file containing data to analyze
 % % If one of the two strains you are working on is the wildtype, keep that
 % % wildtype as strain 1.
 strain1    = 'wt'; %Here should be wt, dCIN5, dGLN3, dHAP4, dHMO1, dZAP1, or Spar
 % % Select strain 2 to be one of the other strains you would like to
 % % compare with the first strain.
 strain2    = 'dZAP1'; %Here should be wt, dCIN5, dGLN3, dHAP4, dHMO1, dZAP1, or Spar

* The user does not have to modify any of the code from here on.
* The next two lines of code ask the user whether or not they would like to see plots for each gene with an unadjusted p-value < 0.05. If the user does want to see these plots, they enter "1". If they would not like to see these plots, the user enters "0".  When prompted, enter a "1" to see the plots displayed.
 
 disp('Do you want to view plots for each gene with an unadjusted p-value < 0.05?')
 graph = input('If yes, enter "1". If no, enter "0". ');

* Plots will show for all genes with p < 0.05, which could be hundreds.  If you want, you can save individual plots from the graph window, they do not save automatically.  Press any key to display the next plot.  The script will not finish and output the results files until all of the plots have been viewed.
* Because MATLAB version 2014b has switched to the OpenGL graphics library, the plots look weird at this point.

== Step 7-8: Clustering and GO Term Enrichment with stem ==

# '''Prepare your microarray data file for loading into STEM.'''
#* Insert a new worksheet into your Excel workbook, and name it "(STRAIN)_stem".
#* Select all of the data from your "(STRAIN)_ANOVA" worksheet and Paste special > paste values into your "(STRAIN)_stem" worksheet.
#** Your leftmost column should have the column header "MasterIndex".  Rename this column to "SPOT".  Column B should be named "ID".  Rename this column to "Gene Symbol".  Delete the column named "StandardName".
#** Filter the data on the B-H corrected p value to be > 0.05 (that's '''greater than''' in this case).
#*** Once the data has been filtered, select all of the rows (except for your header row) and delete the rows by right-clicking and choosing "Delete Row" from the context menu.  Undo the filter.  This ensures that we will cluster only the genes with a "significant" change in expression and not the noise.
#** Delete all of the data columns '''''EXCEPT''''' for the Average Log Fold change columns for each timepoint (for example, wt_AvgLogFC_t15, etc.).
#** Rename the data columns with just the time and units (for example, 15m, 30m, etc.).
#** Save your work.  Then use ''Save As'' to save this spreadsheet as Text (Tab-delimited) (*.txt).  Click OK to the warnings and close your file.
#*** Note that you should turn on the file extensions if you have not already done so.
# '''Now download and extract the STEM software.'''  [http://www.cs.cmu.edu/~jernst/stem/ Click here to go to the STEM web site].
#* Click on the [http://www.andrew.cmu.edu/user/zivbj/stemreg.html download link], register, and download the <code>stem.zip</code> file to your Desktop.
#* Unzip the file.  In Seaver 120, you can right click on the file icon and select the menu item ''7-zip > Extract Here''.
#* This will create a folder called <code>stem</code>.  Inside the folder, double-click on the <code>stem.jar</code> to launch the STEM program.
<!--#** In Seaver 120, we encountered an issue where the program would not launch on the Windows XP machines due to a lack of memory. (Even though the computers have been upgraded to Windows 7, do this to launch the program.)  To get around this problem, launch STEM from the command line.
#*** Go to the start menu and click on ''Programs > Accessories > Command Prompt''.
#*** You will need to navigate to the directory (folder) in which the STEM program resides.  If you followed the instructions above and extracted the stem folder to the Desktop, type the following:  <code>cd Desktop\stem</code>  and press "Enter".
#*** To launch the program then type:  <code>java -mx512M -jar stem.jar -d defaults.txt</code>  and press "Enter".  This will launch the program with less memory allocated to it.-->
# '''Running STEM'''
## In section 1 (Expression Data Info) of the the main STEM interface window, click on the ''Browse...'' button to navigate to and select your file.
##* Click on the radio button ''No normalization/add 0''.
##* Check the box next to ''Spot IDs included in the data file''.
## In section 2 (Gene Info) of the main STEM interface window, select ''Saccharomyces cerevisiae (SGD)'', from the drop-down menu for Gene Annotation Source.  Select ''No cross references'', from the Cross Reference Source drop-down menu.  Select ''No Gene Locations'' from the Gene Location Source drop-down menu.
## In section 3 (Options) of the main STEM interface window, make sure that the Clustering Method says "STEM Clustering Method" and do not change the defaults for Maximum Number of Model Profiles or Maximum Unit Change in Model Profiles between Time Points.
## In section 4 (Execute) click on the yellow Execute button to run STEM.
# '''Viewing and Saving STEM Results'''
## A new window will open called "All STEM Profiles (1)".  Each box corresponds to a model expression profile.  Colored profiles have a statistically significant number of genes assigned; they are arranged in order from most to least significant p value.  Profiles with the same color belong to the same cluster of profiles.  The number in each box is simply an ID number for the profile.
##* Click on the button that says "Interface Options...".  At the bottom of the Interface Options window that appears below where it says "X-axis scale should be:", click on the radio button that says "Based on real time".  Then close the Interface Options window.
##*Take a screenshot of this window (on a PC, simultaneously press the <code>Alt</code> and <code>PrintScreen</code> buttons to save the view in the active window to the clipboard) and paste it into a PowerPoint presentation to save your figures.
## Click on each of the SIGNIFICANT profiles (the colored ones) to open a window showing a more detailed plot containing all of the genes in that profile.
##* Take a screenshot of each of the individual profile windows and save the images in your PowerPoint presentation.
##* At the bottom of each profile window, there are two yellow buttons "Profile Gene Table" and "Profile GO Table".  For each of the profiles, click on the "Profile Gene Table" button to see the list of genes belonging to the profile.  In the window that appears, click on the "Save Table" button and save the file to your desktop.  Make your filename descriptive of the contents, e.g. "wt_profile#_genelist.txt", where you replace the number symbol with the actual profile number.
##** Upload these files to [http://lionshare.lmu.edu LionShare] and e-mail a link to Dr. Dahlquist.  (It will be easier to [[BIOL398-04/S15:Help#Compressing_Files_with_7-Zip | zip all the files together]] and upload them as one file).
##* For each of the significant profiles, click on the "Profile GO Table" to see the list of Gene Ontology terms belonging to the profile.  In the window that appears, click on the "Save Table" button and save the file to your desktop.  Make your filename descriptive of the contents, e.g. "wt_profile#_GOlist.txt", where you use "wt", "dGLN3", etc. to indicate the dataset and where you replace the number symbol with the actual profile number.  At this point you have saved all of the primary data from the STEM software and it's time to interpret the results!
##** Upload these files to [http://lionshare.lmu.edu LionShare] and e-mail a link to Dr. Dahlquist. (It will be easier to [[BIOL398-04/S15:Help#Compressing_Files_with_7-Zip | zip all the files together]] and upload them as one file).
# '''Analyzing and Interpreting STEM Results'''
## Select '''''one''''' of the profiles you saved in the previous step for further intepretation of the data.  I suggest that you choose one that has a pattern of up- or down-regulated genes at the early (first three) timepoints.  You and your partner will choose the '''''same''''' profile so that you can compare your results between the two strains.  Answer the following:
##* '''''Why did you select this profile?  In other words, why was it interesting to you?'''''
##* '''''How many genes belong to this profile?'''''
##* '''''How many genes were expected to belong to this profile?'''''
##* '''''What is the p value for the enrichment of genes in this profile?'''''  Bear in mind that we just finished computing p values to determine whether each individual gene had a significant change in gene expression at each time point.  This p value determines whether the number of genes that show this particular expression profile across the time points is significantly more than expected.
##* Open the GO list file you saved for this profile in Excel.  This list shows all of the Gene Ontology terms that are associated with genes that fit this profile.  Select the third row and then choose from the menu Data > Filter > Autofilter.  Filter on the "p-value" column to show only GO terms that have a p value of < 0.05.  '''''How many GO terms are associated with this profile at p < 0.05?'''''  The GO list also has a column called "Corrected p-value".  This correction is needed because the software has performed thousands of significance tests.  Filter on the "Corrected p-value" column to show only GO terms that have a corrected p value of < 0.05.  '''''How many GO terms are associated with this profile with a corrected p value < 0.05?'''''
##* Select 10 Gene Ontology terms from your filtered list (either p < 0.05 or corrected p < 0.05).  
##** Since you and your partner are going to compare the results from each strain for the same cluster, you can either:
##*** Choose the same 10 terms that are in common between strains.
##*** Choose 10 terms that are different between the strains (5 or so from each).
##*** Choose some that are the same and some that are different.
##**'''''Look up the definitions for each of the terms at [http://geneontology.org http://geneontology.org].  For your final lab report, you will discuss the biological interpretation of these GO terms.  In other words, why does the cell react to cold shock by changing the expression of genes associated with these GO terms?  Also, what does this have to do with HAP4 being deleted?'''''
##** To easily look up the definitions, go to [http://geneontology.org http://geneontology.org].
##** Copy and paste the GO ID (e.g. GO:0044848) into the search field at the upper left of the page called "Search GO Data".
##** In the [http://amigo.geneontology.org/amigo/medial_search?q=GO%3A0044848 results] page, click on the button that says "Link to detailed information about <term>, in this case "biological phase"". 
##** The definition will be on the next results page, e.g. [http://amigo.geneontology.org/amigo/term/GO:0044848 here].

### Provenance

https://openwetware.org/wiki/Dahlquist:Microarray_Data_Analysis_Workflow
