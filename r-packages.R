packages_to_install <- c(
  "devtools",
  "dplyr",
  "ggplot2",
  "knitr",
  "magrittr",
  "rmarkdown",
  "tidyr"
)

install.packages(
  packages_to_install,
  dep = TRUE,
  repos = "http://cran.rstudio.com"
)
