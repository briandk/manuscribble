manuscript <- commandArgs(trailingOnly = TRUE)

rmarkdown::render(
  input = manuscript,
  output_format = "all"
)
