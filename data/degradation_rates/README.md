From @Nwilli31's [notebook](http://www.openwetware.org/wiki/Natalie_Williams:_Electronic_Notebook#September_21.2C_2016) on OpenWetWare.
For the completion of my task with the degradation rates, the following was done:

1. I downloaded the supplemental data (Table S5) from Neymotin et al
2. From Neymotin's data, I edited the following
    * Alphabetized: Gene names were used for the alphabetization
    * Isolated Half Lives: Created a separate sheet with only Systematic & Gene Names and the thalf life
        *I calculated the median half life, which will used to calculate the degradation rate of any gene with missing data
    * Degradation Rates: Created an additional sheet for calcuating the degradation rate from the half lives
        *degradation rate = (ln (0.5)/ half life of specific gene)
        *For genes with missing data, the equation would be the following : (ln (0.5)/ median half life)
    * I used the previous file shared with me from Dr. Dahlquist to make the comparison between this work and Harbison's list of TFs
3. I used Microsoft Access to pair the two data sets together using the systematic names in order to identify if there was missing data for the genes
    * I created a query and chose the option to include all of Harbison's TFs but only those that matched from Neymotin's
    * I also chose to include the calculated degradation rates from Neymotin's data in that query as well
