set.seed(474444)

# Load packages ----------------------------------------------------------------

library(openintro)
library(infer)
library(readr)

# Create data frame of permuted differences in promotion rates -----------------

gender_discrimination_perm <- gender_discrimination |>
  specify(decision ~ gender, success = "promoted") |>
  hypothesize(null = "independence") |>
  generate(reps = 1000, type = "permute") |>
  calculate(stat = "diff in props", order = c("male", "female"))

# Create big data - x10 --------------------------------------------------------

gender_discrimination_big <- data.frame(
  decision = c(rep("promoted", 350), rep("not_promoted", 130)),
  gender = c(rep("male", 210), rep("female", 140), rep("male", 30), rep("female", 100))
)

# Create small data - /2 -------------------------------------------------------

gender_discrimination_small <- data.frame(
  decision = c(rep("promoted", 12), rep("not_promoted", 4)),
  gender = c(rep("male", 7), rep("female", 5), rep("male", 1), rep("female", 3))
)

# Permute big and small data ---------------------------------------------------

gender_discrimination_big_perm <- gender_discrimination_big |>
  specify(decision ~ gender, success = "promoted") |>
  hypothesize(null = "independence") |>
  generate(reps = 1000, type = "permute") |>
  calculate(stat = "diff in props", order = c("male", "female"))

gender_discrimination_small_perm <- gender_discrimination_small |>
  specify(decision ~ gender, success = "promoted") |>
  hypothesize(null = "independence") |>
  generate(reps = 1000, type = "permute") |>
  calculate(stat = "diff in props", order = c("male", "female"))

# Create new data frame --------------------------------------------------------

gender_discrimination_new <- data.frame(
  decision = c(rep("promoted", 35), rep("not_promoted", 13)),
  gender = c(rep('male',18), rep('female',17), rep('male',6), rep('female',7))
)

# Permute new data frame -------------------------------------------------------

gender_discrimination_new_perm <- gender_discrimination_new |>
  specify(decision ~ gender, success = "promoted") |>
  hypothesize(null = "independence") |>
  generate(reps = 1000, type = "permute") |>
  calculate(stat = "diff in props", order = c("male", "female"))

# Save everything --------------------------------------------------------------

write_rds(gender_discrimination_big,
          path = "05-introduction-to-statistical-inference/02-lesson/data/gender_discrimination_big.rds")

write_rds(gender_discrimination_big_perm,
          path = "05-introduction-to-statistical-inference/02-lesson/data/gender_discrimination_big_perm.rds")

write_rds(gender_discrimination_new,
          path = "05-introduction-to-statistical-inference/02-lesson/data/gender_discrimination_new.rds")

write_rds(gender_discrimination_new_perm,
          path = "05-introduction-to-statistical-inference/02-lesson/data/gender_discrimination_new_perm.rds")

write_rds(gender_discrimination_small,
          path = "05-introduction-to-statistical-inference/02-lesson/data/gender_discrimination_small.rds")

write_rds(gender_discrimination_small_perm,
          path = "05-introduction-to-statistical-inference/02-lesson/data/gender_discrimination_small_perm.rds")

write_rds(gender_discrimination_perm,
          path = "05-introduction-to-statistical-inference/02-lesson/data/gender_discrimination_perm.rds")