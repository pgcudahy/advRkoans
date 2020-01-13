test_that("names have values", {
  x <- c(1, 2, 3)
  expect_equal(NA_integer_, x)
  #c(1,2,3)
})

test_that("names can reference existing objects", {
  x <- c(1, 2, 3)
  y <- x

  # You can access an object’s identifier with lobstr::obj_addr()

  expect_equal("a", lobstr::obj_addr(x))
  #lobstr::obj_addr(y)
})

test_that("names have rules"), {
  _abc <- 1
  #Need to look up how to test for errors
}
