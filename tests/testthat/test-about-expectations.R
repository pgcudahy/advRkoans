# Works with devtools::test() but not devtools::check()
# tests  <- parse("/about-expectations.R")
# answers <- parse("/answers.R")
# eval(answers[[1]])

# eval(parse(text=stringr::str_replace(string=as.character(
#     tests[1]), "`_*_`", as.character(about_expectations[[1]]))))