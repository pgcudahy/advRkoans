testthat::test_that("names have values", {
    x <- c(1, 2, 3)

    #R is creating an object, c(1,2,3), which is a vector of values,
    #and binding that object to a name, x

    expect_equal(`__`, x)
})

testthat::test_that("names can reference existing objects", {
    x <- c(1, 2, 3)
    y <- x

    #y isn't a copy of x, it's another binding to the existing object
    #You can access an object’s identifier with lobstr::obj_addr()

    expect_equal(lobstr::obj_addr(`__`), lobstr::obj_addr(x))
})

testthat::test_that("names with the same values can be different objects", {
    a <- 1:10
    b <- a
    c <- b
    d <- 1:10

    expect_equal(`__`, a)
    expect_equal(`__`, a)
    expect_equal(`__`, a)
    expect_equal(`__`, lobstr::obj_addr(a))
    expect_equal(`__`, lobstr::obj_addr(a))
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

#Non-syntactic names

testthat::test_that("names have rules", {

    #Syntactic names consist of letters, digits, . and _
    #but can’t begin with _ or a digit

    testthat::expect_error(eval(parse(text = "_abc <- 1")), 
        `__`)

    #You can’t use any of the reserved words like TRUE, NULL, if, and function

    testthat::expect_error(eval(parse(text = "if <- 10")), 
        `__`)

    #A name can also not start with a dot followed by a number

    testthat::expect_error(eval(parse(text = ".123e1 <- 1")), 
        `__`)
})

testthat::test_that("rules can be broken", {

    #Non-syntactic names can be created with backticks

    `_abc` <- 1
    `if` <- 10

    testthat::expect_equal(`__`, 1)
    testthat::expect_equal(`__`, 10)
})

testthat::test_that("double quotes are not a good option", {

    #Non-syntactic names can be also be created with double quotes

    "_abc" <- 5
    "if" <- 50

    #but need get() to retrieve the object

    testthat::expect_equal(`__`, 5)
    testthat::expect_equal(`__`, 50)
})

#To make imported names syntactic, base R data import functions,
#like read.csv() or data.frame(), will automatically convert non-syntactic names
#to syntactic names with make.names()

testthat::test_that("make.names() is irreversible", {

    #Variable names that do not start with a letter or start with
    #a dot followed by a number are prepended with "X"

    blank_name <- make.names("")

    expect_equal(`__`, blank_name)

    #Non-valid characters are replaced by a dot

    non_valid_name <- make.names("A@")

    expect_equal(`__`, non_valid_name)

    #Reserved R keywords (see ?reserved) are suffixed by a dot

    keyword_name <- make.names("if")

    expect_equal(`__`, keyword_name)

    #This can be turned off with "check.names = FALSE"

    df <- data.frame("if" = c(1, 2, 3))
    df2 <- data.frame("if" = c(1, 2, 3), check.names = FALSE)

    expect_equal(`__`, names(df))
    expect_equal(`__`, names(df2))
})