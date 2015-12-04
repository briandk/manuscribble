arguments <- commandArgs()
manuscript <- arguments[length(arguments)]

rmarkdown::render(
  input = manuscript,
  output_format = "all"
)
