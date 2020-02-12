total_lessons <- list.files(".", pattern = "^about.+R$", recursive = TRUE) %>%
    length
total_koans <- purrr::map(
    list.files(".", pattern = "^about.+R$", recursive = TRUE),
        function(x) getParseData(parse(file = x)) %>%
            dplyr::filter(text == "test_that") %>%
            nrow) %>%
    purrr::reduce(sum)

count_progress <- function(current_koan) {
    data <- getParseData(parse(file = current_koan))
    function_names <- data$text[which(data$token=="SYMBOL_FUNCTION_CALL")]
    occurrences <- data.frame(table(function_names))
    result <- occurrences$Freq
    names(result) <- occurrences$function_names
    result
}

# Need
#total number of koans
#number of current koan
#total number of lessons in current koan
#passed lessons in current koan