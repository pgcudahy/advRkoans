report_statistics <- function(koans_passed, lessons_passed, result) {
    completed_koans <- koans_passed + length(result)
    total_koans <- utils::tail(koans_df$cumulative_koans, n = 1)
    percent_complete_koans <- floor((completed_koans / total_koans) * 100)
    remaining_koans <- total_koans - completed_koans
    total_lessons <- nrow(koans_df)
    remaining_lessons <- total_lessons - lessons_passed
    cat(paste("\nYou have completed ", completed_koans, " (",
        percent_complete_koans, "%) koans and ", lessons_passed,
        " (out of ", total_lessons, ") lessons.\n",
        "You are now ", remaining_koans, " koans and ",
        remaining_lessons, " lessons away from reaching enlightnment\n",
        sep = ""))
}

#You have completed 63 (20 %) koans and 7 (out of 37) lessons.
#You are now 239 koans and 30 lessons away from reaching enlightenment.