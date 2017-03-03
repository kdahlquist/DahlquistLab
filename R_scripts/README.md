# R_scripts

Scripts created by @bklein7

## Contents

  1. *Adjacency-Matrix-to-Edge-List-Conversion*: [OpenWetWare Notebook Description](http://openwetware.org/wiki/Converting_Adjacency_Matrices_to_Edge_Lists_in_R)
  2. *L-Curves*: [OpenWetWare Notebook Description](http://openwetware.org/wiki/Graphing_L-Curves_in_R)
 
 
0. Change directory
1. Sourc R code, choose random network generator
2. test code by random.network(21,21,31) and it should produce a matrix
3. now we want to do it and store as a variable, so for example network1=random.network(21,21,31)
4. went into degree distribution script and commented out the set working directory, line 13 so no conflict
5. source R code, load degree distributions script
6. type degree.distribution(network1,"title")
7. graph is saved as jpg in working directory!

To use a different adjacency matrix other than the random network generator, do the following:
1. save adjacency matrix as .csv file with nothing (null) in cell A1
2. test import by read.csv("filename",row.names=1,header=TRUE,sep=",")
3. then assign variable to imported data by variablname=read.csv("filename",row.names=1,header=TRUE,sep=",")
4. then run degree.distribution(variablename,"title")



1. Invoke the  [random network generator script](https://github.com/kdahlquist/DahlquistLab/blob/master/R_scripts/Random-Matrix.R).
2. Type the following into R: `random.network=random.network(TARGETS,REGULATORS,EDGES)`
   (replace the capitalized words with their corresponding integer values).
3. Invoke the [degree distribution generator script](https://github.com/kdahlquist/DahlquistLab/blob/master/R_scripts/Degree-Distribution-Generator.R).
4. Type the following into R exactly as written: `degree.distribution(random.network)`
