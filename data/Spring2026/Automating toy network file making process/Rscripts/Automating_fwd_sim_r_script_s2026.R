# Base code generated using Chat GPT on GPT-5.2
# Prompt given was: Can you please help me create an r script for which I can upload a file and it would create copies of the file? These copies should follow the weight matrix of the network sheet in the file only permuting the values of the network_weights tab. Thus The files would all be the same except for unique network_weight tabs which follow the same weight matrix but have unique values. There should be 24 possible permutations.
# The following code has been tweaked and checked to confirm function 
# the use of-##-indicates where the base code was changed

# Description: This code takes a given input file and creates all possible
# permutations of the weights for the given weight matrix
# it will save these files in a new folder with sub folders for each network
# to make running them easier.

# The purpose is to automate the creation of the inputs for forward simulation.

# Right now the code is based on a 4 edge network but it can be adapted in the 
# future for different sized networks. 

############################################################
# Create 24 permuted copies of workbook
# - Network sheet stays identical
# - network_weights tab values are permuted
############################################################

# ---------------- USER SETTINGS -----------------

# the following line should be changed to reflect where the original file is
input_file <- "C:/Users/nikki/OneDrive - lmu.edu/Desktop/Research/Spring 2026/Automating Perms/Files/Trial 19/DB5_derived_sample_network_2.2.xlsx"
## added input correct input file

weights_sheet <- "network_weights"
network_sheet <- "network"


## Define master folder
master_folder <- "C:/Users/nikki/OneDrive - lmu.edu/Desktop/Research/Spring 2026/Automating Perms/Files/Trial 19/fwd_sim"
dir.create(master_folder, showWarnings = FALSE)

# ---------------- PACKAGES -----------------------

if (!require(readxl)) install.packages("readxl")
if (!require(openxlsx)) install.packages("openxlsx")
if (!require(gtools)) install.packages("gtools")

library(readxl)
library(openxlsx)
library(gtools)

# ---------------- READ ORIGINAL FILE -----------------

nw <- read_excel(input_file, sheet = "network_weights")
nw_df <- as.data.frame(nw)

# Numeric part (skip first column)
numeric_part <- nw_df[, -1]

# Locate non-zero entries
nonzero_idx <- which(numeric_part != 0, arr.ind = TRUE)
nonzero_values <- numeric_part[nonzero_idx]

# ---------------- GENERATE PERMUTATIONS -----------------

perms <- permutations(
  n = length(nonzero_values),
  r = length(nonzero_values),
  v = nonzero_values
)

num_perms <- nrow(perms)

# Prepare summary storage
summary_list <- list()

# ---------------- WRITE OUTPUT FILES -----------------

for (i in 1:num_perms) {
  
  ## Make subfolder inside the master folder
  subfolder <- file.path(master_folder, sprintf("perm_%02d", i))
  dir.create(subfolder, showWarnings = FALSE)
  
  # Apply the permutation
  new_numeric <- numeric_part
  new_numeric[nonzero_idx] <- perms[i, ]
  
  out_df <- nw_df
  out_df[, -1] <- new_numeric
  
  wb <- loadWorkbook(input_file)
  writeData(wb, sheet = "network_weights", x = out_df)
  
  output_filename <- sprintf("permuted_network_%02d.xlsx", i)
  outfile <- file.path(subfolder, output_filename)
  saveWorkbook(wb, outfile, overwrite = TRUE)
  
  # Add to summary
  summary_list[[i]] <- data.frame(
    file = output_filename,
    folder = basename(subfolder),
    permutation = paste(perms[i, ], collapse = ", ")
  )
}

## Add the summary file to the master folder
summary_df <- do.call(rbind, summary_list)
summary_file <- file.path(master_folder, "permutation_summary.csv")

write.csv(summary_df, summary_file, row.names = FALSE)

cat("Summary file saved to:", summary_file, "\n")

