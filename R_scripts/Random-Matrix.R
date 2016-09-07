random.matrix = function(rows, columns, connections) {
	repeat{
		repeat {rand=runif(rows*columns,0,1)
		matrix=ifelse(rand<(connections/(rows*columns)),0,1)
		dim(matrix)=c(rows,columns)
		if(sum(matrix)==connections) break
		}
		x=rowSums(matrix); y=colSums(matrix); sums=x+y
		if(0 %in% sums == FALSE) break
	}	
	return(matrix)
}


#speed up?
