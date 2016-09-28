# Script written by Brandon J. Klein
# Degree-Distribution-Generator
# Last Updated: 2016-09-27

# For next week (9/28): Add introduction to function and more extensive comments
# See if the code can be easily broken.
# Address nomenclature issues (e.g. genes.controlling).
# Address setting wd.

degree.distribution = function(random.network,chart.title) {
	
	# Set working directory (change as desired)
	setwd("~/Desktop")
	
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
	
	# Calculate maximum value to be displayed on y-axis
	all.y=c(Degree.Distribution.Table$"In-Degree",Degree.Distribution.Table$"Out-Degree")
	max.y=max(all.y)
	
	# Find out maximum number of genes in network
	genes.affected=length(rowSums(random.network))
	genes.controlling=length(colSums(random.network))	
	max.genes=ifelse(genes.affected>genes.controlling,genes.affected,genes.controlling)
	
	# Calculate number of edges in input network
	edges=sum(rowSums(random.network))
	
	# Create a name for the .jpeg file
	filename=paste(max.genes,"-genes_",edges,"-edges_","degree-distribution",format(Sys.time(),"_%Y%m%d_%H.%M.%S"),".jpg",sep="")

	# Save subsequent plotting to a .jpeg file
	jpeg(filename)
	
	# Plot the degree distribution table.
	barplot=barplot(Degree.Distribution.Transpose,
			beside=TRUE,
			col=c("black","gray"),
			axes=FALSE,
			xlab="Degree of Gene", font.lab=2,
			ylab="Number of Genes with Given Degree",
			yaxt="n",
			main=chart.title)
	
	# Draw y-axis
	axis(2,at=c(0:max.y),las=1,pos=0.3)
	
	# Draw grid lines, scaled to y-axis
	abline(h=c(0:max.y-1),lty="solid",col="lightgray")
	
	# Redraw bars on top of grid lines
	barplot(Degree.Distribution.Transpose,
		beside=TRUE,
		col=c("black","gray"),
		yaxt="n",
		add=T)
	
	# Add legend on top of grid lines
	legend("topright",
		legend=c("In-Degree","Out-Degree"),
		fill=c("black","gray"),
		border="black",
		bg="white")
	
	# Saves plotted chart as .jpeg file
	dev.off()
}
