## code to prepare `koans` dataset goes here
koans <- list(
    "R/koans/about-expectations.R",
    "R/koans/about-binding-basics.R")

koans_df <- dplyr::tibble(lesson_file = unlist(koans)) %>%
    dplyr::mutate(number_koans = purrr::map_int(lesson_file, function(x)
        getParseData(parse(file = x)) %>%
        dplyr::filter(text == "test_that") %>%
        nrow)) %>%
    dplyr::mutate(cumulative_koans = purrr::accumulate(number_koans, `+`)) %>%
    dplyr::mutate(test_file = lesson_file %>%
        stringr::str_replace("R/koans/", "tests/testthat/") %>%
        stringr::str_replace("about", "test-about"))

usethis::use_data(koans_df, overwrite = T, internal = TRUE)