packages_to_install <- c( "broom"
                        , "checkpoint"
                        , "DBI"
                        , "devtools"
                        , "dplyr"
                        , "forcats"
                        , "ggplot2"
                        , "ggvis"
                        , "haven"
                        , "httr"
                        , "hms"
                        , "jsonlite"
                        , "knitr"
                        , "lubridate"
                        , "magrittr"
                        , "modelr"
                        , "purrr"
                        , "readr"
                        , "readxl"
                        , "rmarkdown"
                        , "rvest"
                        , "stringr"
                        , "tibble"
                        , "tidyr"
                        , "xml2"
)

install.packages(
  packages_to_install,
  dep = TRUE,
  repos = "https://cran.rstudio.com"
)
