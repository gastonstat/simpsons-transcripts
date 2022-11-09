# Title: Assemble output table of transcripts
# Description: Assembling table of transcripts
# Inputs: 
# - episode-titles.csv file
# - episode transcript txt files
# Output:
# - assembled field-separated text file 
# (caret "^" used as field separator)
#
# Author: Gaston Sanchez


# packages
library(tidyverse)


# -----------------------------------------------
# Extracting transcripts content
# -----------------------------------------------
# collapse the text of each episode transcript
# and store it into a character vector to be 
# added as the new column of the assembled table 'dat'

dir_scripts = "../transcript_files/"
txt_files = dir(dir_scripts)

# output vectors
num_files = length(txt_files)
season_vec = rep("", num_files)
episode_vec = rep("", num_files)
title_vec = rep("", num_files)
content_vec = rep("", num_files)


for (i in seq_along(txt_files)) {
  txt_file = paste0(dir_scripts, txt_files[i])
  print(txt_file)

  txt_content_spread = readLines(txt_file)
  
  # extract episode information
  season_vec[i] = str_extract(txt_content_spread[1], "\\d+$")
  episode_vec[i] = str_extract(txt_content_spread[2], "\\d+$")
  title_vec[i] = str_remove(txt_content_spread[3], "^title: ")
  
  # transcript content (collapsed into a single string)
  txt_content_merged = txt_content_spread[-c(1:5)] %>%
    paste(collapse = " ") %>%
    str_replace_all(pattern = "♪+", replacement = " ") %>%
    str_replace_all(pattern = "\"", replacement = "'") %>%
    str_replace_all(pattern = "\\s\\s+", replacement = " ")
  
  content_vec[i] = txt_content_merged
}


# add column year: based on the year in which the first episode
# of a given season was aired
episodes_per_season = as.vector(table(season_vec))
year_vec = rep(1989:2021, times = episodes_per_season)


# assemble data frame
dat = data.frame(
  "year" = year_vec,
  "season" = season_vec,
  "episode" = episode_vec,
  "title" = title_vec,
  "text" = content_vec
)


# export it to "data/" directory
write.table(
  x = dat, 
  sep = "^",
  file = "../data/simpsons-transcripts.txt", 
  row.names = FALSE)

