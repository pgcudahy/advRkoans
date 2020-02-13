answers <- list(
    about_expectations = list(
        "expect truth" = c("TRUE"),
        "expect with messages" = c("TRUE"),
        "fill in values" = c("2"),
        "expect equality" = c("expected_value"),
        "a better way of asserting equality" = c("expected_value")),
    about_binding_basics = list(
        "names have values" = c("c(1, 2, 3)"),
        "names can reference existing objects" = c("y"),
        "names can reference existing objects" = c("b", "c", "d",
            "lobstr::obj_addr(b)", "lobstr::obj_addr(c)",
            "lobstr::obj_addr(d)"),
        "many ways of accessing functions point to the same object" = c("1"),
        "names have rules" = c('"unexpected input"', '"unexpected assignment"',
            '"invalid (do_set) left-hand side to assignment", fixed=TRUE'),
        "rules can be broken" = c("`_abc`", "`if`"),
        "double quotes are not a good option" = c('get("_abc")', 'get("if")'),
        "make.names() is irreversible" = 
            c('"X"', '"A."', '"if."', '"if."', '"if"')))

generate_tests <- function() {
    lessons <- koans_df$lesson_file
    tests <- purrr::map(lessons, function(x) readChar(x, file.info(x)$size))
    new_tests <- purrr::map2(tests, answers,
        function(x, y) purrr::reduce(as.vector(unlist(y)),
        function(a, b) sub("`_*_`", b, a), .init = x))
    purrr::map2(new_tests, koans_df$test_file,
        function(x, y) writeLines(x, con = y))
}