#Help users to walk the path to the mountain

sensei <- R6::R6Class("sensei",
  inherit = Reporter,
  public = list(
    koan_name = NULL,
    failures = NULL,

    initialize = function() {
      super$initialize()
      self$failures <- testthat:::Stack$new()
    },

    start_file = function(file) {
      self$koan_name <- file %>%
        stringr::str_replace("-", " ") %>%
        stringr::str_remove(".R$")
      self$rule(paste("Thinking", self$koan_name), line = 2)
    },

    end_test = function(context, test) {
      failures <- self$failures$as_list()

      if (length(failures) == 0) {
        return()
      }
      # reset failures for next test
      self$failures$initialize()
      #Replace output with a function to count how many tests passed
      self$cat_line("Wubba lubba dub dub\n")
      invokeRestart("testthat_abort_reporter")
    },

    add_result = function(context, test, result) {
      if (testthat:::expectation_success(result)) {
        self$cat_line(crayon::green$bold(paste("  ", test,
          "has expanded your awareness")))
        return()
      }

      self$failures$push(result)
      ref <- result$srcref
      if (is.null(ref)) {
        location <- "?#?:?"
      } else {
        location <- paste0(attr(ref, "srcfile")$filename, "#", ref[1], ":1")
      }
      message <- result$message %>%
        stringr::str_replace("`__`", "-=> FILL ME IN! <=-") %>%
        stringr::str_replace("`___`", "-=> TRUE OR FALSE? <=-") %>%
        stringr::str_replace("`____`", "0") %>%
        stringr::str_replace("\n", "\n  ")

      self$cat_line(crayon::red$bold("  ", test, "has damaged your karma"))
      self$cat_line("\nYou have not yet reached enlightenment ...")
      self$cat_line(crayon::red$bold("  ", message))
      self$cat_line("\nPlease meditate on the following code:")
      self$cat_line(crayon::blue$bold("  ", location))
      self$cat_line(crayon::yellow$bold("    ", ref))
    }
  )
)

#, Need to include overall report (eg from pytonkoans)
#, You have completed 63 (20 %) koans and 7 (out of 37) lessons.
#, You are now 239 koans and 30 lessons away from reaching enlightenment.

#, Although that way may not be obvious at first unless you're Dutch.