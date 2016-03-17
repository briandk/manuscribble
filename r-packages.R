packages_to_install <- c(
  "checkpoint",
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
  repos = "https://cran.rstudio.com"
)
