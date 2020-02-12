## code to prepare `koans` dataset goes here
koans <- list(
    "R/koans/about-expectations.R",
    "R/koans/about-names-and-values.R")

usethis::use_data(koans, overwrite = T)
