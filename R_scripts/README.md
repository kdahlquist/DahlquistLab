# R_scripts

Scripts created by @bklein7

## Contents

  1. *Adjacency-Matrix-to-Edge-List-Conversion*: [OpenWetWare Notebook Description](http://openwetware.org/wiki/Converting_Adjacency_Matrices_to_Edge_Lists_in_R)
  2. *L-Curves*: [OpenWetWare Notebook Description](http://openwetware.org/wiki/Graphing_L-Curves_in_R)
 
 
1. Invoke the  [random network generator script](https://github.com/kdahlquist/DahlquistLab/blob/master/R_scripts/Random-Matrix.R).
2. Type the following into R: `random.network=random.network(TARGETS,REGULATORS,EDGES)`
   (replace the capitalized words with their corresponding integer values).
3. Invoke the [degree distribution generator script](https://github.com/kdahlquist/DahlquistLab/blob/master/R_scripts/Degree-Distribution-Generator.R).
4. Type the following into R exactly as written: `degree.distribution(random.network)`
