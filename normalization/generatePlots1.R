
flaskList<-colnames(MGOu)
#
# generate MA plots
#
dev.new()
for (j in 1:length(flaskList)) {
    par(mfrow=c(2,1))
    plot(AGOu[,j],MGOu[,j],main=flaskList[j],xlab="A",ylab="M",ylim=c(-2,2),xlim=c(5,15))
    plot(AGOn[,j],MGOn[,j],main="normalized",xlab="A",ylab="M",ylim=c(-2,2),xlim=c(5,15))
    Sys.sleep(0.5)
    r<-paste(flaskList[j],"jpg",sep=".")
    dev.copy(jpeg,r)
    dev.off()
}

#
# generate normalization boxplots
#
for (i in 1:length(strains)) {
  st<-strains[i]
  lt<-grep(st,flaskList)
  dev.new()
  par(mfrow=c(3,1))
  boxplot(MGOu[,lt],main=st,ylab='Log Fold Change',ylim=c(-1,1))
  boxplot(MGOn[,lt],main='Within Chip Normalization',ylab='Log Fold Change',ylim=c(-1,1))
  boxplot(MGOb[,lt],main='Between Chip Normalization',ylab='Log Fold Change',ylim=c(-3,3))
  r<-paste(strains[i],"jpg",sep=".")
  dev.copy(jpeg,r)  
  dev.off()
}
