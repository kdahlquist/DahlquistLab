noc <- log10(R_script_input_trial_10_perm_overall_summary_sheet$'No Constant')
P <- log10(R_script_input_trial_10_perm_overall_summary_sheet$'P Constant')
B <- log10(R_script_input_trial_10_perm_overall_summary_sheet$'b Constant')
PB <- log10(R_script_input_trial_10_perm_overall_summary_sheet$'Pb Constant')

par(mar = c(6, 8, 6, 2))
boxplot(PB, P, B, noc, 
        main = "Distribution of LSE of Trial 10 Permutations when holding different parameters constant",
        names = c("P and B constant", "P constant", "B constant", "No constant"),
        las = 2,
        horizontal = TRUE,
        cex.names = 0.9,
        ylim = c(-12, 2)) # Set x-axis range from -12 to 2
