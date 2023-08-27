# load packages ----------------------------------------------------------------

library(fs)
library(rsconnect)
library(tidyverse)
library(glue)
library(rmarkdown)
library(shiny)

# check all indexes compile -------------------------------------------------------

indexes <- dir_info(recurse = 2, glob = "*x.Rmd") |> pull(path)
walk(indexes, render)

# check all tutorials compile --------------------------------------------------

rmds      <- dir_info(recurse = 2, glob = "*.Rmd")
indexes   <- dir_info(recurse = 2, glob = "*x.Rmd")
tutorials <- anti_join(rmds, indexes, by = "path") %>% pull(path)
# walk(tutorials, run_tutorial) -- doesn't work, need a way to shut down each tutorial

# get a list of directories ----------------------------------------------------

tutorial_dirs <- dir_info(recurse = 1) %>%
  filter(
    type == "directory",
    str_detect(path, "/"),
    str_detect(path, "lesson")
    ) %>%
  pull(path)

# tutorials to deploy ----------------------------------------------------------

which_tutorials <- 1
which_tutorials_chr <- paste0("0", which_tutorials)
which_tutorials_regex <-paste0("^", which_tutorials_chr, collapse = "|")
dirs_to_deploy <- str_subset(tutorial_dirs, which_tutorials_regex)

# lessons ----------------------------------------------------------------------

tutorials <- tibble(dir_to_deploy = dirs_to_deploy, lesson = dirs_to_deploy) %>%
  separate(col = lesson, into = c("tutorial", "lesson"), sep = "/") %>%
  mutate(lesson = str_remove(lesson, "-lesson")) %>%
  mutate(title = glue("ims-{tutorial}-{lesson}"))

# deploy all -------------------------------------------------------------------

for(i in 1:length(dirs_to_deploy)){
#for(i in 3:3){
  deployApp(
    appDir = tutorials$dir_to_deploy[i],
    appTitle = tutorials$title[i],
    account = "openintro",
    forceUpdate = TRUE,
    launch.browser = FALSE
  )
}
