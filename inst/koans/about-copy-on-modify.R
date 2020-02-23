testthat::test_that("R performs copy-on-modify", {
    x <- c(1, 2, 3)
    y <- x

    # Modifying y should not modify x, even though they're bound
    # to the same object. So R copies y to a new address

    y[[3]] <- 4

    testthat::expect_false(`___` == lobstr::obj_addr(x))
})

testthat::test_that("tracemem() can show when an object is copied", {

    x <- c(1, 2, 3)
    tracemem(x)

    # Whenever the object is copied, tracemem() will print a message
    # reporting the object being copied and the new object being created,
    # starting with the string "tracemem"

    y <- x

    testthat::expect_output(y[[3]] <- 4L, `___`)

    # Further modifications to y won't be reported, since y is now
    # bound to a new object and tracemem() is following x

    testthat::expect_output(y[[3]] <- 5L, `___`)

    # Use untracemem() to turn tracing off

    untracemem(x)
})

testthat::test_that("tracemem is not useful on unnamed objects", {

    # Calling `1:10` creates an object in memory
    # > lobstr::obj_addr(1:10)
    # [1] "0x7fde066c4298"

    # But without a name to reference it, the object cannot be called
    # or manipulated from R and no copies will be made

    tracemem(1:10)
    testthat::expect_output(1:10 * 2, `___`)
    untracemem(1:10)
})

testthat::test_that("modifying a vector element triggers a copy", {

    x <- 1:3

    # > typeof(x)
    # [1] "integer"

    tracemem(x)

    # Modifying an element of x will trigger a copy

    output1 <- capture.output(x[[3]] <- 5L)

    # > typeof(x)
    # [1] "integer"

    testthat::expect_length(output1, `___`)

    # Changing a value's type triggers two copies

    x <- 1:3
    tracemem(x)
    output2 <- capture.output(x[[3]] <- 4.4)

    # > typeof(x)
    # [1] "double"

    testthat::expect_length(output2, `___`)

    untracemem(x)
})

testthat::test_that("copy-on-modify applies to function calls", {

    f <- function(a) {
        a
    }
    x <- c(1, 2, 3)
    tracemem(x)

    # Once f() completes, x and z will point to the same object.
    # x never gets copied because it never gets modified

    testthat::expect_output(y <- f(x), `___`)

    f2 <- function(a) {
        a[[3]] <- 55
        return(a)
    }

    # f2() does modify its argument

    testthat::expect_output(z <- f2(x), `___`)

    untracemem(x)
})

testthat::test_that("elements of lists point to values", {

    list1 <- list(1, 2, 3)

    # Use lobstr::ref() to see a representation of
    # the memory address of each object within a list
    # > lobstr::ref(list1)
    # █ [1:0x7f9fed34fc68] <list>
    # ├─[2:0x7f9fecfeae50] <dbl>
    # ├─[3:0x7f9fecd672c8] <dbl>
    # └─[4:0x7f9fecfeade0] <dbl>

    # Which addresses will be the same, and which different after a list
    # element is changed?
    # Use lobstr::obj_addrs() to get the addresses of the
    # components of lists, environments, or character vectors

    list1 <- list(1, 2, 3)
    element1_address <- lobstr::obj_addrs(list1)[[1]]
    element2_address <- lobstr::obj_addrs(list1)[[2]]

    list1[[2]] <- 4
    new_element1_address <- lobstr::obj_addrs(list1)[[1]]
    new_element2_address <- lobstr::obj_addrs(list1)[[2]]

    testthat::expect_true(`___` == element1_address)
    testthat::expect_false(`___` == element2_address)
})

testthat::test_that("lists are shallow copies", {

    list1 <- list(1, 2, 3)

    list2 <- list1

    # The list object and its bindings are copied,
    # but the values pointed to by the bindings are not

    list2[[3]] <- 4

    # Which addresses will be the same, and which different after a list
    # is copied and one element is changed?

    list1_element1_address <- lobstr::obj_addrs(list1)[[1]]
    list1_element2_address <- lobstr::obj_addrs(list1)[[2]]
    list1_element3_address <- lobstr::obj_addrs(list1)[[3]]

    list2_element1_address <- lobstr::obj_addrs(list2)[[1]]
    list2_element2_address <- lobstr::obj_addrs(list2)[[2]]
    list2_element3_address <- lobstr::obj_addrs(list2)[[3]]

    testthat::expect_true(`___` == list1_element1_address)
    testthat::expect_true(`___` == list1_element2_address)
    testthat::expect_false(`___` == list1_element3_address)
})

testthat::test_that("lists can nest shallow copies", {
    a <- 1:10
    b <- list(a, a)
    c <- list(b, a, 1:10)

    # What is the relationship between a and b?

    testthat::expect_reference(`___`, a)

    # What is the relationship between a and c?

    testthat::expect_reference(`___`, a)

    # What is the relationship between b and c?

    testthat::expect_reference(`___`, b)
})

testthat::test_that("lists can reference themselves", {

    x <- list(1:10)
    x_ref <- lobstr::obj_addrs(x)

    # What happens when you assign x to itself

    x[[2]] <- x

    testthat::expect_equal(lobstr::obj_addrs(`___`), x_ref)
})

testthat::test_that("data frames are lists of vectors", {

    d1 <- data.frame(x = c(1, 5, 6), y = c(2, 4, 3))
    d2 <- d1

    # If you modify a column, only that column needs to be modified

    d2$y <- d2$y * 2

    testthat::expect_reference(`___`, d1$x)
    testthat::expect_false(`___` == lobstr::obj_addr(d1$y))

    # If you modify a row, every column is modified

    d3 <- d1
    d3[1, ] <- d3[1, ] * 3

    testthat::expect_equal(`___`, unname(lobstr::ref(d1) == lobstr::ref(d3)))
})

testthat::test_that("a character vector is a vector of strings,
    not individual characters", {

        # R uses a global string pool where each element of a character vector
        # is a pointer to a unique string in the pool

        x <- c("a", "a", "abc", "d")

        # You can request that ref() show these references by setting
        # the character argument to TRUE
        # > lobstr::ref(x, character = TRUE)
        # █ [1:0x7ff6fdfafe68] <chr>
        # ├─[2:0x7ff6fb0594c0] <string: "a">
        # ├─[2:0x7ff6fb0594c0]
        # ├─[3:0x7ff6fdba5d20] <string: "abc">
        # └─[4:0x7ff6fc145ff0] <string: "d">

        y <- c("abc", "a")

        # y was not copied from x. Yet they share references
        testthat::expect_equal(`___`, lobstr::obj_addrs(x)[1])
        testthat::expect_equal(`___`, lobstr::obj_addrs(x)[3])
})