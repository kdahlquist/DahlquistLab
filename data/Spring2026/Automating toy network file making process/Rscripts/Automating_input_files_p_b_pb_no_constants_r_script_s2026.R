# Base code generated using Chat GPT on GPT-5.2
# Prompt given was: Can you please help me write an r script to edit some files in excel? I have this file "C:\Users\nikki\OneDrive - lmu.edu\Desktop\Research\Spring 2026\Automating Perms\Files\Trial 19\fwd_sim\perm_01\permuted_network_01_output.xlsx" and I want to make a new folder in here "C:\Users\nikki\OneDrive - lmu.edu\Desktop\Research\Spring 2026\Automating Perms\Files\Trial 19\P_con" with the name Pcon_permuted_network_01.xlsx which is a duplicate of this file "C:\Users\nikki\OneDrive - lmu.edu\Desktop\Research\Spring 2026\Automating Perms\Files\Trial 19\fwd_sim\perm_01\permuted_network_01.xlsx" but the values in the wt_log2_expression sheet within the file need to be changed with values from the output sheet. And there are many files within the fwd_sim folder that I want to do the same thing to. 
# The following code has been tweaked and checked to confirm function 
# the use of-##-indicates where the base code was changed

## added correct packages
install.packages("openxlsx")   # run once
library(openxlsx)


# ---- Paths ----
base_path <- "C:/Users/nikki/OneDrive - lmu.edu/Desktop/Research/Spring 2026/Automating Perms/Files/Trial 19"
fwd_sim_path <- file.path(base_path, "fwd_sim")
pcon_path <- file.path(base_path, "P_con")

# Create P_con folder if it doesn't exist
if (!dir.exists(pcon_path)) {
  dir.create(pcon_path, recursive = TRUE)
}

# Get perm folders
perm_dirs <- list.dirs(fwd_sim_path, recursive = FALSE)

trial_id <- gsub(".*Trial ([0-9]+).*", "trial\\1", base_path)

for (perm_dir in perm_dirs) {
  
  ## making unique folders for each file so nothing gets overwritten
  perm_name <- basename(perm_dir)
  pcon_perm_path <- file.path(pcon_path, perm_name)
  
  if (!dir.exists(pcon_perm_path)) {
    dir.create(pcon_perm_path, recursive = TRUE)
  }
  
  
  # Find files
  # ---- Find files in this perm folder ----
  original_file <- list.files(perm_dir, 
                              pattern="^permuted_network_.*\\.xlsx$", 
                              full.names=TRUE)
  
  output_file <- list.files(perm_dir, 
                            pattern="^permuted_network_.*_output\\.xlsx$", 
                            full.names=TRUE)
  
  # remove output from original list
  original_file <- original_file[!grepl("_output", original_file)]
  
  if (length(original_file) != 1 || length(output_file) != 1) {
    message("Skipping: ", perm_dir)
    print(original_file)
    print(output_file)
    next
  }
  
  original_file <- normalizePath(original_file[1], winslash = "/", mustWork = FALSE)
  output_file   <- normalizePath(output_file[1], winslash = "/", mustWork = FALSE)
  
  message("Opening original: ", original_file)
  message("Opening output:   ", output_file)
  
  
  # Read output sheet
  ## changed to have the corrected sheet name
  output_values <- read.xlsx(output_file, sheet = "wt_log2_optimized_expression")
  
  # Load original workbook
  wb <- loadWorkbook(original_file)
  
  ## new code overwritting the sheet with the output values from the fwd sim
  ## used this for help: https://stackoverflow.com/questions/24704344/copy-an-r-data-frame-to-an-excel-spreadsheet
  ## add new timpoints 
  gene_ids <- output_values[,1]
  
  col_15_time <- output_values[, 5]
  col_30_time <- output_values[, 8]
  col_60_time <- output_values[, 14]
  
  new_15_time <- data.frame(replicate(4, col_15_time))
  new_30_time <- data.frame(replicate(5, col_30_time))
  new_60_time <- data.frame(replicate(4, col_60_time))
  
  new_wt <- cbind(new_15_time, new_30_time, new_60_time)
  
  # ---- Fix column headers to be numeric ----
  time_headers <- c(rep(15, 4), rep(30, 5), rep(60, 4))
  colnames(new_wt) <- time_headers
  
  # build headers
  headers <- c(
    "id",
    rep(15, 4),
    rep(30, 5),
    rep(60, 4)
  )
  
  new_wt <- cbind(id = gene_ids, new_wt)
  colnames(new_wt) <- headers
  
  if ("wt_log2_expression" %in% names(wb)) {
    removeWorksheet(wb, "wt_log2_expression")
  }
  
  addWorksheet(wb, "wt_log2_expression")
  
  # write data without col names
  writeData(wb, "wt_log2_expression", new_wt, colNames = FALSE, startRow = 2)
  
  # numeric headers
  time_headers <- c(rep(15, 4), rep(30, 5), rep(60, 4))
  
  writeData(wb, "wt_log2_expression", t(time_headers), startRow = 1, startCol = 2, colNames = FALSE)
  
  # gene ids
  writeData(wb, "wt_log2_expression", output_values[,1], startRow = 2, startCol = 1, colNames = FALSE)
  
  # write id header
  writeData(wb, "wt_log2_expression", "id", startRow = 1, startCol = 1, colNames = FALSE)
  
  
  # ---- optimization_parameters ----
  ## used this for help https://stackoverflow.com/questions/26936556/editing-particular-cells-of-an-excel-sheet
  opt_parm <- read.xlsx(output_file, sheet = "optimization_parameters")
  
  writeData(wb, sheet = "optimization_parameters", 
            x = opt_parm[1,1], startCol = 2, startRow = 10, colNames = FALSE)
  
  writeData(wb, sheet = "optimization_parameters", 
            x = opt_parm[2,1], startCol = 2, startRow = 12, colNames = FALSE)
  
  writeData(wb, "optimization_parameters", 1, startCol = 2, startRow = 10, colNames = FALSE)
  writeData(wb, "optimization_parameters", 1, startCol = 2, startRow = 12, colNames = FALSE)
  
  # ---- Save ----
  perm_folder_name <- basename(perm_dir)
  perm_save_path <- file.path(pcon_path, perm_folder_name)
  
  if (!dir.exists(perm_save_path)) {
    dir.create(perm_save_path, recursive = TRUE)
  }
  
  perm_name <- basename(original_file)
  perm_name <- tools::file_path_sans_ext(perm_name)
  
  new_name <- paste0("Pcon_", perm_name, "_", trial_id, ".xlsx")
  save_path <- file.path(perm_save_path, new_name)
  
  saveWorkbook(wb, save_path, overwrite = TRUE)
  
  message("Saved: ", save_path)
  
}

