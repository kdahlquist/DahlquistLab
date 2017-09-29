# Script written by Brandon J. Klein
# L-Curves
# Last Updated: 2017-09-28

# This interactive script facilitates the plotting of L-curves in R. It supports manual specification of the data, axes limits, a title, legend labels, and alpha value labels.
# Further, it can support the graphing of up to 42 L-curves on a single graph.

# Prompts the user to upload an L-curve dataset (see https://openwetware.org/wiki/Graphing_L-Curves_in_R for formatting instructions)
cat("Provide a Pathway to the Dataset: ")
    Data <- readLines(con=stdin(),1)

# Populates a table with information from the uploaded L-curve dataset
lcurve=read.table(Data,header=T)

# Propmts the user to specify a maximum value to be shown on the x-axis, if desired (minimum Penalty Term value is 0)
cat("Specify the Maximum Penalty Term Value to be Displayed on the x-axis (Press [Enter] to skip):")
	x.max <- readLines(con=stdin(),1)
	
# Prompts the user to specify a maximum LSE value to be shown the y-axis, if desired 	
cat("Specify the Maximum LSE Value to be Displayed on the y-axis (Press [Enter] to skip):")
	y.max <- readLines(con=stdin(),1)
	
# Prompts the user to specify a minimum LSE value to be shown on the y-axis, if desired 	
cat("Specify the Minimum LSE Value to be Displayed on the y-axis (Press [Enter] to skip):")
	y.min <- readLines(con=stdin(),1)
	
# Prompts the user to enter a title for the L-curve graph, if desired
cat("Provide a Title (Press [Enter] to skip): ")
    Title <- readLines(con=stdin(),1)
    
# Prompts the user to specify if the alpha values at which each point was generated should be displayed on the L-curve
cat("Would you like to Display Alpha Value Labels on the Graph? (y/n)")
	alpha.labels <- readLines(con=stdin(),1)

# This 8-pronged if-else statement plots the L-curve based on the x and y axis constraints specified by the user, accounting for all possible permutations of inputted vs. omitted information
if (x.max == "" & y.max == "" & y.min == "") {
	plot(lcurve$Penalty,lcurve$LSE,pch=20,cex=0.4,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,max(lcurve$Penalty)*1.1),
	ylim=c(min(lcurve$LSE),max(lcurve$LSE)))
} else if (x.max != "" & y.max == "" & y.min == "") {
	plot(lcurve$Penalty,lcurve$LSE,pch=20,cex=0.4,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,as.numeric(x.max)),
	ylim=c(min(lcurve$LSE),max(lcurve$LSE)))
} else if (x.max != "" & y.max != "" & y.min == "") {
	plot(lcurve$Penalty,lcurve$LSE,pch=20,cex=0.4,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,as.numeric(x.max)),
	ylim=c(min(lcurve$LSE),as.numeric(y.max)))
} else if (x.max != "" & y.max != "" & y.min != "") {
	plot(lcurve$Penalty,lcurve$LSE,pch=20,cex=0.4,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,as.numeric(x.max)),
	ylim=c(as.numeric(y.min),as.numeric(y.max)))
} else if (x.max != "" & y.max == "" & y.min != "") {
	plot(lcurve$Penalty,lcurve$LSE,pch=20,cex=0.4,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,as.numeric(x.max)),
	ylim=c(as.numeric(y.min),max(lcurve$LSE)))
} else if (x.max == "" & y.max != "" & y.min != "") {
	plot(lcurve$Penalty,lcurve$LSE,pch=20,cex=0.4,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,max(lcurve$Penalty)*1.1),
	ylim=c(as.numeric(y.min),as.numeric(y.max)))
} else if (x.max == "" & y.max != "" & y.min == "") {
	plot(lcurve$Penalty,lcurve$LSE,pch=20,cex=0.4,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,max(lcurve$Penalty)*1.1),
	ylim=c(min(lcurve$LSE),as.numeric(y.max)))
} else if (x.max == "" & y.max == "" & y.min != "") {
	plot(lcurve$Penalty,lcurve$LSE,pch=20,cex=0.4,main=Title,xlab="Penalty Term",ylab="LSE",xlim=c(0,max(lcurve$Penalty)*1.1),
	ylim=c(as.numeric(y.min),max(lcurve$LSE)))
}

