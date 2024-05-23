# Check and import a dataset, and provide a summary after importing the dataset.

# dependencies
library(readxl)
library(tools)

# function synopsis

synopsis <- function(file_path) {
  # Initialize a variable to store the data
  data <- NULL

  # Check file extension
  file_extension <- tolower(file_ext(file_path))

  # Try reading as CSV
  if (file_extension == "csv") {
    try({
      data <- read.csv(file_path)
      return(data)
    }, silent = TRUE)

  # Try reading as Excel
  }if (file_extension %in% c("xls", "xlsx")) {
    try({
      data <- readxl::read_excel(file_path)
      return(data)
    }, silent = TRUE)

  # Try reading as RDS
  }if (file_extension == "rds") {
    try({
      data <- readRDS(file_path)
      return(data)
    }, silent = TRUE)

  # Try reading as TSV
  }if (file_extension == "tsv") {
    try({
      data <- read.table(file_path, sep = "\t", header = TRUE)
      return(data)
    }, silent = TRUE)

  }if (!is.null(data)) {
    NA_info <- list(
      NA_present = any(is.na(data)),
      NA_count = sum(is.na(data)),
      NA_structure = is.na(data)
    )

    return(list(
      class = class(data),
      dim = dim(data),
      str = str(data),
      typeof = typeof(data),
      names = names(data),
      NA_info = NA_info
    ))

  }else {
  # If none of the methods worked. return error message
  stop("File format not recognized or file could not be read.")

  }
}