## code made with new prompt: can you help me edit the code so it makes a copy of all of the files in the P_con folder and makes a new folder called b_con where everything is the same but in each of the excel files in the optimization_parameters sheet cell b12 is 0 and cellb13 is a value of 1
# ---- Paths ----
pcon_path <- file.path(base_path, "P_con")
bcon_path <- file.path(base_path, "B_con")

# Create b_con folder
if (!dir.exists(bcon_path)) {
  dir.create(bcon_path, recursive = TRUE)
}

# Get permutation folders inside P_con
perm_dirs_pcon <- list.dirs(pcon_path, recursive = FALSE)

for (perm_dir in perm_dirs_pcon) {
  
  perm_name <- basename(perm_dir)
  bcon_perm_path <- file.path(bcon_path, perm_name)
  
  if (!dir.exists(bcon_perm_path)) {
    dir.create(bcon_perm_path, recursive = TRUE)
  }
  
  files <- list.files(perm_dir, pattern = "\\.xlsx$", full.names = TRUE)
  
  for (f in files) {
    
    message("Processing: ", f)
    
    wb <- loadWorkbook(f)
    
    # ---- Edit optimization_parameters ----
    writeData(wb, "optimization_parameters", 0, startCol = 2, startRow = 12, colNames = FALSE)
    writeData(wb, "optimization_parameters", 1, startCol = 2, startRow = 13, colNames = FALSE)
    
    new_name <- sub("^Pcon_", "Bcon_", basename(f))
    save_path <- file.path(bcon_perm_path, new_name)
    
    saveWorkbook(wb, save_path, overwrite = TRUE)
    
    message("Saved: ", save_path)
  }
}

## copying the chunk above to do for no con
pcon_path <- file.path(base_path, "P_con")
nocon_path <- file.path(base_path, "NO_con")

# Create pb_con folder
if (!dir.exists(nocon_path)) {
  dir.create(nocon_path, recursive = TRUE)
}

# Get permutation folders inside P_con
perm_dirs_pcon <- list.dirs(pcon_path, recursive = FALSE)

for (perm_dir in perm_dirs_pcon) {
  
  perm_name <- basename(perm_dir)
  nocon_perm_path <- file.path(nocon_path, perm_name)
  
  if (!dir.exists(nocon_perm_path)) {
    dir.create(nocon_perm_path, recursive = TRUE)
  }
  
  files <- list.files(perm_dir, pattern = "\\.xlsx$", full.names = TRUE)
  
  for (f in files) {
    
    message("Processing: ", f)
    
    wb <- loadWorkbook(f)
    
    ## need them both to have one
    writeData(wb, "optimization_parameters", 0, startCol = 2, startRow = 12, colNames = FALSE)
    
    new_name <- sub("^Pcon_", "NOcon_", basename(f))
    save_path <- file.path(nocon_perm_path, new_name)
    
    saveWorkbook(wb, save_path, overwrite = TRUE)
    
    message("Saved: ", save_path)
  }
}

## copying the chunk above to do for pb con
pcon_path <- file.path(base_path, "P_con")
pbcon_path <- file.path(base_path, "PB_con")

# Create pb_con folder
if (!dir.exists(pbcon_path)) {
  dir.create(pbcon_path, recursive = TRUE)
}

# Get permutation folders inside P_con
perm_dirs_pcon <- list.dirs(pcon_path, recursive = FALSE)

for (perm_dir in perm_dirs_pcon) {
  
  perm_name <- basename(perm_dir)
  pbcon_perm_path <- file.path(pbcon_path, perm_name)
  
  if (!dir.exists(pbcon_perm_path)) {
    dir.create(pbcon_perm_path, recursive = TRUE)
  }
  
  files <- list.files(perm_dir, pattern = "\\.xlsx$", full.names = TRUE)
  
  for (f in files) {
    
    message("Processing: ", f)
    
    wb <- loadWorkbook(f)
    
    ## need them both to have one
    writeData(wb, "optimization_parameters", 1, startCol = 2, startRow = 13, colNames = FALSE)
    
    new_name <- sub("^Pcon_", "PBcon_", basename(f))
    save_path <- file.path(pbcon_perm_path, new_name)
    
    saveWorkbook(wb, save_path, overwrite = TRUE)
    
    message("Saved: ", save_path)
  }
}

