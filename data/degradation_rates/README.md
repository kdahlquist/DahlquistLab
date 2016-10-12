From @Nwilli31's [notebook](http://www.openwetware.org/wiki/Natalie_Williams:_Electronic_Notebook#September_21.2C_2016) on OpenWetWare.

This procedure is for deriving degradation rates from the RNA half-life data from:

[Neymotin, B., Athanasiadou, R., & Gresham, D. (2014). Determination of in vivo RNA kinetics using RATE-seq. Rna, 20(10), 1645-1652. DOI: 10.1261/rna.045104.114](http://rnajournal.cshlp.org/content/20/10/1645.full)

1. I downloaded the [supplemental data (Table S5)](http://rnajournal.cshlp.org/content/suppl/2014/08/08/rna.045104.114.DC1/TableS5.xls) from Neymotin et al. (2014).  Note that the key to the data can be found in the [ReadMe](http://rnajournal.cshlp.org/content/suppl/2014/08/08/rna.045104.114.DC1/REVreadme_Table.txt).
2. From Neymotin's data, I edited the following
   * Alphabetized: Gene names were used for the alphabetization
      1. For alphabetization, I selected the entire sheet
      2. Next, I clicked the Sort button that looks like a funnel, and selected "Custom sort"
      3. For custom sort, I selected the column with the gene names, for me, Column 1
      4. I, then, sorted from descending order from A -> to Z
   * Isolated Half Lives: Created a separate sheet with only Systematic & Gene Names and the thalf life
      1. On this new sheet, I copied the Gene names and the thalf lifes corresponding to those genes
      2. I calculated the median half life, which will used to calculate the degradation rate of any gene with missing data
      3. The following Excel equation was used           
            =MEDIAN("Column Containing thalf lives")            
   * Degradation Rates: Created an additional sheet for calculating the degradation rate from the half lives
      1. Again, the Gene names and the thalf lives were pasted into this new sheet so that the calculations could be carried out on a single page without interfering with other information or formats
      2. The following equation was used to calculate the degradation rate      
            = (ln (0.5)/ half life of specific gene)
      3. For genes with missing data, the equation would be the following
            = (ln (0.5)/ median half life)
3. I used a previous file shared with me from Dr. Dahlquist to make the comparison between this work (Neymotin) and Harbison's list of 203 TFs
4. I used Microsoft Access to pair the two data sets together using the systematic names in order to identify if there was missing data for the genes
   1. First open a new blank database.
   2. I imported my two excel files that contained my data
      * This act can be achieved by selecting the External Data tab and clicking the Excel icon
           + I then went through a series of instructions
           + I browsed my computer for the file that I needed and selected it
           + I chose the sheet that I would import, for me, this was Harbison's list of 203 TFs and the sheet with Neymotin's calculated degradation rates
           + Depending on your sheet's format, the first row may either include headings or go directly into your data; select the box if your first row contains column headings
            + I skipped the next question, asking about field names and the index, clicking next
            + I then chose my own primary key - setting it to the first column with Systematic Names (not all genes have universal Gene names)
            + I then clicked finish and import.
      Now your data should be seen as a table in Access
   3. To pair the data sets together, I selected the Create tab and hit Query Design.
      * When you selected Query Design, a pop-up window appears and shows all the tables within your current database. Choose the tables that you wish to pair the data for. Exit out of that pop-up window and now you should see your tables with their heading under them.
      * Select the heading that has the information you want to pair with the other file. For me it was the Systematic Names from Neymotin's data with the Systematic Names from Harbison's data
      * Drag the heading and match it to the heading for the other data. Right click on the link that forms between the two headings
      * Because I only want the data from Neymotin's that matches with Harbison's data, I would select the option that states: "Include ALL records from 'Harbison 203' and only those records from 'Neymotin degradation rates' where the joined fields are equal."
      * Press ok and you should now see a pointed arrow head towards Neymotin deg rate heading
      * Now you can drag and drop the headings with the data that you want into the field below. For my query, I selected the names of Harbison's 203 TFs and then dragged down Neymotin's Systematic names as well as the calculated degradation rate to see if any genes were missing.
      * Now that the field is full, click Run to run your query.
    4. A table should appear now with the data you wanted beside the heading - for me, I have the Systematic names paired together and their corresponding degradation rates in the column beside them.