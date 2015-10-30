packages_to_install <- c(
  "checkpoint",
  "dplyr",
  "ggplot2",
  "knitr",
  "magrittr",
  "rmarkdown"
)

install.packages(
  packages_to_install,
  dep = TRUE,
  repos = "http://cran.rstudio.com"
)