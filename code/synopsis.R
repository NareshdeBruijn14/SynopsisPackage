# Check and import a dataset, and provide a summary after importing the dataset.

# dependencies
library(readxl)
library(tools)

# function synopsis

synopsis <- function(file_path) {
  # Initialize a variable to store the data
  data <- NULL

  # Check file extension
  file_extension <- tolower(tools::file_ext(file_path))

  # Try reading as CSV
  if (file_extension == "csv") {
    data <- tryCatch({
      read.csv(file_path)
    }, error = function(e) NULL)


  # Try reading as Excel
  }else if (file_extension %in% c("xls", "xlsx")) {
    data <- tryCatch({
      readxl::read_excel(file_path)

    }, error = function(e) NULL)

  # Try reading as RDS
  }else if (file_extension == "rds") {
    data <- tryCatch({
      readRDS(file_path)

    }, error = function(e) NULL)

  # Try reading as TSV
  }else if (file_extension == "tsv") {
    data <- tryCatch({
      read.table(file_path, sep = "\t", header = TRUE)

    }, error = function(e) NULL)


  }else
  # If none of the methods worked. return error message
  return("File format not recognized or file could not be read.")

  if (!is.null(data)) {
    NA_info <- list(
      NA_present = any(is.na(data)),
      NA_count = sum(is.na(data)),
      NA_structure = is.na(data)
    )

    return(list(
      data = data,
      class = class(data),
      dim = dim(data),
      str = capture.output(str(data)),
      typeof = typeof(data),
      names = names(data),
      NA_info = NA_info
    ))
    } else return(NULL)
}

synopsis("./data/species.csv")

results <- synopsis("./data/species.csv")

print(results$data)
print(results$class)
print(results$dim)
print(results$str)
print(results$typeof)
print(results$names)
print(results$NA_info)
