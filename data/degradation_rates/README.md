## mRNA degradation rates for use with GRNmap input workbooks

From: [Neymotin, B., Athanasiadou, R., & Gresham, D. (2014). Determination of in vivo RNA kinetics using RATE-seq. Rna, 20(10), 1645-1652. DOI: 10.1261/rna.045104.114](http://rnajournal.cshlp.org/content/20/10/1645.full)

### List of Files

1. Neymotin_2014_REVreadme_Table.txt (Copy of [REVreadme_Table.txt](http://rnajournal.cshlp.org/content/suppl/2014/08/08/rna.045104.114.DC1/REVreadme_Table.txt))
2. Neymotin_2014_RNA_degradation_rates_processed.xlsx (contains processed data)
3. Neymotin_2014_TableS5.xls (Copy of [TableS5.xls](http://rnajournal.cshlp.org/content/suppl/2014/08/08/rna.045104.114.DC1/TableS5.xls))
4. Neymotin_Harbison_linking_database.accdb (Microsoft Access database used to extract the list of transcription factors from [Harbison, C. T., Gordon, D. B., Lee, T. I., Rinaldi, N. J., Macisaac, K. D., Danford, T. W., ... & Jennings, E. G. (2004). Transcriptional regulatory code of a eukaryotic genome. Nature, 431(7004), 99-104](http://www.nature.com/nature/journal/v431/n7004/abs/nature02800.html) from the Neymotin et al. (2014) data)

### Processing Steps

@Nwilli31's documented her preliminary work on her [notebook](http://www.openwetware.org/wiki/Natalie_Williams:_Electronic_Notebook#September_21.2C_2016) on OpenWetWare.  The description below corresponds to the final version of the file on this repository: `Neymotin_2014_RNA_degradation_rates_processed.xlsx`.

1. The first worksheet in the workbook, `Neymotin_2014_supp_TableS5_raw`, corresponds to a copy of the [supplemental data Table S5](http://rnajournal.cshlp.org/content/suppl/2014/08/08/rna.045104.114.DC1/TableS5.xls) from Neymotin et al. (2014).  Note that the key to the data can be found in the [ReadMe](http://rnajournal.cshlp.org/content/suppl/2014/08/08/rna.045104.114.DC1/REVreadme_Table.txt).
2. All the data were copied over to the next worksheet, entitled `names-corrected_sorted-by-gene`.
    * The data were sorted A-->Z by column B, "Gene", which is the Standard Name for the gene in the Saccharomyces Genome Database.
    * There were problems with 4 gene names, that were corrected.
        * Excel converted YKL134C/OCT1 to 1-Oct.
        * ADE5,7; ARG5,6; and DUR1,2 had the commas in their names converted to "%2C".
        * IMP2' did not have an issue with the apostrophe in its name.
        * See [Zeeberg, B. R., Riss, J., Kane, D. W., Bussey, K. J., Uchio, E., Linehan, W. M., ... & Weinstein, J. N. (2004). Mistaken identifiers: gene name errors can be introduced inadvertently when using Excel in bioinformatics. BMC bioinformatics, 5(1), 80.](http://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-5-80) and [Ziemann, M., Eren, Y., & El-Osta, A. (2016). Gene name errors are widespread in the scientific literature. Genome Biology, 17(1), 177.](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-1044-7) for discussion of this phenomenon.
    * 72 gene names were listed as "NA".  These were replaced with what was in the "Syst" column. 
3. Columns A (Syst), B (Gene), and J (thalf) were copied over to a new worksheet entitled `degradation_rate_all`.
    * These columns were renamed "systematic_name", "standard_name", and "t_half", respectively.
    * Column D was entitled "degradation_rate".
    * Degradation rates for all genes were computed using the equation `=(LN(0.5))/<t_half>`
    * Column E was entitled "degradation_rate_rounded".
    * The degradation rates from column D were rounded to four digits past the decimal using the equation `=ROUND(<degradation_rate>,4)`
        * The values in this column were copied and Paste special > Paste values to get rid of the formula underneath.
    * The median t_half and degradation_rate were computed for all 5380 genes; note that this value should **not** be used for degradation rate values missing for transcription factors, see the next section.
4. The `degradation_rate_all` worksheet was imported into a Microsoft Access database entitled `Neymotin_Harbison_linking_database.accdb`.
    * A query was run to pull out the data corresponding to the 202 regulatory transcription factors from [Harbison et al. (2004)](http://www.nature.com/nature/journal/v431/n7004/abs/nature02800.html).  Note that Harbison describes 203, but we left out MATA1 which is not in the systematic sequence of *Saccharomyces cerevisiae* S288C and does not appear in the Neymotin (2014) data either.
    * The results of the query were pasted into a new worksheet entitled `degradation_rate_Harbison202`.
    * The median t_half and degradation_rate were computed for the 202 transcription factors; note that this value **should** be used for degradation rate values missing for transcription factors.
    * Rows with missing degradation rate values are highlighed in yellow.
    * The values in the degradation_rate and degradation_rate_rounded were copied and Paste special > Paste values to get rid of the formulas underneath.
    * A new column called degradation_rate_rounded_forGRNmap takes the absolute value of the degradation_rate_rounded because the GRNmap input workbook expects a postitive number for the degradation rate.
5. A new sheet was added called "deg_rate_Harb202_replacemissing" that has three columns, systematic_name, standard_name, and	degradation_rate copied and "paste values" from the previous sheet.  The degradation_rate column was the previous degradation_rate_forGRNmap column.  The missing values were filled in by the median value of 0.099 for DAL80, GAT3, HAC1, IME4, and WTM1.
6. A new sheet was added called "prod_rate_initial_guesses" with three columns, systematic_name, standard_name, and	production_rate.  The production_rate value is 2* the degradation rate from the previous worksheet.

### Contributors

@Nwilli31, @kdahlquist, and @bklein7 contributed to these files.
