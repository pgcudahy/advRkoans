context("Binding basics and non-syntactic names")

testthat::test_that("names have values", {
  x <- c(1, 2, 3)
  expect_equal(`__`, x)
})

testthat::test_that("names can reference existing objects", {
  x <- c(1, 2, 3)
  y <- x

  #You can access an object’s identifier with lobstr::obj_addr()

  expect_equal(lobstr::obj_addr(`__`), lobstr::obj_addr(x))
})

testthat::test_that("names with the same values can be different objects", {
  a <- 1:10
  b <- a
  c <- b
  d <- 1:10

  expect_equal(`__`, `__`, `__`, a)
  expect_equal(`__`, `__`, lobstr::obj_addr(a))
  expect_false(`__` == lobstr::obj_addr(a))
})

testthat::test_that("many ways of accessing functions point to the same object", {

  mean_functions <- list(
    mean,
    base::mean,
    get("mean"),
    evalq(mean),
    match.fun("mean"))

  expect_equal(`__`, lobstr::obj_addrs(mean_functions) %>% unique %>% length)
})

#, Non-syntactic names

testthat::test_that("names have rules", {

  testthat::expect_error(eval(parse(text="_abc")), `__`)
})

#To make imported names syntactic, base R data import functions,
#like read.csv(), will automatically convert non-syntactic names
#to syntactic names with make.names() by
# 1) Prepending variable names that do not start with a letter or start with
# a dot followed by a number with "X"
# 2) Non-valid characters are replaced by a dot
# 3) Reserved R keywords (see ?reserved) are suffixed by a dot

testthat::test_that("make.names() is irreversible", {

  blank_name <- make.names("")

  expect_equal(`__`, blank_name)

  non_valid_name <- make.names("A@")

  expect_equal(`__`, non_valid_name)

  keyword_name <- make.names("if")

  expect_equal(`__`, keyword_name)

})
