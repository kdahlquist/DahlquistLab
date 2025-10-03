This directory contains the model outputs and analysis for the Trial 10 permutations.

- Since weights for the original 22 trials were chosen arbitrarily (1, -1, 2, or -2), we also investigated whether the model performance was solely based on network structure, or whether it was also impacted by the assignment of a particular weight value to each edge.
- All 24 permutations of the weight assignments to edges were modeled for the networks originally ranked 1st (Trial 10) and 7th (Trial 8) to determine the impact of the weights.
- There is a folder for each of the 24 permutations, named Trial 10.x.  Each folder contains the model runs for holding b constant, P constant, P & b constant, and no parameters constant for that particular permutation.
  - In the summary files:
    - Trial 10 Permutation_no-constants_Summary.xlsx
    - Trial 10 Permutation_P-b-constant_Summary.xlsx
  - The LSE of the weights were calculated for each trial as before. For each of the numbered run sheets, there are two matrices, one copied from the “network_optimized_weights” sheet which gives the estimated weights, and one copied from the “network_weights” sheet which gives the known weights for that run.  A formula also arranged in a matrix computes the square of the difference, and a final formula sums it up to get the LSE. The summary tab (named "No Constants" and "P and b Constant", respectively) then collects the LSE values for each trial in two columns.  One set is ordered based on the trial number.  One set is ordered based on the rank, smallest to largest.  The sum and average of the LSE’s was also computed.
- The file "Trial 10 Permutations_weight-information.xlsx" shows the adjacency matrices for all the permutations on one worksheet.
- The file "Trial-8-and-10-weight-permutation-heat-maps.xlsx" was used to make heat maps of the weights for the ISMB 2025 poster.
