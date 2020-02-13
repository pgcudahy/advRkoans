testthat::test_that("names have values", {
    x <- c(1, 2, 3)

    #R is creating an object, c(1,2,3), which is a vector of values,
    #and binding that object to a name, x

    expect_equal(c(1, 2, 3), x)
})

testthat::test_that("names can reference existing objects", {
    x <- c(1, 2, 3)
    y <- x

    #y isn't a copy of x, it's another binding to the existing object
    #You can access an object’s identifier with lobstr::obj_addr()

    expect_equal(lobstr::obj_addr(y), lobstr::obj_addr(x))
})

testthat::test_that("names with the same values can be different objects", {
    a <- 1:10
    b <- a
    c <- b
    d <- 1:10

    expect_equal(b, a)
    expect_equal(c, a)
    expect_equal(d, a)
    expect_equal(lobstr::obj_addr(b), lobstr::obj_addr(a))
    expect_equal(lobstr::obj_addr(c), lobstr::obj_addr(a))
    expect_false(lobstr::obj_addr(d) == lobstr::obj_addr(a))
})

testthat::test_that("many ways of accessing functions point to the same object", {

    mean_functions <- list(
        mean,
        base::mean,
        get("mean"),
        evalq(mean),
        match.fun("mean"))

    expect_equal(1, lobstr::obj_addrs(mean_functions) %>% unique %>% length)
})

#Non-syntactic names

testthat::test_that("names have rules", {

    #Syntactic names consist of letters, digits, . and _
    #but can’t begin with _ or a digit

    testthat::expect_error(eval(parse(text = "_abc <- 1")), 
        "unexpected input")

    #You can’t use any of the reserved words like TRUE, NULL, if, and function

    testthat::expect_error(eval(parse(text = "if <- 10")), 
        "unexpected assignment")

    #A name can also not start with a dot followed by a number

    testthat::expect_error(eval(parse(text = ".123e1 <- 1")), 
        "invalid (do_set) left-hand side to assignment", fixed=TRUE)
})

testthat::test_that("rules can be broken", {

    #Non-syntactic names can be created with backticks

    `_abc` <- 1
    `if` <- 10

    testthat::expect_equal(`_abc`, 1)
    testthat::expect_equal(`if`, 10)
})

testthat::test_that("double quotes are not a good option", {

    #Non-syntactic names can be also be created with double quotes

    "_abc" <- 5
    "if" <- 50

    #but need get() to retrieve the object

    testthat::expect_equal(get("_abc"), 5)
    testthat::expect_equal(get("if"), 50)
})

#To make imported names syntactic, base R data import functions,
#like read.csv() or data.frame(), will automatically convert non-syntactic names
#to syntactic names with make.names()

testthat::test_that("make.names() is irreversible", {

    #Variable names that do not start with a letter or start with
    #a dot followed by a number are prepended with "X"

    blank_name <- make.names("")

    expect_equal("X", blank_name)

    #Non-valid characters are replaced by a dot

    non_valid_name <- make.names("A@")

    expect_equal("A.", non_valid_name)

    #Reserved R keywords (see ?reserved) are suffixed by a dot

    keyword_name <- make.names("if")

    expect_equal("if.", keyword_name)

    #This can be turned off with "check.names = FALSE"

    df <- data.frame("if" = c(1, 2, 3))
    df2 <- data.frame("if" = c(1, 2, 3), check.names = FALSE)

    expect_equal("if.", names(df))
    expect_equal("if", names(df2))
})