# Displays alpha value labels on the plot if the user had indicated to do so (lines 29-30)
if (alpha.labels == "y") {
	text(lcurve$Penalty,lcurve$LSE,label=paste("α =",lcurve$Alpha,sep=" "),cex=0.4,pos=4,offset=1)
}

# Plots a line connecting the individual points on the graph to yield a proper "L-curve"
lines(lcurve$Penalty,lcurve$LSE)

# Prompts the user to specify if further L-curves should be plotted on the same graph for comparison
cat("Would you like to Plot Further L-Curves on the Same Graph? (y/n)")
	replicates <- readLines(con=stdin(),1)
	
# If the user responded that further L-curves are to be plotted, the following code block is engaged
if (replicates == "y") {
	
# Variables encoding line color, legend color, and line type for up to 42 distinct L-curves are specified
	counter=1; col1="black"; col2="red"; col3="blue"; col4="green"; col5="cyan"; col6="magenta"; col7="grey";
	col8="black"; col9="red"; col10="blue"; col11="green"; col12="cyan"; col13="magenta"; col14="grey";
	col15="black"; col16="red"; col17="blue"; col18="green"; col19="cyan"; col20="magenta"; col21="grey";
	col22="black"; col23="red"; col24="blue"; col25="green"; col26="cyan"; col27="magenta"; col28="grey";
	col29="black"; col30="red"; col31="blue"; col32="green"; col33="cyan"; col34="magenta"; col35="grey";
	col36="black"; col37="red"; col38="blue"; col39="green"; col40="cyan"; col41="magenta"; col42="grey"; 
	lty1=1; lty2=1; lty3=1; lty4=1; lty5=1; lty6=1; lty7=1;
	lty8=2; lty9=2; lty10=2; lty11=2; lty12=2; lty13=2; lty14=2;
	lty15=3; lty16=3; lty17=3; lty18=3; lty19=3; lty20=3; lty21=3;
	lty22=4; lty23=4; lty24=4; lty25=4; lty26=4; lty27=4; lty28=4;
	lty29=5; lty30=5; lty31=5; lty32=5; lty33=5; lty34=5; lty35=5;
	lty36=6; lty37=6; lty38=6; lty39=6; lty40=6; lty41=6; lty42=6;
	
# Prompts the user to provide a legend label for the original L-curve
	cat("Provide a Label for the Existing L-Curve (will appear in figure legend): ")
    	Legend1 <- readLines(con=stdin(),1)
    	
# The following code block repeats until the user is done entering new L-curves
    repeat{
    	
# This counter keeps track of how many L-curves are being plotted in total
    	counter=counter+1
    	
# Prompts the user to provide a legend label for the new L-curve    	
    	cat("Provide a Label for the Next L-Curve (will appear in figure legend): ")
    	Legend <- readLines(con=stdin(),1)
    	
# Assigns a variable name to the legend label including the current counter number
    	assign(paste("Legend",counter,sep=""),Legend)

# Prompts the user to upload a new L-curve dataset
	cat("Provide a Pathway to the Next Dataset: ")
    	Data <- readLines(con=stdin(),1)

# Populates a table with information from the newly uploaded L-curve dataset
		lcurve=read.table(Data,header=T)
		
# Extracts a distinct line color and type combination based on the current counter number
		color=paste("col",counter,sep="")
		lty=paste("lty",counter,sep="")
		
# Plots the new L-curve		
		points(lcurve$Penalty,lcurve$LSE,pch=20,cex=0.6,col=get(color)); lines(lcurve$Penalty,lcurve$LSE,col=get(color),lty=get(lty))
		
# Prompts the user to specify if further L-curves will be inputted. If so, this code block is repeated.
		cat("Would you like to Plot Further L-Curves on the Same Graph? (y/n)")
		more.replicates <- readLines(con=stdin(),1)
		
# If the user will not be inputting any further L-curves, the repeat sequence terminates and a legend is generated based on user-specified information
		if (more.replicates == "n") {
			
			final.count=counter
			final.Legend.count=paste("Legend",c(1:final.count),sep="")
			final.Legend=as.matrix(as.data.frame(mget(final.Legend.count)))
			final.color.count=paste("col",c(1:final.count),sep="")
			final.colors=as.matrix(as.data.frame(mget(final.color.count)))
			
			legend("topright",legend=final.Legend,col=final.colors,lty=c(1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,4,4,4,5,5,5,5,5,5,5,6,6,6,6,6,6,6),bg="white",cex=0.5)
			
			break
		}
    }		
}
