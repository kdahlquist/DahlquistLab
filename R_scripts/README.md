# R_scripts

Scripts created by @bklein7

## Contents

  1. *Adjacency-Matrix-to-Edge-List-Conversion.R*: [OpenWetWare Notebook Description](http://openwetware.org/wiki/Converting_Adjacency_Matrices_to_Edge_Lists_in_R)
  2. *Degree-Distribution-Generator.R*
  3. *L-Curves.R*: [OpenWetWare Notebook Description](http://openwetware.org/wiki/Graphing_L-Curves_in_R)
  4. *Random-Matrix.R*
 
### How to use Random-Matrix.R

1. Download the script Random.Matrix.R
2. Launch R.
3. Select the menu item File > Change dir... and select the directory in which the script is saved.
4. Select the menu item File > Sourc R code... and select the script.
5. To run the script, type `random.network=random.network(TARGETS,REGULATORS,EDGES)` where `TARGETS` and `REGULATORS` are replaced with integer numbers representing the number of nodes (use the same number for a symmetrix matrix or different numbers for an asymmetric matrix) and `EDGES` is replaced with an integer representing the number of edges.
6. The matrix should appear in the results window and will be saved to the working directory as a .csv file.

### How to use Degree-Distribution-Generator.R

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
