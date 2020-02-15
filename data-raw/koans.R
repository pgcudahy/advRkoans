## code to prepare `koans` dataset goes here
koans <- c(
    "inst/koans/about-expectations.R",
    "inst/koans/about-binding-basics.R",
    "inst/koans/about-copy-on-modify.R")

koans_df <- dplyr::tibble(lesson_file = koans) %>%
    dplyr::mutate(lesson_base = basename(lesson_file)) %>%
    dplyr::mutate(lesson_directory = dirname(lesson_file) %>%
        stringr::str_split("/") %>% 
        purrr::pluck(1,2)) %>%
    dplyr::mutate(number_koans = purrr::map_int(lesson_file, function(x)
        getParseData(parse(file = x)) %>%
        dplyr::filter(text == "test_that") %>%
        nrow)) %>%
    dplyr::mutate(cumulative_koans = purrr::accumulate(number_koans, `+`)) %>%
    dplyr::mutate(test_file = lesson_file %>%
        stringr::str_replace("inst/koans/", "tests/testthat/") %>%
        stringr::str_replace("about", "test-about"))

usethis::use_data(koans_df, overwrite = T, internal = TRUE)
