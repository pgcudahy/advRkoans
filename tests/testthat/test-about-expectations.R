testthat::test_that("expect truth", {

    #We shall contemplate truth by testing reality, via expectations.

    testthat::expect_true(TRUE) # This should be TRUE
})

testthat::test_that("expect with messages", {

    #Enlightenment may be more easily achieved with appropriate messages.

    testthat::expect_true(TRUE, "This should be True -- Please fix this")
})

testthat::test_that("fill in values", {

    #Sometimes we will ask you to fill in the values.

    testthat::expect_equal(2, 1 + 1)
})

testthat::test_that("expect equality", {

    #To understand reality, we must compare our expectations against reality.

    expected_value <- 2
    actual_value <- 1 + 1
    testthat::expect_true(expected_value == actual_value)
})

testthat::test_that("a better way of asserting equality", {

    #Some ways of asserting equality are better than others.

    expected_value <- 2
    actual_value <- 1 + 1

    testthat::expect_equal(expected_value, actual_value)
})
