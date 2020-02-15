#' Ordered list of the lessons in advRkoans along with summary statistics
#'
#' @format A data frame with 2 rows and 3 variables:
#' \describe{
#'   \item{lesson_file}{relative location of the lesson file}
#'   \item{lesson_base}{basename of lesson file}
#'   \item{lesson_directory}{path of lesson file from project root}
#'   \item{number_koans}{number of koans in the lesson}
#'   \item{cumulative_koans}{number of cumulative koans through that lesson}
#'   \item{test_file}{relative location of the test file}
#' }
"koans_df"