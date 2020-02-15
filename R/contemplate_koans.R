
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
walk_the_path <- function() {

    "Run the koan tests with a custom runner output."
    #Maybe use testthat::test_dir instead to avoid restarts ugliness,
    #but would have to order the tests
    for (koan in advRkoans:::koans_df$lesson_file) {
        testthat::test_file(koan, reporter = sensei)
        #Sensei throws a restart if a test fails
        #Let's catch it and stop parsing any new files
        withRestarts(break)
    }
}