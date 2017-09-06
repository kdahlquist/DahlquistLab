cat("Provide a Pathway to the Dataset: ")
    Data <- readLines(con=stdin(),1)
    
lcurve=read.table(Data,header=T)

cat("Specify the Maximum Penalty Term Value to be Displayed on the x-axis (Press [Enter] to skip):")
	x.max <- readLines(con=stdin(),1)
	
cat("Specify the Maximum LSE Value to be Displayed on the y-axis (Press [Enter] to skip):")
	y.max <- readLines(con=stdin(),1)
	
cat("Specify the Minimum LSE Value to be Displayed on the y-axis (Press [Enter] to skip):")
	y.min <- readLines(con=stdin(),1)
	
cat("Provide a Title (Press [Enter] to skip): ")
    Title <- readLines(con=stdin(),1)
    
cat("Would you like to Display Alpha Value Labels on the Graph? (y/n)")
	alpha.labels <- readLines(con=stdin(),1)
	
if (x.max == "" & y.max == "" & y.min == "") {
	plot(lcurve$Penalty,lcurve$LSE,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,max(lcurve$Penalty)*1.1),
	ylim=c(min(lcurve$LSE),max(lcurve$LSE)))
} else if (x.max != "" & y.max == "" & y.min == "") {
	plot(lcurve$Penalty,lcurve$LSE,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,as.numeric(x.max)),
	ylim=c(min(lcurve$LSE),max(lcurve$LSE)))
} else if (x.max != "" & y.max != "" & y.min == "") {
	plot(lcurve$Penalty,lcurve$LSE,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,as.numeric(x.max)),
	ylim=c(min(lcurve$LSE),as.numeric(y.max)))
} else if (x.max != "" & y.max != "" & y.min != "") {
	plot(lcurve$Penalty,lcurve$LSE,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,as.numeric(x.max)),
	ylim=c(as.numeric(y.min),as.numeric(y.max)))
} else if (x.max != "" & y.max == "" & y.min != "") {
	plot(lcurve$Penalty,lcurve$LSE,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,as.numeric(x.max)),
	ylim=c(as.numeric(y.min),max(lcurve$LSE)))
} else if (x.max == "" & y.max != "" & y.min != "") {
	plot(lcurve$Penalty,lcurve$LSE,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,max(lcurve$Penalty)*1.1),
	ylim=c(as.numeric(y.min),as.numeric(y.max)))
} else if (x.max == "" & y.max != "" & y.min == "") {
	plot(lcurve$Penalty,lcurve$LSE,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,max(lcurve$Penalty)*1.1),
	ylim=c(min(lcurve$LSE),as.numeric(y.max)))
} else if (x.max == "" & y.max == "" & y.min != "") {
	plot(lcurve$Penalty,lcurve$LSE,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,max(lcurve$Penalty)*1.1),
	ylim=c(as.numeric(y.min),max(lcurve$LSE)))
}

if (alpha.labels == "y") {
	text(lcurve$Penalty,lcurve$LSE,label=paste("α =",lcurve$Alpha,sep=" "),cex=0.5,pos=4,offset=1)
}

lines(lcurve$Penalty,lcurve$LSE)

cat("Would you like to Plot Further L-Curves on the Same Graph? (y/n)")
	replicates <- readLines(con=stdin(),1)
	
if (replicates == "y") {
	
	counter=1; col1="black"; col2="red"; col3="yellow"; col4="green"; col5="cyan"; col6="blue"; col7="magenta"
	
	cat("Provide a Label for the Existing L-Curve (will appear in figure legend): ")
    	Legend1 <- readLines(con=stdin(),1)
    	
    repeat{
    	
    	counter=counter+1
    	
    	cat("Provide a Label for the Next L-Curve (will appear in figure legend): ")
    	Legend <- readLines(con=stdin(),1)
    	assign(paste("Legend",counter,sep=""),Legend)

	cat("Provide a Pathway to the Next Dataset: ")
    	Data <- readLines(con=stdin(),1)

		lcurve=read.table(Data,header=T)
		
		color=paste("col",counter,sep="")
		points(lcurve$Penalty,lcurve$LSE,col=get(color)); lines(lcurve$Penalty,lcurve$LSE,col=get(color))
		
		cat("Would you like to Plot Further L-Curves on the Same Graph? (y/n)")
		more.replicates <- readLines(con=stdin(),1)
		
		if (more.replicates == "n") {
			
			final.count=counter
			final.Legend.count=paste("Legend",c(1:final.count),sep="")
			final.Legend=as.matrix(as.data.frame(mget(final.Legend.count)))
			final.color.count=paste("col",c(1:final.count),sep="")
			final.colors=as.matrix(as.data.frame(mget(final.color.count)))
			
			legend("topright",legend=final.Legend,col=final.colors,lty=1)
			
			break
		}
    }		
}
