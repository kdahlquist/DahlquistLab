##The following readme document explains the columns of each of the supplemental tables in "Determination of in vivo RNA kinetics using RATE-seq".


TableS2: 
Syst: Systematic name
counts3: RNA-seq counts at 3 minutes after labeling
counts5: RNA-seq counts at 5 minutes after labeling
counts7: RNA-seq counts at 7 minutes after labeling
counts11: RNA-seq counts at 11 minutes after labeling
counts13: RNA-seq counts at 13 minutes after labeling
counts25: RNA-seq counts at 25 minutes after labeling


TableS3: 
Syst: Systematic name
counts5: RNA-seq counts at 5 minutes after labeling
counts7: RNA-seq counts at 7 minutes after labeling
counts9: RNA-seq counts at 9 minutes after labeling
counts13: RNA-seq counts at 13 minutes after labeling
counts20: RNA-seq counts at 20 minutes after labeling
counts25: RNA-seq counts at 25 minutes after labeling
counts30: RNA-seq counts at 30 minutes after labeling
counts100: RNA-seq counts at 100 minutes after labeling


TableS4: Each column is the normalized read count for a transcript based on timepoint (t), biological replicate (rep), and spike-in (indicated by 700, 900, or 1200).
t3.rep1.1200: The RNA-seq read counts at t=3 min of labeling for biological replicate 1 normalized to the 1200 spike-in
t3.rep1.700:  The RNA-seq read counts at t=3 min of labeling for biological replicate 1 normalized to the 700 spike-in
t3.rep1.900:   The RNA-seq read counts at t=3 min of labeling for biological replicate 1 normalized to the 900 spike-in
t5.rep2.1200:   The RNA-seq read counts at t=5 min of labeling for biological replicate 2 normalized to the 1200 spike-in
t5.rep2.700:   The RNA-seq read counts at t=5 min of labeling for biological replicate 2 normalized to the 700 spike-in
t5.rep2.900:   The RNA-seq read counts at t=5 min of labeling for biological replicate 2 normalized to the 900 spike-in
All other columns follow this same notation of t=timepoint, rep=biological replicate, spike-in


TableS5: 
Syst: Systematic Name
Gene: Gene name
alphaLow: The lower 2.5% estimate for the degradation rate constant alpha
alpha: The estimate for the degradation rate constant alpha
alphaHigh: The higher 97.5% estimate for the degradation rate constant alpha
thalfLowRaw: The lower 2.5% estimate for the half-life without correcting for dilution by cell division
thalfRaw: The estimated half-life without correcting for dilution by cell division
thalfHighRaw: The higher 97.5% estimate for the half-life without correcting for dilution by cell division
thalfLow: The lower 2.5% estimate for the half-life After correcting for dilution by cell division
thalf: The estimated half-life After correcting for dilution by cell division
thalfHigh: The higher 97.5% estimate for the half-life After correcting for dilution by cell division
Yeq: The calculated equilibrium level of labeling in normalized counts 
Iterations: The number of times that Bootstrapping converged successfully in estimating the degradation rate constant
GoodMeanCount: A 1 or 0 indicating whether or not the mean RNA-seq read count across time points for a gene was greater than an arbitrary cutoff of 100.  (The median read count is ~530).
ss.abundance: The estimated abundance of transcripts/cell
syn.low: The lower 2.5% estimate of the estimated synthesis rate
syn: The estimated synthesis rate
syn.high: The higher 2.5% estimate of the estimated synthesis rate


TableS6: 
GOterm:  GO term name 
pval: The calculated p-value
number.total.set: The number of genes NOT in that particular GO term 
number.GOterm: The number of genes in that particular GO term 
set.median: The median decay rate for the genes NOT in that particular GO term 
category.median: The median decay rate for the genes in that particular GO term 


TableS7: 
Syst: 		Systematic name 
log2_PD_total: 	log2 ratio of 4tU fractionated (pulled down) RNA to total RNA 
UraNumber: 	Number of Uracil in the transcript
TotalLength: 	The length of the gene 
Log2RatioAux:	The log2 ratio of RNA from cells treated with 4tU compared to cells NOT treated with 4tU for a URA3 auxotroph
Log2RatioProt:	The log2 ratio of RNA from cells treated with 4tU compared to cells NOT treated with 4tU for a prototroph
