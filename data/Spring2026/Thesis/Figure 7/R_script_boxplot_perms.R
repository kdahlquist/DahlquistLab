#Import summary file and replace 'R_script-summary-sheet' with file name

noc <- log10(R_script-summary-sheet$'No Constant')
P <- log10(R_script-summary-sheet$'P Constant')
B <- log10(R_script-summary-sheet$'b Constant')
PB <- log10(R_script-summary-sheet$'Pb Constant')

par(mar = c(6, 8, 6, 2))
boxplot(PB, P, B, noc, 
        main = "Distribution of LSE of 21 Networks when holding different parameters constant",
        names = c("P and B constant", "P constant", "B constant", "No constant"),
        las = 2,
        horizontal = TRUE,
        cex.names = 0.9,
        ylim = c(-12, 2)) # Set x-axis range from -12 to 2
