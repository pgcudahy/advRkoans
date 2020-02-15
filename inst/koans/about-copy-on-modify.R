testthat::test_that("R performs copy-on-modify", {
    x <- c(1, 2, 3)
    y <- x

    #Modifying y should not modify x, even though they're bound
    #to the same object. So R creates a new object

    y[[3]] <- 4

    testthat::expect_false(`___` == lobstr::obj_addr(x))
})

testthat::test_that("tracemem() can show when an object is copied", {

    x <- c(1, 2, 3)
    tracemem(x)

    #Whenever the object is copied, tracemem() will print a message
    #reporting the object being copied and the new object being created,
    #starting with the string "tracemem"
    y <- x

    testthat::expect_output(y[[3]] <- 4L, "^tracemem")

    #Further modifications to y, won't be reported, since it is now
    #bound to a new object

    testthat::expect_output(y[[3]] <- 5L, NA)

    #Use untracemem() to turn tracing off

    untracemem(x)
})

testthat::test_that("the same rules apply to function calls", {

    f <- function(a) {
        a
    }
    x <- c(1, 2, 3)
    tracemem(x)

    #Running f() does not modify x

    testthat::expect_output(y <- f(x), NA)

    f2 <- function(a) {
        a[[3]] <- 55
        return(a)
    }

    testthat::expect_output(z <- f2(x), "^tracemem")

    #Use untracemem() to turn tracing off

    untracemem(x)
})