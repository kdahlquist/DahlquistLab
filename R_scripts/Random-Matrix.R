#This document encodes the function "random.matrix", which will generate a random binary matrix
#with the size and number of connections (1's) specified by the user. This function is written 
#to continue generating matrices until one is created that has no adjacent row/column pair without 
#connections. Users will input their specifications in the following format: 			
#     random.matrix(# of rows, # of columns, # of connections)

random.matrix = function(rows, columns, connections) {
	repeat{

#The repeat code block below will generate random matrices until one is created that has the specified number of connections.

#The runif command generates random numbers between 0 and 1 to be used to populate the matrix.

		repeat {rand=runif(rows*columns,0,1)
		
		#Converts the random numbers to binary. The threshold necessary to produce a connection is calculated 
		#as the proportion of connections to cells in the matrix.
		
		matrix=ifelse(rand<(connections/(rows*columns)),0,1)
		
		#Creates and populates the matrix.	
		
		dim(matrix)=c(rows,columns)
		
		#The repeat stops with a matrix is created with the desired number of connections.
		
		if(sum(matrix)==connections) break
		}
		
		#The repeat code block below will assess the matrices generated above to determine 
		#if any adjacent row/column pair is without a connection. If so, the above process begins again.
		#Calculates the sums of each row and column. These two series of sums are then added 
		#to determine if any adjacent row/column pair is without a connection (value would be 0).
		
		x=rowSums(matrix); y=colSums(matrix); sums=x+y
		
		#If no values of 0 are returned by the function above, then the repeat cycle is broken.
		
		if(0 %in% sums == FALSE) break
	}	
	
	#Creates a name for the CSV file that will contain the matrix
	
	filename=paste(rows,"_",columns,"_",connections,"_","RandomMatrix",format(Sys.time(),"_%Y%m%d_%H.%M.%S"),".csv",sep="")
	
	#Creates the CSV file. Row and column names are excluded. This file will be exported to the user's working directory.
		#Windows users can set their working directory as their desktop as follows:	setwd("C:/Desktop")
		#Mac users can set their working directory as their desktop as follows:		setwd("~/Desktop")

	write.table(matrix, file=filename, row.names=FALSE, col.names=FALSE, sep=",")
	
	#Ends the function by displaying the matrix.
	
	return(matrix)
}
