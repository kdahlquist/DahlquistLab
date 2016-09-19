# Script written by Brandon J. Klein
# Random-Network
# 2016-09-14

# INTRODUCTION:
# This script encodes the function "random.network", which will generate a random gene regulatory network with the number of 
# regulators (genes controlling), targets (genes affected), and edges (regulatory relationships) specified by the user. This 
# function is written to only output networks in which all genes are connected to the network by at least one edge. The random network
# will be displayed in R and output as a CSV file. To specify where you would like the file to be output: go to line 21, replace
# DIRECTORY NAME with your desired output directory, and uncomment it.

# USING THIS FUNCTION FOR GRNmap:
# To generate a random network in R, do the following
# Launch RGui (Windows)
# Select the "Change dir..." menu item to navigate to the directory where the "Random-Matrix.R" function is saved
# Select the "Source R code..." menu item and select the file "Random-Matrix.R" to load it in the current session
# Then at the command prompt, type the following:	random.network(genes.affected,genes.controlling,EDGES)
# where you substitute an integer for "genes.affected", i.e., the number of target genes in the network,
# "genes.controlling", i.e., the number of regulators in the network, and
# "EDGES" the number of edges or regulatory relationships.
# For example, the command: random.network(21,21,31)
# specifies a symmetric network with 21 genes and 31 edges.
# Note: Only symmetric networks (where regulators = targets) will be accepted as input by GRNmap.
# GRNsight can accept assymetric networks.


random.network = function(genes.affected, genes.controlling, edges) {
	
	# Uncomment the line below and insert a directory name to specify where the random network CSV file will be output.
	# setwd("DIRECTORY NAME")

# Do not edit anything below this line-----------------------------------------------------------------------------------------

	repeat{

# The repeat code block below will generate random networks until one is created that has the specified number of edges.

# The runif command generates random numbers between 0 and 1 to be used to populate the network.

		repeat {rand=runif(genes.affected*genes.controlling,0,1) 
		
		# Converts the random numbers to binary. The threshold necessary to produce an edge is calculated as the
		# proportion of edges to cells in the network.
		
		network=ifelse(rand<(edges/(genes.affected*genes.controlling)),1,0)
		
		# Creates and populates the network.	
		
		dim(network)=c(genes.affected,genes.controlling)
		
		# The repeat stops when a network is created with the desired number of edges.
		
		if(sum(network)==edges) break
		}
		
		# The repeat code block below will assess the networks generated above to determine if any
		# symmetric genes are not connected to the network. If so, the above process begins again.
		
		# Calculates the number of connections for each gene individually.
		
		x=rowSums(network); y=colSums(network)
		
		# Sums up the number of edges connecting symmetric genes to the network. If an asymmetric network was
		# generated, values of 0 are added to the asymmetric genes. This is meant to determine if any genes
		# are not connected to the network.
		
		if(length(x)-length(y)==0) sums=x+y else{
			difference=ifelse(length(x)>length(y),length(x)-length(y),length(y)-length(x))
			shorter.vector=if(length(x)>length(y)) y else x
			longer.vector=if(length(x)>length(y)) x else y
			matched.vector=c(shorter.vector,rep.int(0,difference))
			sums=matched.vector+longer.vector
			}
			
		# If no values of 0 are returned by the function above, then the repeat cycle is broken.
		
		if(0 %in% sums == FALSE) break
	}	
	
	# Creates header row and column with generic gene names.
	
	rownames(network)=paste("GENE","_",c(1:genes.affected),sep="")
	colnames(network)=paste("GENE","_",c(1:genes.controlling),sep="")

	# Determines whether there are more targets (genes affected) or regulators (genes controlling).
	
	max.genes=ifelse(genes.affected>genes.controlling,genes.affected,genes.controlling)
	
	# Creates a name for the CSV file that will contain the network.
	
	filename=paste(max.genes,"-genes_",edges,"-edges_","RandomNetwork",format(Sys.time(),"_%Y%m%d_%H.%M.%S"),".csv",sep="")
	
	# Creates the CSV file.

	write.table(data.frame("cols regulators/rows targets"=rownames(network),network,check.names=FALSE), file=filename, 
	row.names=FALSE, sep=",")
	
	# Ends the function by displaying the network.
	
	return(network)
}
