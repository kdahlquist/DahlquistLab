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

1. Download the script Degree-Distribution-Generator.R
2. Launch R.
3. Select the menu item File > Change dir... and select the directory in which the script is saved.
4. Select the menu item File > Source R code... and select the script Degree-Distribution-Generator.R
5. To create a chart for a random network directly from the Random-Matrix.R generator:
    * Download the script Random.Matrix.R and save it in the same directory as Degree-Distribution-Generator.R
    * Select the menu item File > Sourc R code... and select the Random.Matrix.R script.
    * Run the script, saving the output to a variable.  For example `network1=random.network(21,21,31)` where the variable network1 is storing a random network with 21 nodes and 31 edges.
6. Then type `degree.distribution(network1,"title")` which will plot the matrix stored in the variable `network1`, giving the chart the title enclosed in the quotes.
7. The chart will e saved as a .jpg file in the working directory.
8. To use a different adjacency matrix other than one created by the Random-Matrix.R generator, do the following:
    * Save your adjacency matrix as a .csv file with nothing (null) in cell A1
    * Test the import by typing `read.csv("filename",row.names=1,header=TRUE,sep=",")`
    * Then assign a variable to the imported data by typing `variablname=read.csv("filename",row.names=1,header=TRUE,sep=",")`
    * Then run `degree.distribution(variablename,"title")`
