# Script written by Brandon J. Klein
# Degree-Distribution-Generator
# Last Updated: 2016-09-20

# For next week (9/28): Add introduction to function. Consider stringing together w/ random network generator.
# Explore further edits to the aesthetic of the bar graph (e.g. add lines & x-axis).
# Output bar graph to working directory. Specify file name and type.
# Add more extensive comments. See if the code can be easily broken.

# Set working directory to Desktop (uncomment to use)
# setwd("~/Desktop")

degree.distribution = function(random.network) {
	
	# Save column sums.
	cSums=colSums(random.network)
	
	# Save row sums.
	rSums=rowSums(random.network)

	# Save frequency table of column sums.
	cFrequency.Table=as.data.frame(table(cSums))

	# Set row names of column sums frequency table.
	names(cFrequency.Table)[1]='Frequency'; names(cFrequency.Table)[2]='Out-Degree'

	# Save frequency table of row sums.
	rFrequency.Table=as.data.frame(table(rSums))

	# Set row names of row sums frequency table.
	names(rFrequency.Table)[1]='Frequency'; names(rFrequency.Table)[2]='In-Degree'

	# Save merged frequency tables, substituting missing values with NA.
	Degree.Distribution.Table=merge(rFrequency.Table,cFrequency.Table,all=TRUE)

	# Replace NA values in degree distribution table with "0".
	Degree.Distribution.Table[is.na(Degree.Distribution.Table)]=0

	# Convert "Frequency" values to row labels.
	Labeled.Degree.Distribution.Table=Degree.Distribution.Table[,-1]

	# Delete the "Frequency" column from the degree distribution table.
	rownames(Labeled.Degree.Distribution.Table)=Degree.Distribution.Table[,1]

	# Save the transpose of the degree distribution table.
	Degree.Distribution.Transpose=t(Labeled.Degree.Distribution.Table)

	# Plot the degree distribution table.
	barplot(Degree.Distribution.Transpose,
			beside=TRUE,
			legend=TRUE,
			xlab="Degree of Gene", font.lab=2,
			ylab="Number of Genes with Given Degree")
}
