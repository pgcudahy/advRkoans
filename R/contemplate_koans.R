
#Need to consider the different options at
#https://stackoverflow.com/questions/12598242
#for loading global variables into a package

`__` <- "-=> FILL ME IN! <=-"

`___` <- "-=> TRUE OR FALSE? <=-"

`____` <- 0
 
#Need to set up a test runner to:
#run the tests in order
#give the trace for the failed test
#count passed tests
#also a feature to run named tests

#' Walk the path to R enlightenment
#'
#' \code{walk_the_path} runs tests within the lessons and provides feedback
#'
#' @export
walk_the_path <- function() {

    "Run the koan tests with a custom runner output."

    for (koan in koans_df$lesson_file) {
        testthat::test_file(koan, reporter = sensei)
        #Sensei throws a restart if a test fails
        #Let's catch it and stop parsing any new files
        withRestarts(break)
    }
}