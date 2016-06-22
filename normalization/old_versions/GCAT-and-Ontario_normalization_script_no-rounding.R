#
# Input parameters to be specified
#
flagLevel    <- 50;
offsetLevel  <- 20;

ontFile      <- "Ontario_Targets_wt-dCIN5-dGLN3-dHAP4-dHMO1-dSWI4-dZAP1_Spar_new-filenames-only_20160616.csv";
gcatFile     <- "GCAT_Targets_new-filenames-only_20160616.csv";

strains      <- c("wt","dCIN5","dGLN3","dHMO1","dHAP4","dZAP1","dSWI4","Spar")

library(limma)

#
#  Load the ontario chips and normalize.
#
Otargets <- read.csv(ontFile)

f        <- function(x) as.numeric(x$Flags > -flagLevel)
RGO      <- read.maimages(Otargets[,1], source="genepix.median", wt.fun=f)

ds       <- Otargets$Dyeswap

RGO      <- backgroundCorrect(RGO, method="normexp", offset=offsetLevel)
MAO      <- normalizeWithinArrays(RGO, method="loess")

#
# write NA to flagged *bad* spots
#
n0       <- length(MAO$M[1,])
n1       <- length(MAO$M[,1])
for (ii in 1:n0){
    for (jj in 1:n1){
    	if (RGO$weights[jj,ii]<1){
        	MAO$M[jj,ii] = NA;
        	RGO$R[jj,ii] = NA;
        	RGO$G[jj,ii] = NA; 
        }
     }
}       

#
# Identify the unique gene names
#

M1       <- tapply(MAO$M[,1],as.factor(MAO$genes$Name),mean)
ontID    <- rownames(M1)
n0	 <- length(MAO$M[1,])
n1	 <- length(M1)

#
# Identify the chip names
#
headers  <- Otargets$Header

#
# Average over repeated spots.
#
MO       <- matrix(nrow=n1,ncol=n0)
AO       <- matrix(nrow=n1,ncol=n0)
RO       <- matrix(nrow=n1,ncol=n0)
GO       <- matrix(nrow=n1,ncol=n0)

for(i in 1:n0) {
	MO[,i]<-tapply(MAO$M[,i],as.factor(MAO$genes$Name),mean)
	MO[,i]<-ds[i]*MO[,i]
	AO[,i]<-tapply(MAO$A[,i],as.factor(MAO$genes$Name),mean)
	RO[,i]<-tapply(RGO$R[,i],as.factor(RGO$genes$Name),mean)
	GO[,i]<-tapply(RGO$G[,i],as.factor(RGO$genes$Name),mean)
	if (ds[i]<0) {
	   x<-RO[,i]
	   RO[,i]<-GO[,i]
	   GO[,i]<-x
	}	
}

#
# Extract the control spots of Arabidopsis and 3XSSC
#
MO2<-as.data.frame.matrix(MO)
AO2<-as.data.frame.matrix(AO)
GO2<-as.data.frame.matrix(GO)
RO2<-as.data.frame.matrix(RO)

colnames(MO2)<-headers
rownames(MO2)<-ontID
colnames(AO2)<-headers
rownames(AO2)<-ontID
colnames(GO2)<-headers
rownames(GO2)<-ontID
colnames(RO2)<-headers
rownames(RO2)<-ontID

MO3<-subset(MO2,row.names(MO2)!="Arabidopsis")
MOn<-subset(MO3,row.names(MO3)!="3XSSC")
AO3<-subset(AO2,row.names(AO2)!="Arabidopsis")
AOn<-subset(AO3,row.names(AO3)!="3XSSC")
GO3<-subset(GO2,row.names(GO2)!="Arabidopsis")
GO4<-subset(GO3,row.names(GO3)!="3XSSC")
RO3<-subset(RO2,row.names(RO2)!="Arabidopsis")
RO4<-subset(RO3,row.names(RO3)!="3XSSC")

AOu <- AOn;
MOu <- MOn;
MOb <- MOn;

MOna <- matrix(nrow=1,ncol=n0);

n0<-length(AOn[1,])
n1<-length(AOn[,1])

#
# Compute un-normalized MA plot data and perform MAD normalization
#
for(i in 1:n0) {
	x <- log2(RO4[,i])
	y <- log2(GO4[,i])
	
	AOu[,i] <- (x+y)/2;
	MOu[,i] <- (x-y)/2;
	
	r<-sum(as.numeric(is.na(MOn[,i])));
	
	MOna[1,i] <-r
	
	MOb[,i]<-MOn[,i]/mad(subset(MOn[,i],is.na(MOn[,i])==FALSE))
	
}

#
# All comps prepped for Ontario data. Now the GCAT chips
#

Gtargets <- read.csv(gcatFile)
Gtop     <- subset(Gtargets,Gtargets$Location %in% 'Top')
Gbottom  <- subset(Gtargets,Gtargets$Location %in% 'Bottom')

f        <- function(x) as.numeric(x$Flags > -flagLevel)
RT       <- read.maimages(Gtop, source="genepix.median", wt.fun=f)
RB       <- read.maimages(Gbottom, source="genepix.median", wt.fun=f)

RGG      <- rbind(RT,RB)

dw       <- Gtop$Dyeswap

RGG      <- backgroundCorrect(RGG, method="normexp", offset=offsetLevel)
MAG      <- normalizeWithinArrays(RGG,method="loess")

M0       <- tapply(MAG$M[,1],as.factor(MAG$genes$ID),mean)

gcatID   	<- rownames(M0)
gcatIDtruncated <- strsplit(gcatID,"_01",fixed=TRUE)
chips    	<- Gtop$Header

m0       <- length(MAG$M[1,])
m1       <- length(M0)

