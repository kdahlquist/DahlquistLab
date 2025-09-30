noc <- log10(data$'No Constant')
P <- log10(data$`P Constant`)
B <- log10(data$`b Constant`)
PB <- log10(data$`Pb Constant`)

boxplot(PB, P, B, noc, 
        main = "Log10 distribution of LSE when holding different parameters constant",
        names = c("P and B", "P", "B", "No"),
        las = 2,
        horizontal = TRUE)
