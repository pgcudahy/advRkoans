# advRkoans
advRkoans is an interactive tutorial for learning advanced R programming language by making tests pass. 
Following Hadley Wickham's [Advanced R](https://adv-r.hadley.nz/). 
Inspired by Greg Malcom's [Python Koans](https://github.com/gregmalcolm/python_koans), 
which are in turn inspired by Edgecase's [Ruby Koans](http://rubykoans.com/).

<img src="man/images/screenshot.png" width="512">

## Getting started
```
pgcudahy$ git clone https://github.com/pgcudahy/advRkoans
Cloning into 'advRkoans'...
remote: Enumerating objects: 40, done.
remote: Counting objects: 100% (40/40), done.
remote: Compressing objects: 100% (29/29), done.
remote: Total 40 (delta 6), reused 37 (delta 5), pack-reused 0
Unpacking objects: 100% (40/40), done.
pgcudahy$ cd advRkoans/
pgcudahy$ R
> devtools::load_all(".")
Loading advRkoans
> walk_the_path()
══ Thinking about expectations ═════════════════════════════════════════════════
   expect truth has damaged your karma

You have not yet reached enlightenment ...
   -=> TRUE OR FALSE? <=- isn't true.

Please meditate on the following code:
   koans/about-expectations.R#5:1
     testthat::expect_true(`___`)
Wubba lubba dub dub

> 
```
Most tests are *fixed* by filling the missing parts of `expect` functions. Eg:
```
    testthat::expect_equal(`__`, 1+2)
```
which can be fixed by replacing the __ part with the appropriate code:
```
    testthat::expect_equal(3, 1+2))
```
