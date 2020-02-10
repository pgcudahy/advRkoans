# advRkoans
advRkoans is an interactive tutorial for learning advanced R programming language by making tests pass. 
Following Hadley Wickham's [Advanced R](https://adv-r.hadley.nz/). 
Inspired by Greg Malcom's [Python Koans](https://github.com/gregmalcolm/python_koans), 
which are in turn inspired by Edgecase's [Ruby Koans](http://rubykoans.com/).

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

R version 3.6.0 (2019-04-26) -- "Planting of a Tree"
Copyright (C) 2019 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin15.6.0 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

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
