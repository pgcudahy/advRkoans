
#Need to consider the different options at
#https://stackoverflow.com/questions/12598242
#for loading global variables into a package

`__` <- "-=> FILL ME IN! <=-"

`___` <- "-=> TRUE OR FALSE? <=-"

`____` <- 0
 

#TODO: Needs a feature to run named lessons

#' Walk the path to R enlightenment
#'
#' \code{walk_the_path} runs tests within the lessons and provides feedback
#'
#' @export
walk_the_path <- function(df = koans_df,
                          koans_passed = 0,
                          lessons_passed = 0) {
    file <- system.file(df$lesson_directory[[1]],
                        df$lesson_base[[1]],
                        package = "advRkoans")
    result <- testthat::test_file(file, reporter = sensei)
    if(length(result) == df$number_koans[[1]]) {
        if(nrow(df > 1)) {
            remaining_lessons <- df %>% dplyr::slice(-1)
            cat("\n")
            walk_the_path(df = remaining_lessons,
                          koans_passed = koans_passed + length(result),
                          lessons_passed = lessons_passed + 1)
        }
    }
    else {
        report_statistics(koans_passed, lessons_passed, result)
    }
}