for (ii in 1:m0){
    for (jj in 1:m1){
    	if (RGG$weights[jj,ii]<1){
        	MAG$M[jj,ii] = NA;
        	RGG$R[jj,ii] = NA;
        	RGG$G[jj,ii] = NA; 
        }
     }
}       


#
# Average over repeated spots.
#
MG       <- matrix(nrow=m1,ncol=m0)
AG       <- matrix(nrow=m1,ncol=m0)
GG       <- matrix(nrow=m1,ncol=m0)
RG       <- matrix(nrow=m1,ncol=m0)

for(i in 1:m0) {
	MG[,i]<-tapply(MAG$M[,i],as.factor(MAG$genes$ID),mean)
	MG[,i]<-dw[i]*MG[,i]
	AG[,i]<-tapply(MAG$A[,i],as.factor(MAG$genes$ID),mean)
	RG[,i]<-tapply(RGG$R[,i],as.factor(RGG$genes$ID),mean)
	GG[,i]<-tapply(RGG$G[,i],as.factor(RGG$genes$ID),mean)
	if (dw[i]<0) {
	   x<-RG[,i]
	   RG[,i]<-GG[,i]
	   GG[,i]<-x
	}	
}

MG2<-as.data.frame.matrix(MG)
AG2<-as.data.frame.matrix(AG)
GG2<-as.data.frame.matrix(GG)
RG2<-as.data.frame.matrix(RG)

colnames(MG2) 	<- chips
rownames(MG2) 	<- gcatIDtruncated
colnames(AG2) 	<- chips
rownames(AG2) 	<- gcatIDtruncated
colnames(GG2) 	<- chips
rownames(GG2) 	<- gcatIDtruncated
colnames(RG2) 	<- chips
rownames(RG2) 	<- gcatIDtruncated

MGn<-subset(MG2,row.names(MG2)%in% ontID)
AGn<-subset(AG2,row.names(AG2)%in% ontID)
GG4<-subset(GG2,row.names(GG2)%in% ontID)
RG4<-subset(RG2,row.names(RG2)%in% ontID)

AGu <- AGn;
MGu <- MGn;
MGb <- MGn;

MGna <- matrix(nrow=1,ncol=n0);

m0<-length(AGn[1,])
m1<-length(AGn[,1])

#
# Compute un-normalized MA plot data and perform MAD normalization
#
for(i in 1:m0) {
	x <- log2(RG4[,i])
	y <- log2(GG4[,i])
	
	AGu[,i] <- (x+y)/2;
	MGu[,i] <- (x-y)/2;
	
	r<-sum(as.numeric(is.na(MGn[,i])));
	
	MGna[1,i] <-r
	
	MGb[,i]<-MGn[,i]/mad(subset(MGn[,i],is.na(MGn[,i])==FALSE))	
}

#
# within chip normalized data write
#
GO 		<- merge(MOn,MGn,by="row.names",all=T)
rownames(GO) 	<- GO$Row.names
GO2 		<- subset(GO,rownames(GO) %in% ontID)
MasterList 	<- rbind(Otargets[,c('Header','MasterList')],Gtop[,c('Header','MasterList')])
OrderedML  	<- MasterList[sort.list(MasterList$MasterList),]
MGOn		<- GO2[,match(OrderedML$Header,colnames(GO2))]

write.table(MGOn,"GCAT_and_Ontario_Within_Array_Normalization.csv",sep=",",col.names=NA,row.names=TRUE)

GO 		<- merge(AOn,AGn,by="row.names",all=T)
rownames(GO) 	<- GO$Row.names
GO2 		<- subset(GO,rownames(GO) %in% ontID)
MasterList 	<- rbind(Otargets[,c('Header','MasterList')],Gtop[,c('Header','MasterList')])
OrderedML  	<- MasterList[sort.list(MasterList$MasterList),]
AGOn 		<- GO2[,match(OrderedML$Header,colnames(GO2))]

#
# between chip normalized data write
#

GO 		<- merge(MOb,MGb,by="row.names",all=T)
rownames(GO) 	<- GO$Row.names
GO2 		<- subset(GO,rownames(GO) %in% ontID)
MasterList 	<- rbind(Otargets[,c('Header','MasterList')],Gtop[,c('Header','MasterList')])
OrderedML  	<- MasterList[sort.list(MasterList$MasterList),]
MGOb 		<- GO2[,match(OrderedML$Header,colnames(GO2))]

write.table(MGOb,"GCAT_and_Ontario_Between_Array_Normalization.csv",sep=",",col.names=NA,row.names=TRUE)

#
# unnormalized data write
#

GO 		<- merge(MOu,MGu,by="row.names",all=T)
rownames(GO) 	<- GO$Row.names
GO2 		<- subset(GO,rownames(GO) %in% ontID)
MasterList 	<- rbind(Otargets[,c('Header','MasterList')],Gtop[,c('Header','MasterList')])
OrderedML  	<- MasterList[sort.list(MasterList$MasterList),]
MGOu 		<- GO2[,match(OrderedML$Header,colnames(GO2))]

write.table(MGOu,"GCAT_and_Ontario_Unnormalized.csv",sep=",",col.names=NA,row.names=TRUE)

GO 		<- merge(AOu,AGu,by="row.names",all=T)
rownames(GO) 	<- GO$Row.names
GO2 		<- subset(GO,rownames(GO) %in% ontID)
MasterList 	<- rbind(Otargets[,c('Header','MasterList')],Gtop[,c('Header','MasterList')])
OrderedML  	<- MasterList[sort.list(MasterList$MasterList),]
AGOu		<- GO2[,match(OrderedML$Header,colnames(GO2))]
